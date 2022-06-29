//
//  main.swift
//  
//
//  Created by Jacob Ingalls on 6/1/22.
//

import Foundation
import ESCPOS

let commands: [ESCPOSCommand] = [
    .justification(.center),
    .characterSize(vertical: .double, horizontal: .double),
    .ascii("Hello, World!\n\n"),
    .justification(.left),
    .characterSize(vertical: .normal, horizontal: .normal),
    .ascii("Welcome to the exciting new world...\nprinting reciepts.\n"),
    .printAndFeed(lines: 5),
    
    // Cutting is not yet implented in Commands...
    .raw(.init([ 0x1D, 0x56, 0 ])),
]

let data = commands.map(\.dataValue).reduce(into: Data(), { $0.append($1) })

// My Epson TM-T20III Reciept Printer over USB
try! escposPrint(vendorId: 0x04B8, productId: 0x0202, data: data)
