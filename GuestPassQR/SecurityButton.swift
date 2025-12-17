//
//  SecurityButton.swift
//  GuestPassQR
//
//  Created on 2025-12-17.
//

import SwiftUI

struct SecurityButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(isSelected ? .white : .primary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                .cornerRadius(12)
        }
    }
}
