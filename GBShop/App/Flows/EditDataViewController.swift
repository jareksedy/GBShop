//
//  EditDataViewController.swift
//  GBShop
//
//  Created by Ярослав on 19.12.2021.
//

import UIKit

class EditDataViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var formStackView: UIStackView!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bioTextField: UITextField!
    
    @IBOutlet weak var saveDataButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
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
        [loginTextField, passwordTextField, firstNameTextField, lastNameTextField, emailTextField, bioTextField].forEach {
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
        guard let userInfo = notification.userInfo else { return }
        
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
            saveDataButton.backgroundColor = UIColor.opaqueSeparator
            saveDataButton.isEnabled = false
            return
        }
        
        saveDataButton.backgroundColor = UIColor.systemOrange
        saveDataButton.isEnabled = true
    }
    
    // MARK: -- Actions.
    @IBAction func saveDataButtonTapped(_ sender: Any) {
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        let welcomeScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeScreenViewController") as! WelcomeScreenViewController
        navigationController?.pushViewController(welcomeScreenViewController, animated: true)
    }
    
    // MARK: -- ViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        setupControls()
        registerNotifications()
    }
}
