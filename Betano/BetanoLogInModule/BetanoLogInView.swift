import SwiftUI

struct BetanoLogInView: View {
    @StateObject var betanoLogInModel = BetanoLogInViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.mainBackground)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(.arrowLeft)
                                    .resizable()
                                    .frame(width: 18, height: 20)
                                    .padding(.leading)
                            }
                            
                            Spacer()
                        }
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Welcome Back")
                                    .Bak(size: 30)
                                
                                Text("Login to continue your fitness journey")
                                    .Bak(size: 16, color: .secondLabel)
                            }
                            .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 30)
                        
                        VStack(spacing: 15) {
                            CustomTextFiled(text: $betanoLogInModel.email,
                                            geometry: geometry,
                                            placeholder: "Email Adress",
                                            image: BetanoImageName.email.rawValue)
                            
                            CustomSecureFiled(text: $betanoLogInModel.password,
                                            geometry: geometry,
                                            placeholder: "Password")
                        }
                        
                        Spacer(minLength: 45)
                        
                        Button(action: {
                            betanoLogInModel.loginUser()
                        }) {
                            Rectangle()
                                .fill(.mainOrange)
                                .frame(height: 58)
                                .cornerRadius(12)
                                .overlay {
                                    Text("Log in")
                                        .Bak(size: 16)
                                }
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 40)
                        
                        HStack {
                            Rectangle()
                                .fill(.gray)
                                .frame(height: 0.5)
                                .padding(.leading, 20)
                                .padding(.trailing, 50)
                            
                            Text("or")
                                .Bak(size: 16,
                                     color: .secondLabel)
                            
                            Rectangle()
                                .fill(.gray)
                                .frame(height: 0.5)
                                .padding(.trailing, 20)
                                .padding(.leading, 50)
                        }
                        
                        Spacer(minLength: 40)
                        
                        Button(action: {
                            betanoLogInModel.isGuest = true
                            UserDefaultsManager().enterAsGuest()
                        }) {
                            Rectangle()
                                .fill(.mainBackground)
                                .frame(height: 58)
                                .cornerRadius(12)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.gray, lineWidth: 0.3)
                                    .overlay(
                                        Text("Continue as Guest")
                                            .Bak(size: 16, color: .secondLabel)
                                    )
                                }
                        }
                        .padding(.horizontal)
                        
                        Spacer(minLength: 40)
                        
                        HStack {
                            Text("Don't have an account?")
                                .Bak(size: 16, color: .secondLabel)
                            
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Text("Create Account")
                                    .Bak(size: 16, color: .mainOrange)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .alert(betanoLogInModel.alertMessage, isPresented: $betanoLogInModel.showLoginAlert) {
                Button("OK", role: .cancel) {}
            }
            .fullScreenCover(isPresented: $betanoLogInModel.isTab) {
                BetanoTabBarView()
            }
            .fullScreenCover(isPresented: $betanoLogInModel.isGuest) {
                BetanoTabBarView()
            }
        }
    }
}

#Preview {
    BetanoLogInView()
}
