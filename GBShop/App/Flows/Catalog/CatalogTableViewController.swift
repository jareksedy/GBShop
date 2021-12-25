//
//  CatalogTableViewController.swift
//  GBShop
//
//  Created by Ярослав on 25.12.2021.
//

import UIKit

class CatalogTableViewController: UITableViewController {
    let requestFactory = RequestFactory()
    var catalog: [CatalogResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.dataSource = self
        
        let factory = requestFactory.makeGetCatalogRequestFactory()
        factory.getCatalog(pageNumber: 1, categoryId: 1) { response in
            switch response.result {
            case .success(let result):
                self.catalog = result
                DispatchQueue.main.async { self.tableView.reloadData() }
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { catalog.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatalogCell") as? CatalogTableViewCell
        cell?.configure(catalog[indexPath.row])
        return cell ?? UITableViewCell()
    }
}
