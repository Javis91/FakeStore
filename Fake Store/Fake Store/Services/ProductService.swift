//
//  ProductService.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/10/24.
//

import Foundation

final class ProductService {
    private enum ApiURL {
        case base
        case db

        var baseURL: String {
            switch self {
            case .base: return "https://fakestoreapi.com"
            case .db: return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.absoluteString ?? ""
            }
        }
    }

    private enum Endpoint {
        case categoryList
        case productListByCategory(_ name: String)
        case singleProduct(_ id: Int)
        case file(_ name: String)

        var path: String {
            switch self {
            case .categoryList:  return "/products/categories"
            case .productListByCategory(let name): return "/products/category/\(name)"
            case .singleProduct(let id): return "/products/\(id)"
            case .file(let name): return "\(name.lowercased()).plist"
            }
        }

        var url: String {
            switch self {
            case .categoryList, .productListByCategory, .singleProduct: return "\(ApiURL.base.baseURL)\(path)"
            case .file: return "\(ApiURL.db.baseURL)\(path)"
            }
        }
    }

    static func getSingleProduct(id: Int, completion: @escaping (Result<Product, Error>) -> Void) {
        guard Reachability.isConnectedToNetwork(),
              let url = URL(string: Endpoint.singleProduct(id).url) else {
                  completion(.failure(CustomError.noConnection))
                  return
              }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(CustomError.noData))
                return
            }

            do {
                let product = try JSONDecoder().decode(Product.self, from: data)
                completion(.success(product))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    static func getProductList(name: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        guard Reachability.isConnectedToNetwork(),
              let url = URL(string: Endpoint.productListByCategory(name).url) else {
                  completion(.failure(CustomError.noConnection))
                  return
              }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(CustomError.noData))
                return
            }

            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                completion(.success(products))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func getCategoryList(completion: @escaping (Result<[String], Error>) -> Void) {
        guard Reachability.isConnectedToNetwork(),
              let url = URL(string: Endpoint.categoryList.url) else {
                  completion(.failure(CustomError.noConnection))
                  return
              }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(CustomError.noData))
                return
            }

            do {
                let categories = try JSONDecoder().decode([String].self, from: data)
                completion(.success(categories))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
    
    static func setCategoryListFile(name: String, list: [Product]){
        guard let url = URL(string: Endpoint.file(name).url) else {
            return
        }
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(list)
            try data.write(to: url)
        }catch{
            print(error.localizedDescription)
        }
    }
    
    static func getCategoryListFile(name: String, completion: @escaping (Result<[Product], Error>) -> Void){
        guard let url = URL(string: Endpoint.file(name).url) else {
            completion(.failure(CustomError.noFile))
            return
        }
        if let data = try? Data(contentsOf: url){
            let decoder = PropertyListDecoder()
            do{
                let categoryList = try decoder.decode([Product].self, from: data)
                completion(.success(categoryList))
            }catch{
                completion(.failure(CustomError.noData))
            }
        }else{
            completion(.failure(CustomError.noData))
        }
    }
}
