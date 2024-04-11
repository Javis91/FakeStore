//
//  UserDefault.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/11/24.
//

import Foundation


private enum USConstants: String {
    case Categories
}

final class UserDefault{
    private static let _shared = UserDefault()
    
    static var shared : UserDefault{
        return self._shared
    }
    
    private let userDefauls : UserDefaults = UserDefaults.standard
    
    var categoryList: [String]?{
        get{
            return self.userDefauls.object(forKey: USConstants.Categories.rawValue) as? [String]
        }
        set{
            self.userDefauls.set(newValue, forKey: USConstants.Categories.rawValue)
        }
    }
}
