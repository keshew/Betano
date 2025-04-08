import SwiftUI

struct BetanoHomeView: View {
    @StateObject var betanoHomeModel =  BetanoHomeViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.mainBackground)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(UserDefaultsManager().isGuest() ? "Guest" : "Hi, \(UserDefaultsManager().getNickname(for: UserDefaultsManager().getEmail() ?? "Name") ?? "Name")!")
                                    .Bak(size: 18)
                                   
                                Text("Ready to workout?")
                                    .Bak(size: 14, color: .secondLabel)
                            }
                            .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 20)
                        
                        Rectangle()
                            .fill(.secondMain)
                            .frame(height: 84)
                            .cornerRadius(16)
                            .padding(.horizontal)
                            .overlay {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Your Points")
                                            .Bak(size: 14, color: .secondLabel)
                                        
                                        Text("\(UserDefaults.standard.integer(forKey: "points"))")
                                            .Bak(size: 20)
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        betanoHomeModel.isSpin = true
                                    }) {
                                        Image(.rewards)
                                            .resizable()
                                            .frame(width: 120, height: 40)
                                    }
                                    .opacity(UserDefaultsManager().isGuest() ? 0.5 : 1)
                                    .disabled(UserDefaultsManager().isGuest() ? true : false)
                                }
                                .padding(.horizontal, 30)
                            }
                        
                        Spacer(minLength: 20)
                        
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Your Timers")
                                    .Bak(size: 20)
                            }
                            .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 20)
                        
                        VStack(spacing: 15) {
                            ForEach(betanoHomeModel.timers.indices, id: \.self) { index in
                                if betanoHomeModel.timers[index].category == .precreated {
                                    TimersView(image: betanoHomeModel.timers[index].icon.rawValue,
                                               timerName: betanoHomeModel.timers[index].name,
                                               timeCount: "\(betanoHomeModel.timers[index].minute) minutes")
                                    .onTapGesture {
                                        if !UserDefaultsManager().isGuest() {
                                            betanoHomeModel.isPrecreatedTimerTapped = true
                                            betanoHomeModel.precreatedModel = betanoHomeModel.timers[index]
                                        }
                                    }
                                } else {
                                    TimersView(image: betanoHomeModel.timers[index].icon.rawValue,
                                               timerName: betanoHomeModel.timers[index].name,
                                               timeCount: "\(betanoHomeModel.timers[index].hour) hours \(betanoHomeModel.timers[index].minute) minutes")
                                    .onTapGesture {
                                        if !UserDefaultsManager().isGuest() {
                                            betanoHomeModel.isUserTimerTapped = true
                                            betanoHomeModel.userModel = betanoHomeModel.timers[index]
                                        }
                                    }
                                }
                            }
                        }
                        
                        Spacer(minLength: 15)
                        
                        Button(action: {
                            betanoHomeModel.isAdd = true
                        }) {
                            Rectangle()
                                .fill(.mainOrange)
                                .frame(height: 56)
                                .cornerRadius(16)
                                .padding(.horizontal)
                                .overlay {
                                    HStack {
                                        Image(.plus)
                                            .resizable()
                                            .frame(width: 14, height: 16)
                                        
                                        Text("Add New Timer")
                                            .Bak(size: 16)
                                    }
                                }
                        }
                        .opacity(UserDefaultsManager().isGuest() ? 0.5 : 1)
                        .disabled(UserDefaultsManager().isGuest() ? true : false)
                        
                        Color(.clear)
                            .frame(height: 70)
                    }
                    .padding(.top)
                }
            }
            .onChange(of: betanoHomeModel.isAdd) { _ in
                if !betanoHomeModel.isAdd {
                     betanoHomeModel.loadTimers()
                 }
            }
            .fullScreenCover(isPresented: $betanoHomeModel.isAdd) {
                BetanoCreateTimerView()
            }
            
            .fullScreenCover(isPresented: $betanoHomeModel.isSpin) {
                BetanoSpinView()
            }
            
            .fullScreenCover(isPresented: $betanoHomeModel.isPrecreatedTimerTapped) {
                BetanoTimerView(model: betanoHomeModel.precreatedModel)
            }
            
            .fullScreenCover(isPresented: $betanoHomeModel.isUserTimerTapped) {
                BetanoUserTimerView(model: betanoHomeModel.userModel)
            }
        }
    }
}

#Preview {
    BetanoHomeView()
}

struct TimersView: View {
    var image: String
    var timerName: String
    var timeCount: String
    var body: some View {
        Rectangle()
            .fill(.secondMain)
            .frame(height: 80)
            .cornerRadius(16)
            .padding(.horizontal)
            .overlay {
                HStack {
                    Image(image)
                        .resizable()
                        .frame(width: 48, height: 48)
                    
                    VStack(alignment: .leading) {
                        Text(timerName)
                            .Bak(size: 16)
                            .lineLimit(1)
                        
                        Text(timeCount)
                            .Bak(size: 14, color: .secondLabel)
                            .lineLimit(1)
                    }
                    .padding(.horizontal, 8)
                    
                    Spacer()
                    
                    Image(.play)
                        .resizable()
                        .frame(width: 12, height: 18)
                        .padding(.trailing, 5)
                }
                .padding(.horizontal, 30)
            }
    }
}
