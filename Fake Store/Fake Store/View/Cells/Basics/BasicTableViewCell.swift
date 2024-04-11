//
//  BasicTableViewCell.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/10/24.
//

import UIKit

class BasicTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel?.text = nil
        self.detailTextLabel?.text = nil
    }
    
    func configureTitleCategory(name: String?) {
        self.textLabel?.text = name
        self.accessoryType = .disclosureIndicator
    }
    
    func configureTitle(_ title: String?){
        self.textLabel?.text = title
        self.textLabel?.font = .boldSystemFont(ofSize: 20)
        self.isUserInteractionEnabled = false
        self.textLabel?.numberOfLines = 0
    }
    
    func configurePrice(amount: String?){
        self.textLabel?.text = amount
        self.textLabel?.textColor = .red
        self.textLabel?.font = .boldSystemFont(ofSize: 16)
        self.isUserInteractionEnabled = false
    }
    
    func configureCategory(name: String?){
        self.textLabel?.text = "Categoría:"
        self.textLabel?.textColor = .black
        self.textLabel?.font = .boldSystemFont(ofSize: 16)
        self.detailTextLabel?.text = name?.firstCapitalized
        self.detailTextLabel?.textColor = .blue
        self.isUserInteractionEnabled = false
    }
    
    func configureDescription(text: String?){
        self.textLabel?.text = "Descripción:"
        self.textLabel?.textColor = .black
        self.textLabel?.font = .boldSystemFont(ofSize: 16)
        self.detailTextLabel?.text = text
        self.detailTextLabel?.textColor = .lightGray
        self.isUserInteractionEnabled = false
        self.detailTextLabel?.numberOfLines = 0
    }
}
