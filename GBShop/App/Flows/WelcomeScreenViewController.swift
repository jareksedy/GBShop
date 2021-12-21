//
//  WelcomeScreenViewController.swift
//  GBShop
//
//  Created by Ярослав on 19.12.2021.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var formStackView: UIStackView!
    
    @IBOutlet weak var welcomeMessageLabel: UILabel!
    
    @IBOutlet weak var editDataButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    private func setConstraints() {
        self.scrollView.addSubview(formStackView)
        self.formStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.formStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.formStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.formStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.formStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
        self.formStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    // MARK: -- Actions.
    @IBAction func editDataButtonTapped(_ sender: Any) {
        let editDataViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditDataViewController") as! EditDataViewController
        navigationController?.pushViewController(editDataViewController, animated: true)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let authViewController = self.storyboard?.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
        navigationController?.pushViewController(authViewController, animated: true)
    }
    
    // MARK: -- ViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
    }
}
