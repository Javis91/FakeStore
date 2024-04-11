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

final class ProductListViewModel{
    weak var delegate: RequestProductListDelegate?
    private var products: [Product] = []
    
    //MARK: - DataSource List
    var numberOfItems: Int{
        self.products.count
    }
    
    func getInfo(for indexPath: IndexPath) -> (id: Int?, title: String?, price: Double?, description: String?, category: String?, imageUrl: String?, rate: Double?, reviews: Int?){
        let product = self.products[indexPath.row]
        return (id: product.id, title: product.title, price: product.price, description: product.description, category: product.category, imageUrl: product.image, rate: product.rating?.rate, reviews: product.rating?.count)
    }
    
    //MARK: - Service
    func loadDataList(with category: String){
        ProductService.getProductList(name: category) { result in
            switch result{
            case .success(let products):
                self.products = products
                self.setDataListFile(with: category, products: products)
                self.delegate?.didUpdateProductList()
            case .failure:
                self.loadDataListFile(with: category)
            }
        }
    }
    
    //MARK: - File
    private func loadDataListFile(with category: String){
        ProductService.getCategoryListFile(name: category) { result in
            switch result{
            case .success(let products):
                self.products = products
                self.delegate?.didUpdateProductList()
            case .failure(let error):
                self.delegate?.didFailWithError(error)
            }
        }
    }
    
    private func setDataListFile(with category: String, products: [Product]){
        ProductService.setCategoryListFile(name: category, list: products)
    }
}
