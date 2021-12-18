//
//  EditDataSuccessViewController.swift
//  GBShop
//
//  Created by Ярослав on 19.12.2021.
//

import UIKit

class EditDataSuccessViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var formStackView: UIStackView!
    
    @IBOutlet weak var proceedButton: UIButton!
    
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
    @IBAction func proceedButtonTapped(_ sender: Any) {
    }
    
    // MARK: -- ViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
    }
}
