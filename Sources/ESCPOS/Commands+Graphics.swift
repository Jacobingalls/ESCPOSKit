//
//  Commands+Graphics.swift
//  
//
//  Created by Jacob Ingalls on 6/26/22.
//

import Foundation
import AppKit

public extension ESCPOSCommand {
    static func printMonochromePhoto(url: URL) throws -> ESCPOSCommand {
        let image = NSImage(contentsOf: url)!
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        
        var bits: [[Bool]] = []
        let pointer = CFDataGetBytePtr(cgImage.dataProvider!.data)!
        let width = Int(cgImage.width)
        for y in 0..<cgImage.height {
            var row: [Bool] = []
            for x in 0..<cgImage.width {
                let pixelPosition = (width * y + x) * 4
                let r = Double(pointer[pixelPosition + 0])
                let g = Double(pointer[pixelPosition + 1])
                let b = Double(pointer[pixelPosition + 2])
                let a = Double(pointer[pixelPosition + 3])
                let value = ((r + g + b) / 255) * (a / 255)
                row.append(value > 0.5)
            }
            bits.append(row)
        }
        
        var data = [UInt8]()
        for row in bits {
            
            var current: UInt8 = 0
            var bitsEncoded = 0
            for bit in row {
                bitsEncoded += 1
                current = (current << 1) + (bit ? 1 : 0)
                
                if bitsEncoded >= 8 {
                    data.append(current)
                    current = 0
                    bitsEncoded = 0
                }
            }
            
            if bitsEncoded > 0 {
                current = (current << (8 - bitsEncoded))
                data.append(current)
            }
        }
        
        return .group([
            .storeMonochromeRasterGraphicsDataInPrintBuffer(width: UInt16(cgImage.width),
                                                            height: UInt16(cgImage.height),
                                                            data: .init(data)),
            .printGraphicsBuffer
        ])
    }
}
