import SwiftUI

struct CustomTextFiled2: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var geometry: GeometryProxy
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 37/255, green: 38/255, blue: 55/255))
                .frame(height: 48)
                .cornerRadius(12)
                .padding(.horizontal, 15)
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .padding(.horizontal, 16)
            .frame(height: 48)
            .font(.custom("BakbakOne-Regular", size: 15))
            .cornerRadius(9)
            .foregroundStyle(Color(red: 174/255, green: 174/255, blue: 187/255))
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            
            HStack(spacing: -13) {
                if text.isEmpty && !isTextFocused {
                    Text(placeholder)
                        .Bak(size: 16, color: .secondLabel)
                        .padding(.leading, 25)
                        .onTapGesture {
                            isTextFocused = true
                        }
                }
            }
            .padding(.leading, 5)
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabType
    
    enum TabType: Int {
        case Home
        case Settings
        case Profile
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                Rectangle()
                    .fill(.secondMain)
                    .frame(width: 280, height: 70)
                    .cornerRadius(30)
                    .edgesIgnoringSafeArea(.bottom)
            }
            
            HStack(spacing: 50) {
                TabBarItem(imageName: "tab1", tab: .Home, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab2", tab: .Settings, selectedTab: $selectedTab)
                TabBarItem(imageName: "tab3", tab: .Profile, selectedTab: $selectedTab)
            }
            .padding(.top, -5)
            .frame(height: 60)
        }
    }
}

struct TabBarItem: View {
    let imageName: String
    let tab: CustomTabBar.TabType
    @Binding var selectedTab: CustomTabBar.TabType
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 8) {
                Image(selectedTab == tab ? imageName + "Picked" : imageName)
                    .resizable()
                    .frame(width: tab == .Settings ? 19 : tab == .Profile ? 18 : 22, height: 20)
                    .opacity(selectedTab == tab ? 1 : 0.4)
                
                Text("\(tab)")
                    .Bak(size: 12, color: selectedTab == tab ? .mainOrange : .secondLabel)
            }
            
        }
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(configuration.isOn ? .mainOrange : Color(red: 75/255, green: 85/255, blue: 99/255))
                .frame(width: 54, height: 27)
                .overlay(
                    Circle()
                        .fill(.white)
                        .frame(width: 22, height: 22)
                        .offset(x: configuration.isOn ? 12 : -12)
                        .animation(.easeInOut, value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

struct CustomTextFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var geometry: GeometryProxy
    var placeholder: String
    var image: String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 37/255, green: 38/255, blue: 55/255))
                .frame(height: 56)
                .cornerRadius(12)
                .padding(.horizontal, 15)
            
            TextField("", text: $text, onEditingChanged: { isEditing in
                if !isEditing {
                    isTextFocused = false
                }
            })
            .padding(.horizontal, 16)
            .frame(height: 56)
            .font(.custom("BakbakOne-Regular", size: 15))
            .cornerRadius(9)
            .foregroundStyle(Color(red: 174/255, green: 174/255, blue: 187/255))
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            .padding(.leading, 30)
            
            HStack(spacing: -13) {
                Image(image)
                    .resizable()
                    .frame(width: image == "email" ? 16 : 14, height: 16)
                    .padding(.leading, 30)
                if text.isEmpty && !isTextFocused {
                    Text(placeholder)
                        .Bak(size: 16, color: .secondLabel)
                        .padding(.leading, 30)
                        .onTapGesture {
                            isTextFocused = true
                        }
                }
            }
            .padding(.leading, 5)
        }
    }
}

struct CustomSecureFiled: View {
    @Binding var text: String
    @FocusState var isTextFocused: Bool
    var geometry: GeometryProxy
    var placeholder: String
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color(red: 37/255, green: 38/255, blue: 55/255))
                .frame(height: 56)
                .cornerRadius(12)
                .padding(.horizontal, 15)
            
            SecureField("", text: $text)
            .padding(.horizontal, 16)
            .frame(height: 56)
            .font(.custom("BakbakOne-Regular", size: 16))
            .cornerRadius(9)
            .foregroundStyle(Color(red: 174/255, green: 174/255, blue: 187/255))
            .focused($isTextFocused)
            .padding(.horizontal, 15)
            .padding(.leading, 30)
            
            HStack(spacing: -13) {
                Image(.locked)
                    .resizable()
                    .frame(width: 14, height: 16)
                    .padding(.leading, 30)
                
                if text.isEmpty && !isTextFocused {
                    Text(placeholder)
                        .Bak(size: 16, color: .secondLabel)
                        .padding(.leading, 30)
                        .onTapGesture {
                            isTextFocused = true
                        }
                }
            }
            .padding(.leading, 5)
        }
    }
}



