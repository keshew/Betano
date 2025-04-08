import SwiftUI

struct BetanoCreateAccountView: View {
    @StateObject var betanoCreateAccountModel = BetanoCreateAccountViewModel()
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
                                Text("Create Account")
                                    .Bak(size: 30)
                                
                                Text("Track your fitness journey and earn rewards")
                                    .Bak(size: 16, color: .secondLabel)
                            }
                            .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 30)
                        
                        VStack(spacing: 15) {
                            CustomTextFiled(text: $betanoCreateAccountModel.name,
                                            geometry: geometry,
                                            placeholder: "Full Name",
                                            image: BetanoImageName.profile.rawValue)
                            
                            CustomTextFiled(text: $betanoCreateAccountModel.email,
                                            geometry: geometry,
                                            placeholder: "Email Adress",
                                            image: BetanoImageName.email.rawValue)
                            
                            CustomSecureFiled(text: $betanoCreateAccountModel.password,
                                            geometry: geometry,
                                            placeholder: "Password")
                            
                            CustomSecureFiled(text: $betanoCreateAccountModel.secondPassword,
                                            geometry: geometry,
                                            placeholder: "Confirm Password")
                        }
                        
                        Spacer(minLength: 20)
                        
                        Button(action: {
                            betanoCreateAccountModel.registerUser()
                        }) {
                            Rectangle()
                                .fill(.mainOrange)
                                .frame(height: 58)
                                .cornerRadius(12)
                                .overlay {
                                    Text("Create Account")
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
                            betanoCreateAccountModel.isGuest = true
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
                            Text("Already have an account?")
                                .Bak(size: 16, color: .secondLabel)
                            
                            Button(action: {
                                betanoCreateAccountModel.isLogIn = true
                            }) {
                                Text("Log in")
                                    .Bak(size: 16, color: .mainOrange)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .alert(betanoCreateAccountModel.alertMessage, isPresented: $betanoCreateAccountModel.showRegistrationAlert) {
                Button("OK", role: .cancel) {}
            }
            
            .fullScreenCover(isPresented: $betanoCreateAccountModel.isLogIn) {
                BetanoLogInView()
            }
            
            .fullScreenCover(isPresented: $betanoCreateAccountModel.isGuest) {
                BetanoTabBarView()
            }
        }
    }
}

#Preview {
    BetanoCreateAccountView()
}
