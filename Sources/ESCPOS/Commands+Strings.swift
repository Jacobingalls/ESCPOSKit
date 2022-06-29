//
//  Commands+Strings.swift
//  
//
//  Created by Jacob Ingalls on 6/28/22.
//

import Foundation

public extension ESCPOSCommand {
    static func ascii(_ string: String, wrappingAt lineWidth: Int) -> Self {
        return .ascii(string.wordWrap(limit: lineWidth))
    }
}
