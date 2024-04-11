//
//  ProductListTableViewCell.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/10/24.
//

import UIKit
import Kingfisher

class ProductListTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.productTitle.text = nil
        self.productPrice.text = nil
        self.productCategory.text = nil
        self.productDescription.text = nil
        self.productImage.image = nil
        
    }
    
    func configure(info: (id: Int?, title: String?, price: Double?, description: String?, category: String?, imageUrl: String?, rate: Double?, reviews: Int?)) {
        self.productTitle.text = info.title
        self.productPrice.text = info.price?.formatterCurrency()
        self.productDescription.text = info.description
        self.productCategory.text = info.category?.firstCapitalized
        guard let urlString = info.imageUrl,
        let imageURL = URL(string: urlString) else { return }
        self.productImage.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "placeHolder"))
    }
}
