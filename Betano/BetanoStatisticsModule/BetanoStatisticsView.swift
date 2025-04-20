import SwiftUI

struct StatData: Codable, Identifiable {
    var id = UUID().uuidString
    var date = Date()
    var timeDid: Int
    var totalTime: String
    var points: Int
    var activiry: String
    var image: String
}

struct BetanoStatisticsView: View {
    @StateObject var betanoStatisticsModel =  BetanoStatisticsViewModel()
    let columns = [GridItem(.flexible(), spacing: 0),
                   GridItem(.flexible(), spacing: 0)]

    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.mainBackground)
                    .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        HStack(spacing: 20) {
                            Text("Statistics")
                                .Bak(size: 20)
                                .padding(.leading)
                            
                            Spacer()
                        }
                        
                        HStack(spacing: 15) {
                            Button(action: {
                                betanoStatisticsModel.isDay = true
                                betanoStatisticsModel.isWeek = false
                                betanoStatisticsModel.isMounth = false
                            }) {
                                Rectangle()
                                    .fill(betanoStatisticsModel.isDay ? .mainOrange : .secondMain)
                                    .frame(width: 56, height: 40)
                                    .cornerRadius(12)
                                    .overlay {
                                        Text("Day")
                                            .Bak(size: 16)
                                    }
                            }
                            .padding(.leading)
                            
                            Button(action: {
                                betanoStatisticsModel.isDay = false
                                betanoStatisticsModel.isWeek = true
                                betanoStatisticsModel.isMounth = false
                            }) {
                                Rectangle()
                                    .fill(betanoStatisticsModel.isWeek ? .mainOrange : .secondMain)
                                    .frame(width: 67, height: 40)
                                    .cornerRadius(12)
                                    .overlay {
                                        Text("Week")
                                            .Bak(size: 16)
                                    }
                            }
                            
                            Button(action: {
                                betanoStatisticsModel.isDay = false
                                betanoStatisticsModel.isWeek = false
                                betanoStatisticsModel.isMounth = true
                            }) {
                                Rectangle()
                                    .fill(betanoStatisticsModel.isMounth ? .mainOrange : .secondMain)
                                    .frame(width: 73, height: 40)
                                    .cornerRadius(12)
                                    .overlay {
                                        Text("Month")
                                            .Bak(size: 16)
                                    }
                            }
                            
                            Spacer()
                        }
                        .padding(.top)
                        
                        Rectangle()
                            .fill(.secondMain)
                            .overlay {
                                VStack(spacing: 20) {
                                    HStack {
                                        Text("Today's Activity")
                                            .Bak(size: 18)
                                            .padding(.leading, 25)
                                        
                                        Spacer()
                                    }
                                    
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text("Total Time")
                                                .Bak(size: 14, color: .secondLabel)
                                            
                                            Text(betanoStatisticsModel.formatTime(seconds: betanoStatisticsModel.totalTime))
                                                .Bak(size: 24)
                                        }
                                        .padding(.leading, 25)
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .leading) {
                                            Text("Sessions")
                                                .Bak(size: 14, color: .secondLabel)
                                            
                                            Text("\(betanoStatisticsModel.sessionsCount)")
                                                .Bak(size: 24)
                                        }
                                        
                                        Spacer()
                                        
                                        VStack(alignment: .leading) {
                                            Text("Points")
                                                .Bak(size: 14, color: .secondLabel)
                                            
                                            Text("\(betanoStatisticsModel.totalPoints)")
                                                .Bak(size: 24, color: .mainOrange)
                                        }
                                        .padding(.trailing, 25)
                                        
                                        
                                    }
                                }
                            }
                            .frame(height: 144)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Activity Timeline")
                                .Bak(size: 18)
                                .padding(.leading)
                                .padding(.top)
                            
                            ForEach(betanoStatisticsModel.filteredStats) { stat in
                                Rectangle()
                                    .fill(.secondMain)
                                    .overlay {
                                        VStack {
                                            HStack {
                                                Image(stat.image)
                                                    .resizable()
                                                    .frame(width: 40, height: 40)
                                                
                                                Text(stat.activiry)
                                                    .Bak(size: 16)
                                                    .padding(.leading, 10)
                                                
                                                Spacer()
                                                
                                                Text(betanoStatisticsModel.formatTime(seconds: stat.timeDid))
                                                    .Bak(size: 14, color: .secondLabel)
                                            }
                                            .padding(.horizontal)
                                            .padding(.top, 10)
                                            
                                            GeometryReader { geometry in
                                                ZStack(alignment: .leading) {
                                                    Rectangle()
                                                        .fill(.mainBackground)
                                                        .frame(width: geometry.size.width * 0.9, height: 8)
                                                        .cornerRadius(4)
                                                        .padding(.horizontal)
                                                    
                                                    Rectangle()
                                                        .fill(.mainOrange)
                                                        .frame(
                                                            width: geometry.size.width * 0.9,
                                                            height: 8
                                                        )
                                                        .cornerRadius(4)
                                                        .padding(.horizontal)
                                                }
                                            }
                                        }
                                    }
                                    .frame(height: 88)
                                    .cornerRadius(16)
                                    .padding(.horizontal)
                            }
                        }
                        
                        Text("Most Used Timers")
                            .Bak(size: 18)
                            .padding(.leading)
                            .padding(.top)
                        
                        LazyVGrid(columns: columns, spacing: 25) {
                            ForEach(betanoStatisticsModel.timerGroups) { group in
                                Rectangle()
                                    .fill(.secondMain)
                                    .overlay {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 15) {
                                                Image(group.image)
                                                    .resizable()
                                                    .frame(width: 54, height: 54)
                                                
                                                VStack(alignment: .leading, spacing: 5) {
                                                    Text(group.name)
                                                        .Bak(size: 16)
                                                    
                                                    Text("\(group.count) sessions")
                                                        .Bak(size: 14, color: .secondLabel)
                                                }
                                            }
                                            .padding(.leading)
                                            
                                            Spacer()
                                        }
                                    }
                                    .frame(width: 178, height: 148)
                                    .cornerRadius(16)
                                    .padding(.horizontal)
                            }
                        }

                        
                        Color(.clear)
                            .frame(height: 90)
                    }
                    .padding(.top)
                }
            }
        }
    }
}

#Preview {
    BetanoStatisticsView()
}

