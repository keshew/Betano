import SwiftUI

struct BetanoCreateTimerView: View {
    @StateObject var betanoCreateTimerModel =  BetanoCreateTimerViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State var minutes = 0
    @State var hours = 0
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
                                DateTF(hour: $hours)
                                
                                TimeTF(minutes: $minutes)
                                
                            }
                        }
                        
                        Spacer(minLength: 80)
                        
                        Text("Cost: 100 points")
                            .Bak(size: 20)
                        
                        Button(action: {
                            if betanoCreateTimerModel.nameTimer.isEmpty {
                                alertMessage = "Please enter timer name"
                                showAlert = true
                            } else {
                                if UserDefaults.standard.integer(forKey: "points") >= 100 {
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
                                    
                                    let newTimer = TimerModel(name: betanoCreateTimerModel.nameTimer, category: selectedCategory, icon: selectedIcon, hour: String(hours), minute: String(minutes))
                                    
                                    userDefaultsManager.appendTimer(newTimer)
                                    UserDefaultsManager().addPoints(-100)
                                    presentationMode.wrappedValue.dismiss()
                                    
                                } else {
                                    alertMessage = "You don't have enough points"
                                    showAlert = true
                                }
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

struct DateTF: View {
    @Binding var hour: Int

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.secondMain)
                .frame(height: 88)
                .cornerRadius(12)
                .overlay {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Hours")
                                .Bak(size: 12, color: .secondLabel)
                            
                            Text("\(hour)")
                                .Bak(size: 24)
                        }
                        .padding(.leading, 15)
                        
                        Spacer()
                    }
                }
            
            Picker(selection: $hour, label: Text("Hours")) {
                ForEach(0..<24) { min in
                    Text("\(min) hour").tag(min)
                        
                }
            }
            .frame(height: 88)
            .colorMultiply(.clear)
        }
        .labelsHidden()
        .frame(height: 88)
        .padding(.leading)
    }
}


struct TimeTF: View {
    @Binding var minutes: Int
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.secondMain)
                    .frame(height: 88)
                    .cornerRadius(12)
                    .overlay {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Minutes")
                                    .Bak(size: 12, color: .secondLabel)
                                
                                Text("\(minutes)")
                                    .Bak(size: 24)
                            }
                            .padding(.leading, 15)
                            
                            Spacer()
                        }
                    }
                
                Picker(selection: $minutes, label: Text("Minutes")) {
                    ForEach(0..<60) { min in
                        Text("\(min) minutes").tag(min)
                            
                    }
                }
                .frame(height: 88)
                .colorMultiply(.clear)
            }
            .labelsHidden()
            .frame(height: 88)
        }
        .padding(.trailing)
    }
}
