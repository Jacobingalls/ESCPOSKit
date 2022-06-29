//
//  Cescpos.c
//  
//
//  Created by Jacob Ingalls on 6/16/22.
//

#include "include/Cescpos.h"

int escpos_print(UInt32 idVendor, UInt32 idProduct, const char *buffer, unsigned int length) {
    
    // Let’s now implement the main function. Add the following variable declarations.
    CFMutableDictionaryRef matchingDictionary = NULL;
    io_iterator_t iterator = 0;
    io_service_t usbRef;
    SInt32 score;
    IOCFPlugInInterface** plugin;
    IOUSBDeviceInterface300** usbDevice = NULL;
    
    
    // We now try to find the USB device using the vendor and product id
    matchingDictionary = IOServiceMatching(kIOUSBDeviceClassName);
    CFDictionaryAddValue(matchingDictionary, CFSTR(kUSBVendorID),  CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &idVendor ));
    CFDictionaryAddValue(matchingDictionary, CFSTR(kUSBProductID), CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &idProduct));
    IOServiceGetMatchingServices(kIOMainPortDefault, matchingDictionary, &iterator);
    usbRef = IOIteratorNext(iterator);
    if (usbRef == 0) {
        printf("Device not found\n");
        return -1;
    }
    
    IOObjectRelease(iterator);
    IOCreatePlugInInterfaceForService(usbRef, kIOUSBDeviceUserClientTypeID, kIOCFPlugInInterfaceID, &plugin, &score);
    IOObjectRelease(usbRef);
    (*plugin)->QueryInterface(plugin, CFUUIDGetUUIDBytes(kIOUSBDeviceInterfaceID300), (LPVOID)&usbDevice);
    (*plugin)->Release(plugin);
    
    
    
    
    // Now that we have found the device, we open the device and set the first configuration as active
    IOReturn ret;
    IOUSBConfigurationDescriptorPtr config;
    
    ret = (*usbDevice)->USBDeviceOpen(usbDevice);
    if (ret == kIOReturnSuccess) {
        // set first configuration as active
        ret = (*usbDevice)->GetConfigurationDescriptorPtr(usbDevice, 0, &config);
        if (ret != kIOReturnSuccess) {
            printf("Could not set active configuration (error: %x)\n", ret);
            return -2;
        }
        (*usbDevice)->SetConfiguration(usbDevice, config->bConfigurationValue);
        
    } else if (ret == kIOReturnExclusiveAccess) {
        // this is not a problem as we can still do some things
        
    } else {
        printf("Could not open device (error: %x)\n", ret);
        return -3;
    }
    
    
    
    // Having done that, we need to find the interface we want to use for sending and receiving data. Our device is a USB RNDIS device that has two bulk data endpoints on the second interface (#1).
    IOUSBFindInterfaceRequest interfaceRequest;
    IOUSBInterfaceInterface300** usbInterface;
    interfaceRequest.bInterfaceClass = kIOUSBFindInterfaceDontCare;
    interfaceRequest.bInterfaceSubClass = kIOUSBFindInterfaceDontCare;
    interfaceRequest.bInterfaceProtocol = kIOUSBFindInterfaceDontCare;
    interfaceRequest.bAlternateSetting = kIOUSBFindInterfaceDontCare;
    (*usbDevice)->CreateInterfaceIterator(usbDevice, &interfaceRequest, &iterator);
    usbRef = IOIteratorNext(iterator);
    IOObjectRelease(iterator);
    IOCreatePlugInInterfaceForService(usbRef, kIOUSBInterfaceUserClientTypeID, kIOCFPlugInInterfaceID, &plugin, &score);
    IOObjectRelease(usbRef);
    (*plugin)->QueryInterface(plugin, CFUUIDGetUUIDBytes(kIOUSBInterfaceInterfaceID300), (LPVOID)&usbInterface);
    (*plugin)->Release(plugin);
    
    // Now that we have found the interface, let us open it
    ret = (*usbInterface)->USBInterfaceOpen(usbInterface);
    if (ret != kIOReturnSuccess) {
        printf("Could not open interface (error: %x)\n", ret);
        return -4;
    }
    
    
    
    
    // Finally, we can send and receive some data. The pipe references are in the same order as the end points that appear in the Bus Probe tab of USB Prober. In our case, pipe 0 is the default control endpoint (does not have an endpoint descriptor and will not appear in USB Prober), pipe 1 is the bulk data output endpoint, and pipe 2 is the bulk data input endpoint.
    
    // For some reason, if we read less than 64 bytes I/O Kit returns a kIOReturnOverrun error. Coincidentally, the max packet size of the bulk input pipe of the device is also 64 bytes.
    
    // Send data through pipe 1
    (*usbInterface)->WritePipe(usbInterface, 1, (char *)buffer, length);
    
    // To wrap it all, we close the interface and device, and return from main
    (*usbInterface)->USBInterfaceClose(usbInterface);
    (*usbDevice)->USBDeviceClose(usbDevice);

    return 0;
        
}
