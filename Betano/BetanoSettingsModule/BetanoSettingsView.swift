import SwiftUI

struct BetanoSettingsView: View {
    @StateObject var betanoSettingsModel =  BetanoSettingsViewModel()
 
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.mainBackground)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                           Text("Settings")
                                .Bak(size: 20)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 50)
                        
                        HStack {
                           Text("Timer Settings")
                                .Bak(size: 18)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 25)
                        
                        Rectangle()
                            .fill(.secondMain)
                            .frame(height: 76)
                            .cornerRadius(16)
                            .padding(.horizontal)
                            .overlay {
                                HStack {
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text("Reminders")
                                            .Bak(size: 16)
                                        
                                        Text("Daily notification to start activity")
                                            .Bak(size: 14, color: .secondLabel)
                                    }
                                    
                                    Spacer()
                                    
                                    Toggle("", isOn: $betanoSettingsModel.isReminds)
                                        .toggleStyle(CustomToggleStyle())
                                }
                                .padding(.horizontal, 35)
                            }
                        
                        Spacer(minLength: 25)
                        
                        HStack {
                           Text("Notifications")
                                .Bak(size: 18)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 25)
                        
                        Rectangle()
                            .fill(.secondMain)
                            .frame(height: 76)
                            .cornerRadius(16)
                            .padding(.horizontal)
                            .overlay {
                                HStack {
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text("Push Notifications")
                                            .Bak(size: 16)
                                        
                                        Text("Receive push notifications")
                                            .Bak(size: 14, color: .secondLabel)
                                    }
                                    
                                    Spacer()
                                    
                                    Toggle("", isOn: $betanoSettingsModel.isNotif)
                                        .toggleStyle(CustomToggleStyle())
                                }
                                .padding(.horizontal, 35)
                            }
                        
                        Spacer(minLength: 15)
                        
                        Rectangle()
                            .fill(.secondMain)
                            .frame(height: 76)
                            .cornerRadius(16)
                            .padding(.horizontal)
                            .overlay {
                                HStack {
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text("Haptic")
                                            .Bak(size: 16)
                                        
                                        Text("Turn on the vibration")
                                            .Bak(size: 14, color: .secondLabel)
                                    }
                                    
                                    Spacer()
                                    
                                    Toggle("", isOn: $betanoSettingsModel.isVib)
                                        .toggleStyle(CustomToggleStyle())
                                }
                                .padding(.horizontal, 35)
                            }
                        
                        Spacer(minLength: 25)
                        
                        HStack {
                           Text("Account")
                                .Bak(size: 18)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 25)
                        
                        Button(action: {
                            UserDefaultsManager().logout()
                            betanoSettingsModel.isLogOut = true
                            if UserDefaultsManager().isGuest() {
                                UserDefaultsManager().quitQuest()
                            }
                        }) {
                            Rectangle()
                                .fill(.secondMain)
                                .frame(height: 56)
                                .cornerRadius(16)
                                .padding(.horizontal)
                                .overlay {
                                    Text("Log out")
                                        .Bak(size: 16)
                                }
                        }
                        
                        Spacer(minLength: 15)
                        
                        if !UserDefaultsManager().isGuest() {
                            Button(action: {
                                UserDefaultsManager().deleteAccount()
                                betanoSettingsModel.isLogOut = true
                            }) {
                                Rectangle()
                                    .fill(.mainOrange)
                                    .frame(height: 56)
                                    .cornerRadius(16)
                                    .padding(.horizontal)
                                    .overlay {
                                        Text("Delete Account")
                                            .Bak(size: 16)
                                    }
                            }
                        }
                        
                        
                        Color(.clear)
                            .frame(height: 60)
                    }
                    .padding(.top)
                }
            }
            .fullScreenCover(isPresented: $betanoSettingsModel.isLogOut) {
                BetanoCreateAccountView()
            }
        }
    }
}

#Preview {
    BetanoSettingsView()
}
