//
//  ContentView.swift
//  GuestPassQR
//
//  Created on 2025-12-15.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var storage = NetworkStorage()
    @State private var isAddingNetwork = false
    @State private var networkToEdit: WiFiConfig?
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
                
                if storage.savedNetworks.isEmpty {
                    // Empty State
                    VStack(spacing: 24) {
                        Image(systemName: "wifi.router")
                            .font(.system(size: 80))
                            .foregroundColor(.white.opacity(0.1))
                        
                        VStack(spacing: 8) {
                            Text("No Saved Networks")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            
                            Text("Add your WiFi details to get started")
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                        
                        Button(action: { isAddingNetwork = true }) {
                            Text("Add WiFi Network")
                                .font(.headline)
                                .foregroundColor(.black)
                                .padding(.horizontal, 32)
                                .padding(.vertical, 16)
                                .background(Color.white)
                                .cornerRadius(12)
                        }
                        .padding(.top, 16)
                    }
                } else {
                    // Network List
                    List {
                        ForEach(storage.savedNetworks) { network in
                            ZStack {
                                NavigationLink(destination: QRCodeDisplayView(network: network)) {
                                    EmptyView()
                                }
                                .opacity(0)
                                
                                NetworkListRow(network: network)
                            }
                            .listRowBackground(Color.white.opacity(0.05))
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    if let index = storage.savedNetworks.firstIndex(where: { $0.id == network.id }) {
                                        storage.deleteNetwork(at: IndexSet(integer: index))
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                
                                Button {
                                    networkToEdit = network
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                            .contextMenu {
                                Button {
                                    networkToEdit = network
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                
                                Button(role: .destructive) {
                                    if let index = storage.savedNetworks.firstIndex(where: { $0.id == network.id }) {
                                        storage.deleteNetwork(at: IndexSet(integer: index))
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("WiFi Networks")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.large)
            #endif
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { isAddingNetwork = true }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                            .padding(8)
                            .background(Color.white.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
            }
            .sheet(isPresented: $isAddingNetwork) {
                NetworkEditorView(storage: storage)
            }
            .sheet(item: $networkToEdit) { network in
                NetworkEditorView(storage: storage, existingNetwork: network)
            }
        }
        #if os(iOS)
        .preferredColorScheme(.dark)
        #endif
    }
}

struct NetworkListRow: View {
    let network: WiFiConfig
    
    var body: some View {
        HStack {
            Image(systemName: "wifi")
                .font(.system(size: 24))
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(network.ssid)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(network.securityType.displayName)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray.opacity(0.5))
        }
        .padding(16)
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}

#Preview {
    ContentView()
}
