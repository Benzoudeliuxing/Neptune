//
//  Encodable+Dictionary.swift
//  CodyFire
//
//  Created by Mihael Isaev on 10.08.2018.
//

import Foundation

extension Encodable {
    func dictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        guard let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NeptuneError("Unable to encode data")
        }
        return result
    }
    
    func json() throws -> String {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        guard let result = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? String else {
            throw NeptuneError("Unable to encode data")
        }
        return result
    }
}
