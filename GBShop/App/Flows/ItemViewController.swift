//
//  ItemViewController.swift
//  GBShop
//
//  Created by Ярослав on 27.12.2021.
//

import UIKit
import AlamofireImage

class ItemViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var itemStackView: UIStackView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemPic: UIImageView!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    let factory = RequestFactory()
    var productId: Int?
    
    private func setNavigation() {
        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationItem.hidesBackButton = false
    }
    
    private func setConstraints() {
        self.scrollView.addSubview(itemStackView)
        self.itemStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.itemStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.itemStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.itemStackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.itemStackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
        self.itemStackView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
    }
    
    private func getItem(completionHandler: @escaping (GoodResponse) -> Void) {
        guard let productId = productId else { return }
        let goodFactory = factory.makeGetGoodRequestFactory()

        goodFactory.getGood(productId: productId) { response in
            switch response.result {
            case .success(let result): completionHandler(result)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func profileButtonTapped(_ sender: Any) {
        let editDataViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditDataViewController") as! EditDataViewController
        navigationController?.pushViewController(editDataViewController, animated: true)
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getItem { good in
            DispatchQueue.main.async {
                self.itemNameLabel.text = good.productName
                self.descriptionLabel.text = good.description
                if let price = good.price { self.itemPriceLabel.text = "\(price.formattedString) ₽" }
                
                if let picUrl = good.picUrl, let goodUrl = URL(string: picUrl) {
                    self.itemPic.af.setImage(withURL: goodUrl)
                }
            }
        }
        
        setConstraints()
    }
}
