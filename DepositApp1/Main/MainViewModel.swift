//
//  MainViewModel.swift
//  DepositApp1
//
//  Created by Bolys Malik on 29.11.2024.
//

import Foundation

enum Months: Int {
    case three = 3
    case six = 6
    case twelve = 12
}

enum Currency: String {
    case kzt = "1000₸"
    case usd = "2$"
}


class MainViewModel {
    
    var months = Months.three
    var currency = Currency.kzt
    
    var currentSelected: IndexPath?
    var monthsTitle = ["3 мес", "6 мес", "12 мес"]
    
    public func calculateSum(rate: Double, months: Months, principal: Double = 1000) -> Double {
        let years = Double(months.rawValue) / 12.0
        
        let result = principal + (principal * rate / 100 * years)
        return result
    }
    
    public func getRateRew(currency: Currency) -> Double {
        switch currency {
        case .kzt:
            12.8
        case .usd:
            1
        }
    }
    
    public func getRateEff(currency: Currency) -> Double {
        switch currency {
        case .kzt:
            13.6
        case .usd:
            1.5
        }
    }
}