struct ActivityViewController: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct PrecreatedTimer: View {
    var betanoTimerModel: BetanoTimerViewModel
    var model: TimerModel
    var time: String
    var dissmissAction: (() -> ())
    var body: some View {
        ZStack {
            Color(.mainBackground)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack(spacing: 20) {
                        Button(action: {
                            dissmissAction()
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
                    
                    Rectangle()
                        .fill(.secondMain)
                        .frame(height: 80)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .overlay {
                            HStack {
                                Image(BetanoImageName.basket.rawValue)
                                    .resizable()
                                    .frame(width: 48, height: 48)
                                
                                VStack(alignment: .leading) {
                                    Text(model.name)
                                        .Bak(size: 16)
                                        .lineLimit(1)
                                    
                                    Text(model.minute + " " + "minutes")
                                        .Bak(size: 14, color: .secondLabel)
                                        .lineLimit(1)
                                }
                                .padding(.horizontal, 8)
                                
                                Spacer()
                            }
                            .padding(.horizontal, 30)
                        }
                    
                    Spacer(minLength: 80)
                    
                    ZStack {
                        Circle()
                            .stroke(.secondMain, lineWidth: 5)
                            .frame(width: 261, height: 261)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(betanoTimerModel.progress))
                            .stroke(.mainOrange, lineWidth: 10)
                            .frame(width: 256, height: 256)
                            .rotationEffect(Angle(degrees: -90))
                            .animation(betanoTimerModel.animateProgress ? .linear : .none, value: betanoTimerModel.progress)
                    }
                    .overlay {
                        VStack {
                            Text(betanoTimerModel.timeString)
                                .Bak(size: 36)
                            
                            Text("/ \(String(format: "%02d:%02d", Int(time) ?? 0, 0))")
                                .Bak(size: 16, color: .secondLabel)
                        }
                    }
                    
                    Spacer(minLength: 40)
                    
                    Rectangle()
                        .fill(.secondMain)
                        .frame(height: 80)
                        .cornerRadius(16)
                        .padding(.horizontal)
                        .overlay {
                            HStack {
                                Spacer()
                                
                                VStack {
                                    Text("Total Time")
                                        .Bak(size: 14, color: .secondLabel)
                                    
                                    Text(betanoTimerModel.timeString)
                                        .Bak(size: 20)
                                }
                                
                                Spacer()
                                
                                VStack {
                                    Text("Points")
                                        .Bak(size: 14, color: .secondLabel)
                                    
                                    Text("\(betanoTimerModel.points)")
                                        .Bak(size: 20, color: .mainOrange)
                                }
                                
                                Spacer()
                                
                                VStack {
                                    Text("Calories")
                                        .Bak(size: 14, color: .secondLabel)
                                    
                                    Text("\(betanoTimerModel.calories)")
                                        .Bak(size: 20)
                                }
                                
                                Spacer()
                            }
                        }
                    
                    Spacer(minLength: 20)
                    
                    Button(action: {
                        if !betanoTimerModel.isTimerGoing {
                            betanoTimerModel.startTimer()
                        } else {
                            betanoTimerModel.pauseTimer()
                            betanoTimerModel.isTimerGoing = false
                        }
                    }) {
                        Rectangle()
                            .fill(.mainOrange)
                            .frame(height: 56)
                            .cornerRadius(16)
                            .padding(.horizontal)
                            .overlay {
                                HStack {
                                    Image(systemName: betanoTimerModel.isTimerGoing ? "stop.fill" : "play.fill")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundStyle(.white)
                                    
                                    Text(betanoTimerModel.isTimerGoing ? "Stop" : "Start Timer")
                                        .Bak(size: 15)
                                }
                            }
                    }
                    
                    Spacer(minLength: 15)
                    
                    if betanoTimerModel.isTimerGoing {
                        Button(action: {
                            betanoTimerModel.resetTimer(time: time)
                        }) {
                            Rectangle()
                                .fill(.secondMain)
                                .frame(height: 56)
                                .cornerRadius(16)
                                .padding(.horizontal)
                                .overlay {
                                    HStack {
                                        Image(systemName: "play.fill")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundStyle(.white)
                                        
                                        Text("Reset")
                                            .Bak(size: 15)
                                    }
                                }
                        }
                    }
                }
                .padding(.top)
            }
        }
        .onAppear {
            betanoTimerModel.configureTimer(time: time)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                betanoTimerModel.animateProgress = true
            }
        }
    }
}

