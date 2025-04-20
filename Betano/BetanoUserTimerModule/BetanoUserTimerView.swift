import SwiftUI

struct BetanoUserTimerView: View {
    @StateObject var betanoUserTimerModel =  BetanoUserTimerViewModel()
    @Environment(\.presentationMode) var presentationMode
    var model: TimerModel
    
    func saveTimer() {
        let data = StatData(timeDid: betanoUserTimerModel.totalSeconds,
                            totalTime: model.hour + model.minute,
                            points: betanoUserTimerModel.points,
                            activiry: model.name,
                            image: model.icon.rawValue)
        
        UserDefaultsManager().add(data)
    }
    
    var body: some View {
        GeometryReader { geometry in
            if betanoUserTimerModel.isTimerEnd {
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
                        
                        Spacer(minLength: 50)
                        
                        Rectangle()
                            .fill(.secondMain)
                            .frame(height: 156)
                            .cornerRadius(16)
                            .padding(.horizontal)
                            .overlay {
                                VStack(spacing: 5) {
                                    Image(.fire)
                                        .resizable()
                                        .frame(width: 21, height: 33)
                                    
                                    Text("You're doing great!")
                                        .Bak(size: 18)
                                    
                                    Text("Keep going! You're more than halfway\nthere!")
                                        .Bak(size: 16, color: .secondLabel)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        
                        Spacer(minLength: 20)
                        
                        Rectangle()
                            .fill(.mainOrange)
                            .frame(height: 56)
                            .cornerRadius(12)
                            .padding(.horizontal)
                            .overlay {
                                Button(action: {
                                    betanoUserTimerModel.isBackHome = true
                                }) {
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
                .onAppear {
                    saveTimer()
                }
                .fullScreenCover(isPresented: $betanoUserTimerModel.isBackHome) {
                    BetanoTabBarView()
                }
            } else {
                UserTimer(betanoUserTimerModel: betanoUserTimerModel,
                          time: model.hour,
                          model: model) {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

#Preview {
    BetanoUserTimerView(model: TimerModel(name: "", category: .other, icon: .basket, hour: "", minute: ""))
}
