//
//  WiFiConfig.swift
//  GuestPassQR
//
//  Created on 2025-12-15.
//

import Foundation

enum WiFiSecurityType: String, CaseIterable, Identifiable, Codable {
    case wpa = "WPA"
    case wep = "WEP"
    case nopass = "nopass"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .wpa:
            return "WPA/WPA2/WPA3"
        case .wep:
            return "WEP"
        case .nopass:
            return "No Password"
        }
    }
}

struct WiFiConfig: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var ssid: String = ""
    var password: String = ""
    var securityType: WiFiSecurityType = .wpa
    var isHidden: Bool = false
    var createdAt: Date = Date()
    
    init(id: UUID = UUID(), ssid: String = "", password: String = "", securityType: WiFiSecurityType = .wpa, isHidden: Bool = false, createdAt: Date = Date()) {
        self.id = id
        self.ssid = ssid
        self.password = password
        self.securityType = securityType
        self.isHidden = isHidden
        self.createdAt = createdAt
    }
    
    /// Generates the WiFi configuration string in the standard format
    /// Format: WIFI:T:<security>;S:<ssid>;P:<password>;H:<hidden>;;
    func toQRString() -> String {
        let escapedSSID = escapeSpecialCharacters(ssid)
        let escapedPassword = escapeSpecialCharacters(password)
        let hiddenFlag = isHidden ? "true" : "false"
        
        return "WIFI:T:\(securityType.rawValue);S:\(escapedSSID);P:\(escapedPassword);H:\(hiddenFlag);;"
    }
    
    /// Escapes special characters according to WiFi QR code specification
    private func escapeSpecialCharacters(_ string: String) -> String {
        var result = string
        // Escape backslash first
        result = result.replacingOccurrences(of: "\\", with: "\\\\")
        // Escape special characters
        result = result.replacingOccurrences(of: "\"", with: "\\\"")
        result = result.replacingOccurrences(of: ";", with: "\\;")
        result = result.replacingOccurrences(of: ",", with: "\\,")
        result = result.replacingOccurrences(of: ":", with: "\\:")
        return result
    }
    
    var isValid: Bool {
        // SSID must not be empty
        guard !ssid.isEmpty else { return false }
        
        // If security type requires password, it must not be empty
        if securityType != .nopass && password.isEmpty {
            return false
        }
        
        return true
    }
}
