//
//  CatalogTableViewCell.swift
//  GBShop
//
//  Created by Ярослав on 25.12.2021.
//

import UIKit
import AlamofireImage

class CatalogTableViewCell: UITableViewCell {
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescriptionLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemPicture: RoundedImageView!

    func configure(_ item: CatalogResponse) {
        itemNameLabel.text = item.productName ?? "Х/З"
        itemDescriptionLabel.text = item.shortDescription ?? "Х/З"
        if let itemPrice = item.price {
            itemPriceLabel.text = "\(itemPrice.formattedString) ₽"
        } else {
            itemPriceLabel.text = "Х/З"
        }
        
        
        if let picUrl = item.picUrl, let itemUrl = URL(string: picUrl) {
            itemPicture.af.setImage(withURL: itemUrl)
        }
    }
}
