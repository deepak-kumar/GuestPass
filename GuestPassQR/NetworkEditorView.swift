//
//  NetworkEditorView.swift
//  GuestPassQR
//
//  Created on 2025-12-17.
//

import SwiftUI

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
                        TextField("SSID", text: $config.ssid)
                        #if os(iOS)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        #endif
                            .padding(12)
                            .background(Color.primary.opacity(0.05))
                            .cornerRadius(10)
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
        }
        .preferredColorScheme(.dark)
    }
    
    private func saveNetwork() {
        storage.saveNetwork(config)
        dismiss()
    }
}