struct UserTimer: View {
    var betanoUserTimerModel: BetanoUserTimerViewModel
    var time: String
    var model: TimerModel
    var dismissAction: (() -> ())
    var body: some View {
        ZStack {
            Color(.mainBackground)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack {
                    HStack(spacing: 20) {
                        Button(action: {
                            dismissAction()
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
                    
                    Spacer(minLength: 60)
                    
                    VStack {
                        Image(model.icon.rawValue)
                            .resizable()
                            .frame(width: 64, height: 64)
                        
                        Text(model.name)
                            .Bak(size: 24)
                    }
                    
                    Spacer(minLength: 70)
                    
                    ZStack {
                        Circle()
                            .stroke(.secondMain, lineWidth: 5)
                            .frame(width: 261, height: 261)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(betanoUserTimerModel.progress))
                            .stroke(.mainOrange, lineWidth: 10)
                            .frame(width: 256, height: 256)
                            .rotationEffect(Angle(degrees: -90))
                            .animation(betanoUserTimerModel.animateProgress ? .linear : .none, value: betanoUserTimerModel.progress)
                    }
                    .overlay {
                        VStack {
                            Text(betanoUserTimerModel.timeString)
                                .Bak(size: 36)
                            
                            Text("/ \(String(format: "%02d:%02d:%02d", Int(model.hour) ?? 0, Int(model.minute) ?? 0, 0))")
                                .Bak(size: 16, color: .secondLabel)
                        }
                    }
                    
                    Spacer(minLength: 80)
                    
                    Button(action: {
                        if !betanoUserTimerModel.isTimerGoing {
                            betanoUserTimerModel.startTimer()
                        } else {
                            betanoUserTimerModel.pauseTimer()
                            betanoUserTimerModel.isTimerGoing = false
                        }
                    }) {
                        Rectangle()
                            .fill(.mainOrange)
                            .frame(height: 56)
                            .cornerRadius(16)
                            .padding(.horizontal)
                            .overlay {
                                HStack {
                                    Image(systemName: betanoUserTimerModel.isTimerGoing ? "stop.fill" : "play.fill")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundStyle(.white)
                                    
                                    Text(betanoUserTimerModel.isTimerGoing ? "Stop" : "Start Timer")
                                        .Bak(size: 15)
                                }
                            }
                    }
                    
                    Spacer(minLength: 15)
                    
                    if betanoUserTimerModel.isTimerGoing {
                        Button(action: {
                            if let hours = Int(model.hour), let minutes = Int(model.minute) {
                                betanoUserTimerModel.resetTimer(hours: hours, minutes: minutes)
                            } else {
                                print("Invalid hour or minute format.")
                            }
                        }) {
                            Rectangle()
                                .fill(.secondMain)
                                .frame(height: 56)
                                .cornerRadius(16)
                                .padding(.horizontal)
                                .overlay {
                                    HStack {
                                        Image(systemName: "play.fill")
                                            .font(.system(size: 16, weight: .bold))
                                            .foregroundStyle(.white)
                                        
                                        Text("Reset")
                                            .Bak(size: 15)
                                    }
                                }
                        }
                    }
                }
                .padding(.top)
            }
        }
        .onAppear {
            if let hours = Int(model.hour), let minutes = Int(model.minute) {
                betanoUserTimerModel.configureTimer(hours: hours, minutes: minutes)
            } else {
                print("Invalid hour or minute format.")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                betanoUserTimerModel.animateProgress = true
            }
        }
    }
}
