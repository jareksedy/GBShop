//
//  CartTableViewCell.swift
//  GBShop
//
//  Created by Ярослав on 15.01.2022.
//

import UIKit
import AlamofireImage

class CartTableViewCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productImage: RoundedImageView!
    
    var delegate: CartDelegate?
    var row: Int?
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        guard let row = row else { return }
        delegate?.deleteItem(row)
    }
    
    func configure(_ item: AppCartItem) {
        productName.text = item.productName
        productPrice.text = "\(item.price?.formattedString ?? "—") ₽"
        
        if let picUrl = item.picUrl, let itemUrl = URL(string: picUrl) {
            productImage.af.setImage(withURL: itemUrl)
        }
    }
}
