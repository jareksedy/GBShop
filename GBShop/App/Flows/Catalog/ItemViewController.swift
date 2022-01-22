//
//  ItemViewController.swift
//  GBShop
//
//  Created by Ярослав on 27.12.2021.
//

import UIKit
import AlamofireImage
import FirebaseCrashlytics

class ItemViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var itemStackView: UIStackView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemPic: UIImageView!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    let factory = RequestFactory()
    var productId: Int?
    var product: GoodResponse?
    
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
    
    private func showAddToCartSuccessAlert() {
        let alert = UIAlertController(title: "Корзина", message: "Товар успешно добавлен в корзину.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Окей", style: .default, handler: nil)
        action.accessibilityIdentifier = "ok_button"
        alert.addAction(action)
        alert.view.accessibilityIdentifier = "cart_alert"
        alert.view.accessibilityValue = "Item was added to cart."
        self.present(alert, animated: true, completion: nil)
    }
    
    private func getItem(completionHandler: @escaping (GoodResponse) -> Void) {
        guard let productId = productId else {
            Crashlytics.crashlytics().log("productId is nil!")
            return
        }
        
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
        let authViewController = self.storyboard?.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
        navigationController?.pushViewController(authViewController, animated: true)
    }
    
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        guard let product = product else {
            Crashlytics.crashlytics().log("Product is nil!")
            return
        }
        
        let cartFactory = factory.makeCartRequestFactory()
        let request = CartRequest(productId: product.productId, quantity: 1)
        cartFactory.addToCart(cart: request) { response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    let item = AppCartItem(productId: product.productId, productName: product.productName, price: product.price, picUrl: product.picUrl)
                    AppCart.shared.items.append(item)
                    GALogger.logEvent(name: "Add to cart", key: "result", value: "success")
                    self.showAddToCartSuccessAlert()
                }
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getItem { good in
            DispatchQueue.main.async {
                self.product = good
                self.itemNameLabel.text = good.productName
                self.descriptionLabel.text = good.description
                if let price = good.price { self.itemPriceLabel.text = "\(price.formattedString) ₽" }
                
                GALogger.logEvent(name: "Item view", key: "item", value: self.product?.productName ?? "unknown")
                
                if let picUrl = good.picUrl, let goodUrl = URL(string: picUrl) {
                    self.itemPic.af.setImage(withURL: goodUrl)
                }
            }
        }
        
        setConstraints()
    }
}
