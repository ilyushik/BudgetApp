//
//  NSSet+Extensions.swift
//  someCoreData
//
//  Created by  illia on 15/12/2022.
//

import Foundation

extension NSSet {
    func toArray<T>() -> [T] {
        let array = self.map { $0 as! T }
        return array
    }
}
