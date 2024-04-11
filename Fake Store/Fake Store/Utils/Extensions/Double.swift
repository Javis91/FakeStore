//
//  Double.swift
//  Fake Store
//
//  Created by Javier Picazo Hernández on 4/10/24.
//

import Foundation

extension Double{
    func forTrailingZero() -> String {
        let tempVar = String(format: "%g", self)
        return tempVar
    }
    
    func formatterCurrency() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "es_MX")
        let priceString = currencyFormatter.string(from: NSNumber(value: self))!
        return priceString
    }
    
    func formatterCurrencySinDecimals() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 0
        currencyFormatter.locale = Locale(identifier: "es_MX")
        let priceString = currencyFormatter.string(from: NSNumber(value: self))!
        return priceString
    }
    
    func roundToInt() -> Double{
        let value = Int(self)
        let d = self - Double(value)
        if d < 0.5{
            return Double(value)
        } else {
            return Double(value) + 1.0
        }
    }
    
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
