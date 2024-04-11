//
//  ViewController.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/10/24.
//

import UIKit

class CategoryListViewController: UITableViewController {
    private let viewModel = CategoryListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.viewModel.loadData()
        self.navigationItem.title = "Categorías"
    }
}

//MARK: - Extension
//MARK: - Extension ViewModelDelegate
extension CategoryListViewController: RequestCategoryListDelegate{
    func didUpdateCategoryList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error?) {
        self.present(error: error, customAction: UIAlertAction(title: "Reintentar", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.loadData()
        })){ _ in
            
        }
    }
}

//MARK: - Extension TableViewDataSource - TableViewDelegate
extension CategoryListViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfItems
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifierTitle) as? BasicTableViewCell
        if cell == nil {
            cell = BasicTableViewCell(style: .default, reuseIdentifier: K.cellIdentifierTitle)
        }
        cell?.configureTitleCategory(name: viewModel.getInfoList(for: indexPath).firstCapitalized)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
        vc.categoryName = viewModel.getInfoList(for: indexPath)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
