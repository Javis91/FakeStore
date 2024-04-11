//
//  CustomError.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/10/24.
//

import Foundation

enum CustomError {
    case noConnection, noData
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData: return "No existe información"
        case .noConnection: return "No hay conexión a internet"
        }
    }
}
