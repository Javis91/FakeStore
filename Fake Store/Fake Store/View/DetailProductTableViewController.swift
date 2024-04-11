//
//  DetailProductTableViewController.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/10/24.
//

import UIKit

class DetailProductTableViewController: UITableViewController {
    private let viewModel = ProductViewModel()
    var idProduct: Int!
    var categoryName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.viewModel.loadDataDetail(with: self.idProduct, category: self.categoryName)
        self.tableView.register(UINib(nibName: K.cellImageNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifierImage)
    }
}

//MARK: - Extension
//MARK: - Extension ViewModelDelegate
extension DetailProductTableViewController: RequestProductDelegate{
    func didUpdateProduct() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error?) {
        self.present(error: error, customAction: UIAlertAction(title: "Reintentar", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.loadDataDetail(with: self.idProduct, category: self.categoryName)
        })){ _ in
            self.navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: - Extension TableViewDataSource - TableViewDelegate
extension DetailProductTableViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifierImage, for: indexPath) as! ImageTableViewCell
            cell.configure(with: self.viewModel.image)
            return cell
        }else if indexPath.row == 1{
            var cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifierTitle) as? BasicTableViewCell
            if cell == nil {
                cell = BasicTableViewCell(style: .default, reuseIdentifier: K.cellIdentifierTitle)
            }
            cell?.configureTitle(self.viewModel.title)
            return cell!
        }else if indexPath.row == 2{
            var cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifierPrice) as? BasicTableViewCell
            if cell == nil {
                cell = BasicTableViewCell(style: .default, reuseIdentifier: K.cellIdentifierPrice)
            }
            cell?.configurePrice(amount: self.viewModel.price)
            return cell!
        }else if indexPath.row == 3{
            var cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifierCategory) as? BasicTableViewCell
            if cell == nil {
                cell = BasicTableViewCell(style: .value1, reuseIdentifier: K.cellIdentifierCategory)
            }
            cell?.configureCategory(name: self.viewModel.category)
            return cell!
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifierDesc) as? BasicTableViewCell
            if cell == nil {
                cell = BasicTableViewCell(style: .subtitle, reuseIdentifier: K.cellIdentifierDesc)
            }
            cell?.configureDescription(text: self.viewModel.description)
            return cell!
        }
    }
}
