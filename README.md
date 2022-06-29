# ECSPOSKit

Prints to an Epson ESCPOS-Compatible Receipt Printer.

Resources:
- [ESCPOS Command Documentation](https://www.epson-biz.com/modules/ref_escpos/index.php?cat_id=2)
- [Super Awesome IOUSB Sample Code](https://tewarid.github.io/2012/04/27/access-usb-device-on-mac-os-x-using-i-o-kit.html)

## Basic Usage:

Add ESCPOSKit to your project:

- Either, add it via Xcode.
    1. Go to your .xcodeproj file, select your project, and choose the "Package Dependencies" Tab
    2. Click on the "+", and enter "https://github.com/Jacobingalls/ESCPOSKit.git" into the search
    3. Pick the appropriate version (right now only main), select the ESCPOS target, and add it to your targets.
- Or, add it via the Swift Package Manifest (Package.swift)
    - Add the package to your list of packages.
        ```
        .package(url: "https://github.com/Jacobingalls/ESCPOSKit.git", .branch("main"))
        ```
    - And, add the package as a dependency of at least one of your targets.

Then you may use it in your code.

```swift
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
    
    // Cutting is not yet implemented in Commands...
    .raw(.init([ 0x1D, 0x56, 0 ])),
]

let data = commands.map(\.dataValue).reduce(into: Data(), { $0.append($1) })

// My Epson TM-T20III Receipt Printer over USB
try! escposPrint(vendorId: 0x04B8, productId: 0x0202, data: data)
```