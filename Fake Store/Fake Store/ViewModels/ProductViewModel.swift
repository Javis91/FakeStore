//
//  SingleCategoryListViewModel.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/10/24.
//

import Foundation

protocol RequestProductDelegate: AnyObject {
    func didUpdateProduct()
    func didFailWithError(_ error: Error?)
}

final class ProductViewModel{
    weak var delegate: RequestProductDelegate?
    private var product: Product?
    
    //MARK: - Properties
    var title: String?{
        self.product?.title
    }
    
    var price: String?{
        self.product?.price?.formatterCurrency()
    }
    
    var description: String?{
        self.product?.description
    }
    
    var category: String?{
        self.product?.category
    }
    
    var image: String?{
        self.product?.image
    }
    
    var rate: Double?{
        self.product?.rating?.rate
    }
    
    var reviews: Int?{
        self.product?.rating?.count
    }
    
    //MARK: - Service
    func loadDataDetail(with id: Int, category: String?){
        ProductService.getSingleProduct(id: id) { result in
            switch result{
            case .success(let product):
                self.product = product
                self.delegate?.didUpdateProduct()
            case .failure:
                if let name = category{
                    self.loadDataListFile(filter: id, with: name)
                }else{
                    self.delegate?.didFailWithError(CustomError.noFile)
                }
            }
        }
    }
    
    //MARK: - File
    private func loadDataListFile(filter: Int, with category: String){
        ProductService.getCategoryListFile(name: category) { result in
            switch result{
            case .success(let products):
                if let product = products.first(where: {
                    $0.id == filter
                }){
                    self.product = product
                    self.delegate?.didUpdateProduct()
                }else{
                    self.delegate?.didFailWithError(CustomError.noData)
                }
            case .failure(let error):
                self.delegate?.didFailWithError(error)
            }
        }
    }
    
    
}
