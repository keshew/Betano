import SwiftUI

struct BetanoTimerView: View {
    @StateObject var betanoTimerModel = BetanoTimerViewModel()
    @Environment(\.presentationMode) var presentationMode
    var model: TimerModel
    
    var body: some View {
        GeometryReader { geometry in
            if betanoTimerModel.isTimerEnd {
                ZStack {
                    Color(.mainBackground)
                        .ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            HStack(spacing: 20) {
                                Button(action: {
                                    presentationMode.wrappedValue.dismiss()
                                }) {
                                    Circle()
                                        .fill(.secondMain)
                                        .frame(width: 40, height: 40)
                                        .padding(.leading)
                                        .overlay {
                                            Image(.back)
                                                .resizable()
                                                .frame(width: 18, height: 20)
                                                .padding(.leading)
                                        }
                                }
                                
                                Text("Start Timer")
                                    .Bak(size: 20)
                                
                                Spacer()
                            }
                            
                            Spacer(minLength: 30)
                            
                            VStack(spacing: 15) {
                                Text("You've Trained Like a\nChampion!")
                                    .Bak(size: 24)
                                    .multilineTextAlignment(.center)
                                
                                Text("Basketball Practice" + " " + "Completed")
                                    .Bak(size: 16, color: .secondLabel)
                            }
                            
                            Spacer(minLength: 20)
                            
                            HStack {
                                Rectangle()
                                    .fill(.secondMain)
                                    .frame(height: 144)
                                    .cornerRadius(16)
                                    .padding(.leading)
                                    .padding(.trailing, 5)
                                    .overlay {
                                        VStack {
                                            Image(.time2)
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            
                                            VStack(spacing: -3) {
                                                Text("Time")
                                                    .Bak(size: 14, color: .secondLabel)
                                                
                                                Text("\(String(format: "%02d:%02d", Int(model.minute) ?? 0, 0))")
                                                    .Bak(size: 24)
                                            }
                                            .padding(.top, 5)
                                        }
                                        .padding(.leading, 10)
                                    }
                                
                                Rectangle()
                                    .fill(.secondMain)
                                    .frame(height: 144)
                                    .cornerRadius(16)
                                    .padding(.trailing)
                                    .padding(.leading, 5)
                                    .overlay {
                                        VStack {
                                            Image(.point)
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                            
                                            VStack(spacing: -3) {
                                                Text("Points Earned")
                                                    .Bak(size: 14, color: .secondLabel)
                                                
                                                Text("+\(betanoTimerModel.points)")
                                                    .Bak(size: 24)
                                            }
                                            .padding(.top, 5)
                                        }
                                        .padding(.trailing, 10)
                                    }
                            }
                            
                            Spacer(minLength: 20)
                            
                            Rectangle()
                                .fill(.secondMain)
                                .frame(height: 208)
                                .cornerRadius(16)
                                .padding(.horizontal)
                                .overlay {
                                    VStack {
                                        Image(.gift2)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .padding(.bottom, 10)
                                        
                                        Text("Spin & Win Available!")
                                            .Bak(size: 18)
                                        
                                        Text("You've unlocked a reward spin")
                                            .Bak(size: 14, color: .secondLabel)
                                            .padding(.bottom, 10)
                                        
                                        Button(action: {
                                            betanoTimerModel.isSpin = true
                                        }) {
                                            Rectangle()
                                                .fill(.mainOrange)
                                                .frame(height: 56)
                                                .cornerRadius(16)
                                                .padding(.horizontal, 40)
                                                .overlay {
                                                    HStack {
                                                        Image(.spin)
                                                            .resizable()
                                                            .frame(width: 16, height: 16)
                                                        
                                                        Text("Spin the Wheel")
                                                            .Bak(size: 16)
                                                    }
                                                }
                                        }
                                    }
                                }
                            
                            Spacer(minLength: 20)
                            
                            Button(action: {
                                betanoTimerModel.isShare = true
                            }) {
                                Rectangle()
                                    .fill(.secondMain)
                                    .frame(height: 56)
                                    .cornerRadius(16)
                                    .padding(.horizontal)
                                    .overlay {
                                        HStack {
                                            Image(.share)
                                                .resizable()
                                                .frame(width: 14, height: 16)
                                            
                                            Text("Share Achievement")
                                                .Bak(size: 16)
                                        }
                                    }
                            }
                            
                            Spacer(minLength: 20)
                            
                            Button(action: {
                                betanoTimerModel.isBackHome = true
                            }) {
                                Rectangle()
                                    .fill(.mainOrange)
                                    .frame(height: 56)
                                    .cornerRadius(16)
                                    .padding(.horizontal)
                                    .overlay {
                                        
                                        HStack {
                                            Image(.home)
                                                .resizable()
                                                .frame(width: 18, height: 16)
                                            
                                            Text("Back to Home")
                                                .Bak(size: 16)
                                        }
                                    }
                            }
                        }
                        .padding(.top)
                    }
                }
                .onAppear {
                    UserDefaultsManager().addPoints(betanoTimerModel.points)
                }
                .fullScreenCover(isPresented: $betanoTimerModel.isSpin) {
                    BetanoSpinView()
                }
                
                .fullScreenCover(isPresented: $betanoTimerModel.isBackHome) {
                    BetanoTabBarView()
                }
                
                //MARK: - Сюда ссылку, которую будем отправлять при шейринге
                .sheet(isPresented: $betanoTimerModel.isShare) {
                          ActivityViewController(activityItems: [""], applicationActivities: nil)
                      }
            } else {
                PrecreatedTimer(betanoTimerModel: betanoTimerModel,
                                model: model,
                                time: model.minute) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

#Preview {
    BetanoTimerView(model: TimerModel(name: "", category: .other, icon: .basket, hour: "30", minute: "20"))
}


