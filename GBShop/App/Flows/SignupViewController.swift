//
//  SignupViewController.swift
//  GBShop
//
//  Created by Ярослав on 18.12.2021.
//

import UIKit

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
    
    private func setConstraints() {
        self.scrollView.addSubview(formStackView)
        self.formStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.formStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.formStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.formStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.formStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
        self.formStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
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
    
    // MARK: -- Actions.
    @IBAction func clearButtonTapped(_ sender: Any) {
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        emailTextField.text = ""
        genderSegmentedControl.selectedSegmentIndex = 0
        loginTextField.text = ""
        passwordTextField.text = ""
        bioTextField.text = ""
    }
    
    // MARK: -- ViewController methods.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
        registerNotifications()
    }
}
