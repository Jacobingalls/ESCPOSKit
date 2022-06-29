//
//  Cescpos.h
//  
//
//  Created by Jacob Ingalls on 6/16/22.
//

#ifndef Cescpos_h
#define Cescpos_h

#include <stdio.h>
#include <CoreFoundation/CoreFoundation.h>
#include <IOKit/IOKitLib.h>
#include <IOKit/IOCFPlugIn.h>
#include <IOKit/usb/IOUSBLib.h>
#include <IOKit/usb/USBSpec.h>

/// Sends the contents of the buffer to the first USB device matching the Vender and Product IDs, and is a Printer
///
/// Based on this awesome article: https://tewarid.github.io/2012/04/27/access-usb-device-on-mac-os-x-using-i-o-kit.html
///
/// - Parameters:
///   - idVendor: The USB Vender number
///   - idProduct: The USB Product number
///   - buffer: The zero-terminated buffer to send to the device
///   - length: Length of the Buffer.
int escpos_print(UInt32 idVendor, UInt32 idProduct, const char *buffer, unsigned int length);

#endif /* Cescpos_h */
