//
//  ImageTableViewCell.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/10/24.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with url: String?) {
        guard let urlString = url,
        let imageURL = URL(string: urlString) else { return }
        self.productImage.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "placeHolder"))
    }
}
