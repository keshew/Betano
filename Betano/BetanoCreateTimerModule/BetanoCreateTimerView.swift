import SwiftUI

struct BetanoCreateTimerView: View {
    @StateObject var betanoCreateTimerModel =  BetanoCreateTimerViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
                                Image(.back)
                                    .resizable()
                                    .frame(width: 18, height: 20)
                                    .padding(.leading)
                            }
                            
                            Text("Create New Timer")
                                .Bak(size: 20)
                            
                            Spacer()
                        }
                        
                        Spacer(minLength: 20)
                        
                        VStack {
                            HStack {
                                Text("Timer Name")
                                    .Bak(size: 14, color: .secondLabel)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            CustomTextFiled2(text: $betanoCreateTimerModel.nameTimer,
                                             geometry: geometry,
                                             placeholder: "Enter time name")
                        }
                        
                        Spacer(minLength: 30)
                        
                        VStack {
                            HStack {
                                Text("Select Category")
                                    .Bak(size: 14, color: .secondLabel)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            HStack(spacing: 15) {
                                Button(action: {
                                    betanoCreateTimerModel.isSport = true
                                    betanoCreateTimerModel.isWork = false
                                    betanoCreateTimerModel.isOther = false
                                }) {
                                    Rectangle()
                                        .fill(betanoCreateTimerModel.isSport ? .mainOrange : .secondMain)
                                        .frame(width: 104, height: 40)
                                        .cornerRadius(12)
                                        .overlay {
                                            Text("Sports")
                                                .Bak(size: 16)
                                        }
                                }
                                .padding(.leading)
                                
                                Button(action: {
                                    betanoCreateTimerModel.isSport = false
                                    betanoCreateTimerModel.isWork = true
                                    betanoCreateTimerModel.isOther = false
                                }) {
                                    Rectangle()
                                        .fill(betanoCreateTimerModel.isWork ? .mainOrange : .secondMain)
                                        .frame(width: 94, height: 40)
                                        .cornerRadius(12)
                                        .overlay {
                                            Text("Work")
                                                .Bak(size: 16)
                                        }
                                }
                                
                                Button(action: {
                                    betanoCreateTimerModel.isSport = false
                                    betanoCreateTimerModel.isWork = false
                                    betanoCreateTimerModel.isOther = true
                                }) {
                                    Rectangle()
                                        .fill(betanoCreateTimerModel.isOther ? .mainOrange : .secondMain)
                                        .frame(width: 94, height: 40)
                                        .cornerRadius(12)
                                        .overlay {
                                            Text("Other")
                                                .Bak(size: 16)
                                        }
                                }
                                
                                Spacer()
                            }
                        }
                        
                        Spacer(minLength: 30)
                        
                        VStack {
                            HStack {
                                Text("Select Icon")
                                    .Bak(size: 14, color: .secondLabel)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            HStack(spacing: 15) {
                                Button(action: {
                                    betanoCreateTimerModel.isIcon1 = true
                                    betanoCreateTimerModel.isIcon2 = false
                                    betanoCreateTimerModel.isIcon3 = false
                                }) {
                                    Image(betanoCreateTimerModel.isIcon1 ? .icon1Select : .icon1)
                                        .resizable()
                                        .frame(width: 77, height: 77)
                                }
                                .padding(.leading)
                                
                                Button(action: {
                                    betanoCreateTimerModel.isIcon1 = false
                                    betanoCreateTimerModel.isIcon2 = true
                                    betanoCreateTimerModel.isIcon3 = false
                                }) {
                                    Image(betanoCreateTimerModel.isIcon2 ? .icon2Select : .icon2)
                                        .resizable()
                                        .frame(width: 77, height: 77)
                                }
                                
                                Button(action: {
                                    betanoCreateTimerModel.isIcon1 = false
                                    betanoCreateTimerModel.isIcon2 = false
                                    betanoCreateTimerModel.isIcon3 = true
                                }) {
                                    Image(betanoCreateTimerModel.isIcon3 ? .icon3Select : .icon3)
                                        .resizable()
                                        .frame(width: 77, height: 77)
                                }
                                
                                Spacer()
                            }
                        }
                        
                        Spacer(minLength: 30)
                        
                        VStack {
                            HStack {
                                Text("Set Duration")
                                    .Bak(size: 14, color: .secondLabel)
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            
                            HStack(spacing: 25) {
                                DateTF(date: $betanoCreateTimerModel.date)
                                
                                TimeTF(time: $betanoCreateTimerModel.time)
                            }
                        }
                        
                        Spacer(minLength: 80)
                        
                        Button(action: {
                            if betanoCreateTimerModel.nameTimer.isEmpty {
                                alertMessage = "Please enter timer name"
                                showAlert = true
                            } else {
                                let userDefaultsManager = UserDefaultsManager()
                                
                                var selectedCategory: CategoryTimer = .sports
                                if betanoCreateTimerModel.isSport {
                                    selectedCategory = .sports
                                } else if betanoCreateTimerModel.isWork {
                                    selectedCategory = .work
                                } else {
                                    selectedCategory = .other
                                }
                                
                                var selectedIcon: IconTimer = .basket
                                if betanoCreateTimerModel.isIcon1 {
                                    selectedIcon = .showIcon2
                                } else if betanoCreateTimerModel.isIcon2 {
                                    selectedIcon = .showIcon1
                                } else {
                                    selectedIcon = .showIcon3
                                }
                                
                                let calendar = Calendar.current
                                let hour = String(calendar.component(.hour, from: betanoCreateTimerModel.date))
                                let minute = String(calendar.component(.minute, from: betanoCreateTimerModel.time))
                                
                                let newTimer = TimerModel(name: betanoCreateTimerModel.nameTimer, category: selectedCategory, icon: selectedIcon, hour: hour, minute: minute)
                                
                                userDefaultsManager.appendTimer(newTimer)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Rectangle()
                                .fill(.mainOrange)
                                .frame(height: 56)
                                .cornerRadius(16)
                                .padding(.horizontal)
                                .overlay {
                                    HStack {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 14, weight: .bold, design: .default))
                                            .foregroundStyle(.white)
                                        
                                        Text("Save Timer")
                                            .Bak(size: 16)
                                    }
                                }
                            
                        }
                    }
                    .padding(.top)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}


#Preview {
    BetanoCreateTimerView()
}
