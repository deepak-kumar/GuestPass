//
//  SplashScreenView.swift
//  GuestPassQR
//
//  Created on 2025-12-31.
//

import SwiftUI

struct SplashScreenView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var currentStage: Int = 0 // 0: Logo, 1: Sharing, 2: Privacy, 3: Done
    @State private var opacity: Double = 0.0
    @State private var scale: Double = 0.8
    @State private var blur: Double = 10.0
    
    var body: some View {
        if currentStage == 3 {
            ContentView()
        } else {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.05, green: 0.05, blue: 0.1),
                        Color(red: 0.1, green: 0.1, blue: 0.2)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack {
                    // Skip Button (Only for Onboarding stages)
                    if currentStage == 1 || currentStage == 2 {
                        HStack {
                            Spacer()
                            Button(action: skipOnboarding) {
                                Text("Skip")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white.opacity(0.5))
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                            }
                        }
                        .padding(.top, 10)
                        .transition(.opacity)
                    }
                    
                    Spacer()
                    
                    // Main Content
                    VStack(spacing: 40) {
                        Group {
                            if currentStage == 0 {
                                brandStage
                            } else if currentStage == 1 {
                                sharingStage
                            } else if currentStage == 2 {
                                privacyStage
                            }
                        }
                        .opacity(opacity)
                        .scaleEffect(scale)
                        .blur(radius: blur)
                    }
                    
                    Spacer()
                    
                    // Next Button (Only for Onboarding stages)
                    if currentStage == 1 || currentStage == 2 {
                        Button(action: nextStage) {
                            Text(currentStage == 2 ? "Get Started" : "Next")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.black)
                                .frame(width: 200)
                                .padding(.vertical, 16)
                                .background(Color.white)
                                .clipShape(Capsule())
                                .shadow(color: .white.opacity(0.2), radius: 10, x: 0, y: 5)
                        }
                        .padding(.bottom, 50)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
            }
            .onAppear {
                animateSequence()
            }
        }
    }
    
    // MARK: - Stages
    
    private var brandStage: some View {
        VStack(spacing: 24) {
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.1))
                    .frame(width: 160, height: 160)
                    .blur(radius: 20)
                
                Image(systemName: "wifi")
                    .font(.system(size: 80, weight: .thin))
                    .foregroundColor(.white)
                    .shadow(color: .blue.opacity(0.5), radius: 15, x: 0, y: 0)
            }
            
            Text("WiFi Invite")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
    }
    
    private var sharingStage: some View {
        VStack(spacing: 36) {
            ZStack {
                // Background Glow
                Circle()
                    .fill(Color.blue.opacity(0.15))
                    .frame(width: 140, height: 140)
                    .blur(radius: 30)
                
                Image(systemName: "qrcode")
                    .font(.system(size: 80, weight: .thin))
                    .foregroundColor(.white)
                
                Image(systemName: "viewfinder")
                    .font(.system(size: 110, weight: .ultraLight))
                    .foregroundColor(.blue)
                    .shadow(color: .blue.opacity(0.5), radius: 20)
            }
            
            VStack(spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                    
                    Text("Seamless Sharing")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                
                VStack(spacing: 12) {
                    Text("NO MORE TYPING")
                        .font(.system(size: 12, weight: .black))
                        .kerning(2)
                        .foregroundColor(.blue.opacity(0.8))
                    
                    Text("Dictating long passwords is a thing of the past. Simply show your guest the generated pass, and they'll be online in a single tap.")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 30)
                }
            }
        }
    }
    
    private var privacyStage: some View {
        VStack(spacing: 36) {
            ZStack {
                // Background Glow
                Circle()
                    .fill(Color.green.opacity(0.15))
                    .frame(width: 140, height: 140)
                    .blur(radius: 30)
                
                Image(systemName: "shield.fill")
                    .font(.system(size: 90, weight: .thin))
                    .foregroundColor(.green)
                    .shadow(color: .green.opacity(0.5), radius: 25)
                
                Image(systemName: "lock.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.black.opacity(0.5))
                    .offset(y: 5)
            }
            
            VStack(spacing: 16) {
                HStack(spacing: 12) {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.green)
                    
                    Text("Secure & Private")
                        .font(.system(size: 34, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
                
                VStack(spacing: 12) {
                    Text("100% ON-DEVICE")
                        .font(.system(size: 12, weight: .black))
                        .kerning(2)
                        .foregroundColor(.green.opacity(0.8))
                    
                    Text("Your credentials never leave your device. We don't use the cloud, we don't track you, and we definitely don't sell your data.")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 30)
                }
            }
        }
    }
    
    // MARK: - Actions
    
    private func nextStage() {
        if currentStage < 2 {
            showStage(currentStage + 1)
        } else {
            hasSeenOnboarding = true
            transitionToMain()
        }
    }
    
    private func skipOnboarding() {
        hasSeenOnboarding = true
        transitionToMain()
    }
    
    // MARK: - Animation
    
    private func animateSequence() {
        // Step 1: Show Logo (Every time)
        showStage(0)
        
        let logoDisplayTime = 1.5
        
        DispatchQueue.main.asyncAfter(deadline: .now() + logoDisplayTime) {
            if hasSeenOnboarding {
                // If returning user, skip directly to main after logo
                transitionToMain()
            } else {
                // If first time, show onboarding stages
                showStage(1)
            }
        }
    }
    
    private func showStage(_ stage: Int) {
        // Out animation
        withAnimation(.easeInOut(duration: 0.4)) {
            opacity = 0.0
            scale = 1.05
            blur = 5.0
        }
        
        // Switch and In animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            currentStage = stage
            scale = 0.95
            
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                opacity = 1.0
                scale = 1.0
                blur = 0.0
            }
        }
    }
    
    private func transitionToMain() {
        withAnimation(.easeInOut(duration: 0.8)) {
            opacity = 0.0
            scale = 1.15
            currentStage = 3
        }
    }
}

#Preview {
    SplashScreenView()
}
