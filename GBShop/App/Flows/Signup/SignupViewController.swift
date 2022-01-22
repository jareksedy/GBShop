//
//  SignupViewController.swift
//  GBShop
//
//  Created by Ярослав on 18.12.2021.
//

import UIKit
import FirebaseCrashlytics

class SignupViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var formStackView: UIStackView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
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
    
    private func setupControls() {
        signupButton.backgroundColor = UIColor.opaqueSeparator
        signupButton.isEnabled = false
        
        [firstNameTextField, lastNameTextField, emailTextField, loginTextField, passwordTextField, bioTextField].forEach {
            $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        }
    }
    
    private func isFormFilled() -> Bool {
        guard firstNameTextField.text != "",
              lastNameTextField.text != "",
              emailTextField.text != "",
              loginTextField.text != "",
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
            signupButton.backgroundColor = UIColor.opaqueSeparator
            signupButton.isEnabled = false
            return
        }
        
        signupButton.backgroundColor = UIColor.systemOrange
        signupButton.isEnabled = true
    }
    
    // MARK: -- Success & Error Messages.
    private func showSuccessScreen() {
        let signupSuccessViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignupSuccessViewController") as! SignupSuccessViewController
        
        signupSuccessViewController.modalPresentationStyle = .fullScreen
        self.present(signupSuccessViewController, animated: true, completion: nil)
    }
    
    private func showError(_ errorMessage: String) {
        let alert = UIAlertController(title: "Ошибка сервера", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Окей", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: -- Actions.
    @IBAction func signupButtonTapped(_ sender: Any) {
        
        signupButton.backgroundColor = UIColor.opaqueSeparator
        signupButton.isEnabled = false
        
        let factory = requestFactory.makeSignupRequestFactory()
        let user = User(login: loginTextField.text,
                        password: passwordTextField.text,
                        email: emailTextField.text,
                        gender: genderSegmentedControl.selectedSegmentIndex == 0 ? "M" : "F",
                        bio: bioTextField.text,
                        name: firstNameTextField.text,
                        lastname: lastNameTextField.text)
        
        factory.signup(user: user) { response in
            DispatchQueue.main.async {
                logging(LogMessage.funcStart)
                logging(response)
                
                switch response.result {
                case .success(let success): success.result == 1 ? self.showSuccessScreen() : self.showError(success.errorMessage ?? "Неизвестная ошибка.")
                case .failure(let error): self.showError(error.localizedDescription)
                }
                
                logging(LogMessage.funcEnd)
            }
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        emailTextField.text = ""
        genderSegmentedControl.selectedSegmentIndex = 0
        loginTextField.text = ""
        passwordTextField.text = ""
        bioTextField.text = ""
        
        signupButton.backgroundColor = UIColor.opaqueSeparator
        signupButton.isEnabled = false
    }
    
    // MARK: -- ViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        setupControls()
        registerNotifications()
    }
}
