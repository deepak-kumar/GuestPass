//
//  NetworkStorage.swift
//  GuestPassQR
//
//  Created on 2025-12-17.
//

import Foundation

class NetworkStorage: ObservableObject {
    @Published var savedNetworks: [WiFiConfig] = []
    
    private let saveKey = "SavedWiFiNetworks"
    
    init() {
        loadNetworks()
    }
    
    func saveNetwork(_ config: WiFiConfig) {
        if let index = savedNetworks.firstIndex(where: { $0.id == config.id }) {
            savedNetworks[index] = config
        } else {
            savedNetworks.insert(config, at: 0)
        }
        persist()
    }
    
    func deleteNetwork(at offsets: IndexSet) {
        savedNetworks.remove(atOffsets: offsets)
        persist()
    }
    
    func deleteNetwork(_ network: WiFiConfig) {
        savedNetworks.removeAll { $0.id == network.id }
        persist()
    }
    
    private func persist() {
        if let encoded = try? JSONEncoder().encode(savedNetworks) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadNetworks() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([WiFiConfig].self, from: data) {
            savedNetworks = decoded
        }
    }
}
