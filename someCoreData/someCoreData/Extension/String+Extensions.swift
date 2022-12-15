//
//  String+Extensions.swift
//  someCoreData
//
//  Created by  illia on 13/12/2022.
//

import Foundation

extension String {
    var isNumeric: Bool {
        Double(self) != nil
    }
    func isGreaterThan(_ value: Double) -> Bool {
        guard self.isNumeric else {
            return false
        }
        return Double(self)! > value
    }
}
