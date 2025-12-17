//
//  QRCodeDisplayView.swift
//  GuestPassQR
//
//  Created on 2025-12-17.
//

import SwiftUI

struct QRCodeDisplayView: View {
    let network: WiFiConfig
    private let qrGenerator = QRCodeGenerator()
    @State private var qrImage: Image?
    
    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 40) {
                    // Network Info
                    VStack(spacing: 8) {
                        Image(systemName: "wifi")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                            .padding(.bottom, 8)
                            
                        Text(network.ssid)
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                    }
                    .padding(.horizontal)
                    
                    // QR Code
                    if let qrImage = qrImage {
                        qrImage
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 300)
                            .padding(20)
                            .background(Color.white)
                            .cornerRadius(24)
                            .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                            .padding(.horizontal, 24)
                            .contextMenu {
                                ShareLink(item: qrImage, preview: SharePreview(network.ssid, image: qrImage)) {
                                    Label("Share Image", systemImage: "square.and.arrow.up")
                                }
                            }
                    } else {
                        ProgressView()
                            .tint(.white)
                    }
                    
                    // Actions
                    if let qrImage = qrImage {
                        ShareLink(item: qrImage, preview: SharePreview(network.ssid, image: qrImage)) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share QR Code")
                            }
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 40)
                    }
                    
                    Spacer()
                }
                .padding(.top, 40)
                .frame(maxWidth: .infinity) 
            }
        }
        .onAppear {
            generateQR()
        }
    }
    
    private func generateQR() {
        let string = network.toQRString()
        if let platformImage = qrGenerator.generateQRCode(from: string, size: 1024) {
            #if os(iOS)
            self.qrImage = Image(uiImage: platformImage).renderingMode(.original)
            #else
            self.qrImage = Image(nsImage: platformImage).renderingMode(.original)
            #endif
        }
    }
}
