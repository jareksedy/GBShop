//
//  CartTableViewController.swift
//  GBShop
//
//  Created by Ярослав on 15.01.2022.
//

import UIKit

protocol CartDelegate {
    func deleteItem(_ index: Int)
}

extension CartTableViewController: CartDelegate {
    func deleteItem(_ index: Int) {
        guard let itemName = AppCart.shared.items[index].productName else { return }
        let cartFactory = factory.makeCartRequestFactory()
        let request = CartRequest(productId: index)
        let alert = UIAlertController(title: "Корзина", message: "Вы действительно хотите удалить \(itemName) из корзины?", preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "cart_alert"
        alert.view.accessibilityValue = "Do you want to remove the item from cart?"
        alert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { _ in
            AppCart.shared.items.remove(at: index)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: nil))
        
        cartFactory.deleteFromCart(cart: request) { response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}

class CartTableViewController: UITableViewController {
    @IBOutlet weak var totalLabel: UILabel!
    
    let factory = RequestFactory()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.topItem?.hidesBackButton = false
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @IBAction func toolbarProfileButtonTapped(_ sender: Any) {
        let editDataViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditDataViewController") as! EditDataViewController
        navigationController?.pushViewController(editDataViewController, animated: true)
    }
    
    @IBAction func checkOutButtonTapped(_ sender: Any) {
        let cartFactory = factory.makeCartRequestFactory()
        let user = User(id: 123)
        let alert = UIAlertController(title: "Корзина", message: "Спасибо за покупку!", preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "cart_alert"
        alert.view.accessibilityValue = "All items were paid."
        alert.addAction(UIAlertAction(title: "Окей", style: .default, handler: nil))
        
        cartFactory.payCart(user: user) { response in
            switch response.result {
            case .success:
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: {
                        AppCart.shared.items = []
                        self.tableView.reloadData()
                    })
                }
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func toolbarLogoutButtonTapped(_ sender: Any) {
        let authViewController = self.storyboard?.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
        navigationController?.pushViewController(authViewController, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if AppCart.shared.items.count == 0 {
            return 1
        } else {
            totalLabel.text = "\(AppCart.shared.items.count) товаров на сумму \(AppCart.shared.items.map{ $0.price! }.reduce(0, +).formattedString) ₽"
            return AppCart.shared.items.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if AppCart.shared.items.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Корзина пуста"
            self.tableView.tableFooterView = nil
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as? CartTableViewCell
            cell?.configure(AppCart.shared.items[indexPath.row])
            cell?.delegate = self
            cell?.row = indexPath.row
            
            return cell ?? UITableViewCell()
        }
    }
}
