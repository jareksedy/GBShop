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
    @IBOutlet weak var itemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ item: CatalogResponse) {
        itemNameLabel.text = item.productName ?? "Х/З"
        itemDescriptionLabel.text = item.shortDescription ?? "Х/З"
        itemPriceLabel.text = "\(item.price ?? 0) ₽"
        
        if let picUrl = item.picUrl, let itemUrl = URL(string: picUrl) {
            itemImage.af.setImage(withURL: itemUrl)
        }
    }
}
