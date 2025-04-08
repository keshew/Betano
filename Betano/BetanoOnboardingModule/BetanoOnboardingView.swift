import SwiftUI

struct BetanoOnboardingView: View {
    @StateObject var betanoOnboardingModel =  BetanoOnboardingViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.mainBackground)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Rectangle()
                                .fill(betanoOnboardingModel.currentIndex == 0 ? .mainOrange : Color(red: 37/255, green: 38/255, blue: 55/255))
                                .frame(width: 32, height: 4)
                            
                            Rectangle()
                                .fill(betanoOnboardingModel.currentIndex == 1 ? .mainOrange : Color(red: 37/255, green: 38/255, blue: 55/255))
                                .frame(width: 32, height: 4)
                            
                            Rectangle()
                                .fill(betanoOnboardingModel.currentIndex == 2 ? .mainOrange : Color(red: 37/255, green: 38/255, blue: 55/255))
                                .frame(width: 32, height: 4)
                        }
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                betanoOnboardingModel.isSign = true
                            }) {
                                Text("Skip")
                                    .Bak(size: 16, color: .secondLabel)
                                    .padding(.trailing)
                            }
                        }
                        
                        Spacer(minLength: 20)
                        
                        Image(betanoOnboardingModel.contact.arrayImage[betanoOnboardingModel.currentIndex])
                            .resizable()
                            .frame(width: geometry.size.width, height: geometry.size.width > 450 ? 393 : 263)
                        
                        Spacer(minLength: 50)
                        
                        Text(betanoOnboardingModel.contact.arrayLabel[betanoOnboardingModel.currentIndex])
                            .Bak(size: 27)
                        
                        Spacer(minLength: 10)
                        
                        Text(betanoOnboardingModel.contact.arraySecondLabel[betanoOnboardingModel.currentIndex])
                            .Bak(size: 27, color: .secondLabel)
                            .multilineTextAlignment(.center)
                        
                        Spacer(minLength: 30)
                        
                        Image(betanoOnboardingModel.contact.arrayImageLabel[betanoOnboardingModel.currentIndex])
                            .resizable()
                            .frame(height: geometry.size.width > 450 ? 170 : 80)
                            .padding(.horizontal,  geometry.size.width > 450 ? 40 : 15)
                        
                        Spacer(minLength: 90)
                        
                        HStack {
                            Button(action: {
                                withAnimation {
                                    betanoOnboardingModel.currentIndex = max(betanoOnboardingModel.currentIndex - 1, 0)
                                }
                            }) {
                                Rectangle()
                                    .fill(.mainBackground)
                                    .frame(height: 58)
                                    .cornerRadius(12)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(betanoOnboardingModel.currentIndex == 0 ? .gray : .white, lineWidth: 0.5)
                                            .overlay {
                                                Text("Previous")
                                                    .Bak(size: 16, color: betanoOnboardingModel.currentIndex == 0 ? .secondLabel : .white)
                                            }
                                    }
                            }
                            .padding(.leading, 40)
                            .padding(.trailing, 10)
                            
                            Button(action: {
                                withAnimation {
                                    if betanoOnboardingModel.currentIndex <= 1 {
                                        betanoOnboardingModel.currentIndex += 1
                                    } else {
                                        betanoOnboardingModel.isSign = true
                                    }
                                }
                            }) {
                                Rectangle()
                                    .fill(.mainOrange)
                                    .frame(height: 58)
                                    .cornerRadius(12)
                                    .overlay {
                                        Text("Next")
                                            .Bak(size: 16)
                                    }
                            }
                            .padding(.trailing, 40)
                            .padding(.leading, 10)
                            
                        }
                    }
                    .padding(.top)
                }
            }
            .fullScreenCover(isPresented: $betanoOnboardingModel.isSign) {
                BetanoCreateAccountView()
            }
        }
    }
}

#Preview {
    BetanoOnboardingView()
}

