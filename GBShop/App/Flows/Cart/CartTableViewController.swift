//
//  CartTableViewController.swift
//  GBShop
//
//  Created by Ярослав on 15.01.2022.
//

import UIKit

class CartTableViewController: UITableViewController {

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
            return AppCart.shared.items.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if AppCart.shared.items.count == 0 {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Корзина пуста"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell") as? CartTableViewCell
            cell?.configure(AppCart.shared.items[indexPath.row])
            return cell ?? UITableViewCell()
        }
    }
}
