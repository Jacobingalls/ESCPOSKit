//
//  Client.swift
//
//
//  Created by Jacob Ingalls on 6/1/22.
//

import Foundation
import Cescpos

public enum EscposPrintError: Int32, LocalizedError {
    case deviceNotFound = -1
    case couldNotSetActiveConfiguration = -2
    case couldNotOpenDevice = -3
    case couldNotOpenInterface = -4
}

public func escposPrint(vendorId: UInt32, productId: UInt32, data: Data) throws {
    let ret = data.withUnsafeBytes{ (buffer: UnsafeRawBufferPointer) -> Int32 in
        return escpos_print(vendorId, productId, buffer.baseAddress, UInt32(buffer.count))
    }
    
    if let err = EscposPrintError(rawValue: ret) {
        throw err
    }
}


//import AppKit
//import Foundation
//import USBDeviceSwift
//import IOKit
//
//public class ESCPOSClient {
//    
//    public init() {
//        let monitor = USBDeviceMonitor([
//            .init(vendorId: 0x04b8, productId: 0x0202)
//        ])
//        
//        DispatchQueue.global().async {
//            monitor.start()
//        }
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.usbConnected), name: .USBDeviceConnected, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.usbDisconnected), name: .USBDeviceDisconnected, object: nil)
//    }
//    
//    public func send(_ data: Data) {
//        // TODO
//    }
//    
//    public func send(_ command: ESCPOSCommand) {
//        send(command.dataValue)
//    }
//    
//    public func send<Seq: Sequence>(commands: Seq) where Seq.Element == ESCPOSCommand {
//        for command in commands {
//            send(command)
//        }
//    }
//    
//    @objc func usbConnected(notification: NSNotification) {
//        guard let nobj = notification.object as? NSDictionary else {
//            return
//        }
//
//        guard let deviceInfo: USBDevice = nobj["device"] as? USBDevice else {
//            return
//        }
//        
//        //Getting device interface from our pointer
//        guard let deviceInterface = deviceInfo.deviceInterfacePtrPtr?.pointee?.pointee else {
//            return
//        }
//        
//        guard let pluginInterface = deviceInfo.plugInInterfacePtrPtr?.pointee?.pointee else {
//            return
//        }
//        
//        
//        
//        __NSBeep()
//        sleep(1)
//        __NSBeep()
//        sleep(1)
//        
//        let kIOUSBDeviceInterfaceID500 = CFUUIDGetConstantUUIDWithBytes(nil, 0xA3, 0x3C, 0xF0, 0x47, 0x4B, 0x5B, 0x48, 0xE2, 0xB5, 0x7D, 0x02, 0x07, 0xFC, 0xEA, 0xE1, 0x3B)
//        
//        var usbDevicePtr: LPVOID? = nil
//        pluginInterface.QueryInterface(
//            deviceInfo.plugInInterfacePtrPtr,
//            CFUUIDGetUUIDBytes(kIOUSBDeviceInterfaceID500),
//            &usbDevicePtr
//        )
//        
//        var usbDevice = usbDevicePtr?.assumingMemoryBound(to: IOUSBDeviceInterface500.self)
//        var printerReq = IOUSBFindInterfaceRequest(
//            bInterfaceClass: UInt16(kUSBPrintingInterfaceClass),
//            bInterfaceSubClass: UInt16(kIOUSBFindInterfaceDontCare),
//            bInterfaceProtocol: UInt16(kIOUSBFindInterfaceDontCare),
//            bAlternateSetting: UInt16(kIOUSBFindInterfaceDontCare)
//        )
//        var ittr: io_iterator_t = 0
//        usbDevice?.pointee.CreateInterfaceIterator(usbDevice, &printerReq, &ittr)
//        var usbRef = IOIteratorNext(ittr);
//        
//        
//        let bmReqType = USBmakebmRequestType(direction: kUSBOut, type: kUSBClass, recipient: kUSBDevice)
//        var data: [CChar]? = "AAAAAAAAAAAAAAAAAAA".cString(using: .ascii)!
//        let count = data!.count
//        data!.withUnsafeMutableBytes { pointer in
//            
//            var request = IOUSBDevRequest(bmRequestType: 0x11, bRequest: 0x10, wValue: 0x10, wIndex: 0x10, wLength: UInt16(count), pData: pointer.baseAddress, wLenDone: 255)
//            let kr = deviceInterface.DeviceRequest(deviceInfo.deviceInterfacePtrPtr, &request)
//            print(kr)
//        }
//        sleep(1)
//        
//        __NSBeep()
//        sleep(1)
//        __NSBeep()
//        sleep(1)
//    }
//    
//    @objc func usbDisconnected(notification: NSNotification) {
//        guard let nobj = notification.object as? NSDictionary else {
//            return
//        }
//        
//        guard let id: UInt64 = nobj["id"] as? UInt64 else {
//            return
//        }
//        
//        print("Removed: \(id)")
//    }
//}
