//
//  QRCodeGenerator.swift
//  GuestPassQR
//
//  Created on 2025-12-15.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeGenerator {
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    
    #if os(iOS)
    typealias PlatformImage = UIImage
    #else
    typealias PlatformImage = NSImage
    #endif
    
    /// Generates a QR code image from the given string
    func generateQRCode(from string: String, size: CGFloat = 800) -> PlatformImage? {
        guard let data = string.data(using: .utf8) else { return nil }
        
        filter.setValue(data, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel")
        
        guard let outputImage = filter.outputImage else { return nil }
        
        // Scale the QR code to the desired size
        let scaleX = size / outputImage.extent.size.width
        let scaleY = size / outputImage.extent.size.height
        let transformedImage = outputImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        guard let cgImage = context.createCGImage(transformedImage, from: transformedImage.extent) else { return nil }
        
        #if os(iOS)
        return UIImage(cgImage: cgImage)
        #else
        return NSImage(cgImage: cgImage, size: NSSize(width: size, height: size))
        #endif
    }
}
