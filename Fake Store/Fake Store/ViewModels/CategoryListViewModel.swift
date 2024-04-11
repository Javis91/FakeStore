//
//  CategoryListViewModel.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/10/24.
//

import Foundation
protocol RequestCategoryListDelegate: AnyObject {
    func didUpdateCategoryList()
    func didFailWithError(_ error: Error?)
}

final class CategoryListViewModel{
    weak var delegate: RequestCategoryListDelegate?
    private var categories: [String] = []
    
    //MARK: - DataSource
    var numberOfItems: Int{
        self.categories.count
    }
    
    func getInfoList(for indexPath: IndexPath) -> String{
        let category = self.categories[indexPath.row]
        return category
    }
    
    //MARK: - Service
    func loadData(){
        ProductService.getCategoryList { resul in
            switch resul{
            case .success(let categories):
                self.categories = categories
                UserDefault.shared.categoryList = categories
                self.delegate?.didUpdateCategoryList()
            case .failure(let error):
                if let categories = UserDefault.shared.categoryList{
                    self.categories = categories
                    self.delegate?.didUpdateCategoryList()
                }else{
                    self.delegate?.didFailWithError(error)
                }
            }
        }
    }
}
