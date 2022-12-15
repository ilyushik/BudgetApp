//
//  NumberForrmatter+Extensions.swift
//  someCoreData
//
//  Created by  illia on 13/12/2022.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
