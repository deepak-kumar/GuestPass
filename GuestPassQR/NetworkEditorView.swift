//
//  NetworkEditorView.swift
//  GuestPassQR
//
//  Created on 2025-12-17.
//

import SwiftUI
#if os(iOS)
import NetworkExtension
#endif

struct NetworkEditorView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var storage: NetworkStorage
    
    @State private var config: WiFiConfig
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
                    
                    // Network Name
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Network Name")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        TextField("SSID", text: $config.ssid)
                            .textFieldStyle(.roundedBorder)
                        #if os(iOS)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        #endif
                    }
                    
                    // Password
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        SecureField("Password", text: $config.password)
                            .textFieldStyle(.roundedBorder)
                        #if os(iOS)
                            .textContentType(.password)
                        #endif
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
            .onAppear {
                if !isEditing {
                    loadCurrentWiFiNetwork()
                }
            }
        }
        #if os(iOS)
        .preferredColorScheme(.dark)
        #endif
    }
    
    private func saveNetwork() {
        storage.saveNetwork(config)
        dismiss()
    }
    
    private func loadCurrentWiFiNetwork() {
        #if os(iOS)
        // Try NetworkExtension (Modern, requires entitlement)
        NEHotspotNetwork.fetchCurrent { network in
            if let network = network {
                DispatchQueue.main.async {
                    config.ssid = network.ssid
                    config.securityType = .wpa
                }
            }
        }
        #endif
    }
}
