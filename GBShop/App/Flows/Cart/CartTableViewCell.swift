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
    
    func configure(_ item: AppCartItem) {
        productName.text = item.productName
        productPrice.text = "\(item.price?.formattedString ?? "—") ₽"
        
        if let picUrl = item.picUrl, let itemUrl = URL(string: picUrl) {
            productImage.af.setImage(withURL: itemUrl)
        }
    }
}
