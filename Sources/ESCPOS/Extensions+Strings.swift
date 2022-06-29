//
//  Extensions+Strings.swift
//  
//
//  Created by Jacob Ingalls on 6/28/22.
//

import Foundation

extension String {
    func wordWrap(limit: Int) -> String {
        var currentLine = ""
        var lines = [String]()
        for word in self.split(whereSeparator: { $0.isWhitespace }) {
            if (currentLine.count + 1 + word.count) <= limit {
                currentLine += " " + word
            } else {
                lines.append(currentLine)
                currentLine = String(word)
            }
        }
        
        if !currentLine.isEmpty {
            lines.append(currentLine)
        }
        
        return lines.joined(separator: "\n")
    }
}
