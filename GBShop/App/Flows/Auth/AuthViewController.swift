//
//  AuthViewController.swift
//  GBShop
//
//  Created by Ярослав on 18.12.2021.
//

import UIKit
import Alamofire
import FirebaseCrashlytics

class AuthViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var formStackView: UIStackView!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    let requestFactory = RequestFactory()
    
    private func setConstraints() {
        self.scrollView.addSubview(formStackView)
        self.formStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.formStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.formStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.formStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.formStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
        self.formStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    private func removeNavBar() {
        navigationController?.navigationItem.hidesBackButton = true
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupControls() {
        [loginTextField, passwordTextField].forEach {
            $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
    }
    
    private func isFormFilled() -> Bool {
        guard loginTextField.text != "",
              passwordTextField.text != "" else {
                  return false
              }
        return true
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // MARK: -- Selectors.
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            Crashlytics.crashlytics().log("userInfo is nil!")
            return
        }
        
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        var contentInset: UIEdgeInsets = self.scrollView.contentInset
        
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        contentInset.bottom = keyboardFrame.size.height + 50
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        guard isFormFilled() else {
            loginButton.backgroundColor = UIColor.opaqueSeparator
            loginButton.isEnabled = false
            return
        }
        
        loginButton.backgroundColor = UIColor.systemOrange
        loginButton.isEnabled = true
    }
    
    // MARK: -- Success & Error Messages.
    private func proceedToCatalog() {
        GALogger.logEvent(name: "login", key: "result", value: "success")
        
        let catalogTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "CatalogTableViewController") as! CatalogTableViewController
        navigationController?.pushViewController(catalogTableViewController, animated: true)
    }
    
    private func showError(_ errorMessage: String) {
        GALogger.logEvent(name: "login", key: "result", value: "failure")
        
        let alert = UIAlertController(title: "Ошибка авторизации", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Окей", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: -- Actions.
    @IBAction func loginButtonTapped(_ sender: Any) {
        let factory = requestFactory.makeAuthRequestFactory()
        let user = User(login: loginTextField.text, password: passwordTextField.text)
        
        loginButton.backgroundColor = UIColor.opaqueSeparator
        loginButton.isEnabled = false
        
        factory.login(user: user) { response in
            DispatchQueue.main.async {
                logging(LogMessage.funcStart)
                logging(response)
                
                switch response.result {
                case .success(let success): success.result == 1 ? self.proceedToCatalog() : self.showError(success.errorMessage ?? "Неизвестная ошибка.")
                case .failure(let error): self.showError(error.localizedDescription)
                }
                
                logging(LogMessage.funcEnd)
            }
        }
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        let signupViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.present(signupViewController, animated: true, completion: nil)
    }
    
    @IBAction func crashButtonTapped(_ sender: Any) {
        let numbers: [Int] = []
        let _ = numbers[1]
    }
    
    // MARK: -- ViewController methods.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        setupControls()
        registerNotifications()
    }
}
