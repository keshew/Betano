import SwiftUI

struct BetanoProfileView: View {
    @StateObject var betanoProfileModel =  BetanoProfileViewModel()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.mainBackground)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Profile")
                                .Bak(size: 20)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        Rectangle()
                            .fill(.secondMain)
                            .frame(height: 104)
                            .cornerRadius(16)
                            .padding(.horizontal)
                            .overlay {
                                VStack(spacing: 10) {
                                    Text(UserDefaultsManager().isGuest() ? "Guest" : "\(UserDefaultsManager().getNickname(for: UserDefaultsManager().getEmail() ?? "Name") ?? "Name")")
                                        .Bak(size: 20)
                                        .lineLimit(1)
                                    
                                    Text(UserDefaultsManager().isGuest() ? "Guest" : "\(UserDefaultsManager().getEmail() ?? "Email")")
                                        .Bak(size: 16, color: .secondLabel)
                                        .lineLimit(1)
                                }
                                .padding(.horizontal, 20)
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
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Image(.time)
                                                    .resizable()
                                                    .frame(width: 48, height: 48)
                                                
                                                Text("\(UserDefaultsManager().calculateTotalMinutesForAllTimers())")
                                                    .Bak(size: 24)
                                                
                                                Text("Minutes Active")
                                                    .Bak(size: 14, color: .secondLabel)
                                            }
                                            .padding(.leading, 30)
                                            
                                            Spacer()
                                        }
                                    }
                                }
                            
                            Rectangle()
                                .fill(.secondMain)
                                .frame(height: 144)
                                .cornerRadius(16)
                                .padding(.trailing)
                                .padding(.leading, 5)
                                .overlay {
                                    VStack {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Image(.gift)
                                                    .resizable()
                                                    .frame(width: 48, height: 48)
                                                
                                                Text("\(UserDefaults.standard.integer(forKey: "countWheelTapped"))")
                                                    .Bak(size: 24)
                                                
                                                Text("Rewards Earned")
                                                    .Bak(size: 14, color: .secondLabel)
                                            }
                                            .padding(.leading, 20)
                                            
                                            Spacer()
                                        }
                                    }
                                }
                        }
                        
                        Spacer(minLength: 25)
                        
                        HStack {
                            Text("Achievements")
                                .Bak(size: 20)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        VStack(spacing: 20) {
                            Rectangle()
                                .fill(.secondMain)
                                .frame(height: 80)
                                .cornerRadius(16)
                                .padding(.horizontal)
                                .overlay {
                                    HStack {
                                        Image(.achiv1)
                                            .resizable()
                                            .frame(width: 48, height: 48)
                                            .padding(.leading, 10)
                                        
                                        VStack(alignment: .leading) {
                                            Text("Early Bird")
                                                .Bak(size: 16)
                                            
                                            Text("Complete 5 morning workouts")
                                                .Bak(size: 14, color: .secondLabel)
                                        }
                                        .padding(.leading, 10)
                                        
                                        Spacer()
                                        
                                        Image(UserDefaults.standard.integer(forKey: "timersCompleted") == 5 ? .done : .undone)
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .padding(.trailing)
                                    }
                                    .padding(.horizontal, 20)
                                }
                            
                            Rectangle()
                                .fill(.secondMain)
                                .frame(height: 80)
                                .cornerRadius(16)
                                .padding(.horizontal)
                                .overlay {
                                    HStack {
                                        Image(.achiv2)
                                            .resizable()
                                            .frame(width: 48, height: 48)
                                            .padding(.leading, 10)
                                        
                                        VStack(alignment: .leading) {
                                            Text("Power User")
                                                .Bak(size: 16)
                                            
                                            Text("Track 1000 minutes of activity")
                                                .Bak(size: 14, color: .secondLabel)
                                        }
                                        .padding(.leading, 10)
                                        
                                        Spacer()
                                        
                                        Image(UserDefaultsManager().calculateTotalMinutesForAllTimers() >= 1000 ? .done : .undone)
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .padding(.trailing)
                                    }
                                    .padding(.horizontal, 20)
                                }
                            
                            Rectangle()
                                .fill(.secondMain)
                                .frame(height: 80)
                                .cornerRadius(16)
                                .padding(.horizontal)
                                .overlay {
                                    HStack {
                                        Image(.achiv3)
                                            .resizable()
                                            .frame(width: 48, height: 48)
                                            .padding(.leading, 10)
                                        
                                        VStack(alignment: .leading) {
                                            Text("Consistent Athlete")
                                                .Bak(size: 16)
                                            
                                            Text("Work out 7 days in a row")
                                                .Bak(size: 14, color: .secondLabel)
                                        }
                                        .padding(.leading, 10)
                                        
                                        Spacer()
                                        
                                        Image(betanoProfileModel.isConsecutiveDaysCompleted ? .done : .undone)
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .padding(.trailing)
                                    }
                                    .padding(.horizontal, 20)
                                }
                        }
                        
                        Color(.clear)
                            .frame(height: 60)
                    }
                    .padding(.top)
                }
            }
            .onAppear {
                betanoProfileModel.isConsecutiveDaysCompleted = UserDefaultsManager().checkConsecutiveDays()
                  }
        }
    }
}

#Preview {
    BetanoProfileView()
}

