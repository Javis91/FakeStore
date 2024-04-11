//
//  String.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/10/24.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
