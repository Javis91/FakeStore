//
//  SingleCategoryListViewModel.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/10/24.
//

import Foundation

protocol RequestProductListDelegate: AnyObject {
    func didUpdateProductList()
    func didFailWithError(_ error: Error?)
}

final class SingleCategoryViewModel{
    weak var delegate: RequestProductListDelegate?
    private var products: [String] = []
    
    //MARK: - DataSource
    var numberOfItems: Int{
        self.products.count
    }
    
    func getListInfo(for indexPath: IndexPath) -> String{
        let category = self.categories[indexPath.row]
        return category
    }
    
    //MARK: - Service
    func loadData(with category: String){
        ProductService.getSingleCategory(name: category) { result in
            switch result{
            case let .success(products):
                
            }
        }
    }
}
