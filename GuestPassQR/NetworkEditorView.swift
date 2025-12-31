//
//  NetworkEditorView.swift
//  GuestPassQR
//
//  Created on 2025-12-17.
//

import SwiftUI
#if os(iOS)
import NetworkExtension
import CoreLocation
#elseif os(macOS)
import CoreWLAN
import CoreLocation
#endif

struct NetworkEditorView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var storage: NetworkStorage
    
    @State private var config: WiFiConfig
    @State private var nearbyNetworks: [String] = []
    @State private var isScanning = false
    private let isEditing: Bool
    
    init(storage: NetworkStorage, existingNetwork: WiFiConfig? = nil) {
        self.storage = storage
        if let network = existingNetwork {
            _config = State(initialValue: network)
            isEditing = true
        } else {
            _config = State(initialValue: WiFiConfig())
            isEditing = false
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // Form Fields
                VStack(spacing: 20) {
                    
                    // Friendly Name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Friendly Name (Optional)")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        TextField("e.g. Home, Office, Guest", text: $config.friendlyName)
                            .padding(12)
                            .background(Color.primary.opacity(0.05))
                            .cornerRadius(10)
                    }
                    
                    // Network Name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Network Name")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        HStack {
                            TextField("SSID", text: $config.ssid)
                            #if os(iOS)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                            #endif
                                .padding(12)
                                .background(Color.primary.opacity(0.05))
                                .cornerRadius(10)
                            

                            
                            #if os(macOS)
                            Menu {
                                if isScanning {
                                    Text("Scanning...")
                                } else if nearbyNetworks.isEmpty {
                                    Button("Scan for Networks") {
                                        scanForNetworks()
                                    }
                                } else {
                                    ForEach(nearbyNetworks, id: \.self) { ssid in
                                        Button(ssid) {
                                            config.ssid = ssid
                                        }
                                    }
                                    Divider()
                                    Button("Rescan") {
                                        scanForNetworks()
                                    }
                                }
                            } label: {
                                Image(systemName: isScanning ? "antenna.radiowaves.left.and.right" : "wifi.circle")
                                    .font(.system(size: 20))
                                    .foregroundColor(.accentColor)
                            }
                            .menuStyle(.borderlessButton)
                            .fixedSize()
                            .onAppear {
                                scanForNetworks()
                            }
                            #endif
                        }
                    }
                    
                    // Password
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        SecureField("Password", text: $config.password)
                        #if os(iOS)
                            .textContentType(.password)
                        #endif
                            .padding(12)
                            .background(Color.primary.opacity(0.05))
                            .cornerRadius(10)
                    }
                    
                    // Security
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Security")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Picker("Security", selection: $config.securityType) {
                            Text("WPA/WPA2").tag(WiFiSecurityType.wpa)
                            Text("Open").tag(WiFiSecurityType.nopass)
                        }
                        .pickerStyle(.segmented)
                        .labelsHidden()
                    }
                }
                .padding()
                
                Spacer()
                
                // Save Button
                Button(action: saveNetwork) {
                    Text(isEditing ? "Save Changes" : "Create Network")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 4)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .disabled(!config.isValid)
                .padding()
            }
            .navigationTitle(isEditing ? "Edit Network" : "Add Network")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            // WiFi detection disabled on appear to prevent UI freeze on devices without WiFi.
            // Users can tap the WiFi button next to the SSID field to detect the current network.
        }
        #if os(iOS)
        .preferredColorScheme(.dark)
        #endif
    }
    
    private func saveNetwork() {
        storage.saveNetwork(config)
        dismiss()
    }
    
    // WiFi detection removed to fix UI freeze issues.
    
    private func scanForNetworks() {
        #if os(macOS)
        isScanning = true
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let interface = CWWiFiClient.shared().interface() {
                do {
                    // Scanning might take a few seconds
                    let networks = try interface.scanForNetworks(withSSID: nil)
                    let ssids = Array(Set(networks.compactMap { $0.ssid })).sorted()
                    
                    DispatchQueue.main.async {
                        self.nearbyNetworks = ssids
                        self.isScanning = false
                    }
                } catch {
                    print("Scan failed: \(error)")
                    DispatchQueue.main.async {
                        self.isScanning = false
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.isScanning = false
                }
            }
        }
        #endif
    }
}
