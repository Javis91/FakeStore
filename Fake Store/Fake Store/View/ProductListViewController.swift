//
//  ProductListViewController.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/10/24.
//

import UIKit

class ProductListViewController: UITableViewController {
    private let viewModel = ProductListViewModel()
    var categoryName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.delegate = self
        self.viewModel.loadDataList(with: self.categoryName)
        self.tableView.register(UINib(nibName: K.cellProductListNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifierProductList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = self.categoryName.firstCapitalized
    }
}


//MARK: - Extension
//MARK: - Extension ViewModelDelegate
extension ProductListViewController: RequestProductListDelegate{
    func didUpdateProductList() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(_ error: Error?) {
        self.present(error: error, customAction: UIAlertAction(title: "Reintentar", style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.loadDataList(with: self.categoryName)
        })){ _ in
            self.navigationController?.popViewController(animated: true)
        }
    }
}

//MARK: - Extension TableViewDataSource - TableViewDelegate
extension ProductListViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfItems
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifierProductList, for: indexPath) as! ProductListTableViewCell
        cell.configure(info: self.viewModel.getInfo(for: indexPath))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailProductTableViewController") as! DetailProductTableViewController
        vc.idProduct = self.viewModel.getInfo(for: indexPath).id!
        vc.categoryName = self.categoryName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
}

