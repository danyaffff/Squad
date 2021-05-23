//
//  HomeView.swift
//  Squad_DEV
//
//  Created by Даниил Храповицкий on 22.05.2021.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State var email = ""
    @State var password = ""
    @State var name = ""
    @State var area = ""
    @State var rightAnswers = 0
    
    @Binding var visibleStage: Int
    
    var body: some View {
        VStack {
            Image("icon")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.top, 100)
            
            Text("Squad_{DEV}")
                .foregroundColor(.ourBlue)
                .font(.system(size: 24, weight: .light))
                .padding(.bottom, 10)
            
            if visibleStage == 0 {
                LoginView(stage: $visibleStage)
            } else if visibleStage == 2 {
                RegistrationView(email: $email, password: $password, name: $name, area: $area, stage: $visibleStage)
            } else if visibleStage == 3 {
                PreparingToTestView(stage: $visibleStage)
            } else if visibleStage == 4 {
                TestView(stage: $visibleStage, rightAnswers: $rightAnswers, question: "Что такое ООП?", answer1: "Парадигма программирования, в которой основными концепциями являются понятия объектов и классов", answer2: "Парадигма программирования, в которой основными концепциями являются понятия операторов и полей", answer3: "Паттерн проектирования, в котором основными концепциями являются понятия объектов и классов", answer4: "Антипаттерн проектирования, в котором основными концепциями являются понятия операторов и полей", rightAnswer: 0)
            } else if visibleStage == 5 {
                TestView(stage: $visibleStage, rightAnswers: $rightAnswers, question: "Какова асимптотическая сложность сортировки слиянием (Merge sort)?", answer1: "O(n^2)", answer2: "O(n * log(n))", answer3: "O(n)", answer4: "O(log(n))", rightAnswer: 1)
            } else if visibleStage == 6 {
                TestView(stage: $visibleStage, rightAnswers: $rightAnswers, question: "Cock можно перенаправить консольный вывод в файл без перезаписи?", answer1: "Оператором >", answer2: "Оператором <", answer3: "Оператором <<", answer4: "Оператором >>", rightAnswer: 3)
            } else if visibleStage == 7 {
                EndTestView(email: $email, password: $password, name: $name, area: $area, rightAnswers: $rightAnswers, stage: $visibleStage)
            } else if visibleStage == -1 {
                AboutUsView(stage: $visibleStage)
            }
            
            Spacer()
            
            Text("© Pelmeni, 2021")
                .foregroundColor(Color(red: 0.46, green: 0.46, blue: 0.46))
                .fontWeight(.light)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var shouldShowAlert = false
    @State var error = ""
    
    @Binding var stage: Int
    
    var body: some View {
        VStack {
            HStack(spacing: 3) {
                Text("Грядущая революция в IT образовании")
                    .font(.system(size: 20, weight: .light))
                    .foregroundColor(.black)
                
                Button(action: {
                    withAnimation {
                        stage = -1
                    }
                }, label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 19))
                        .foregroundColor(Color.ourBlue)
                })
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.bottom, 50)
            
            RoundedTextField(placeholder: "Email", isSecure: false, text: $email)
            
            RoundedTextField(placeholder: "Пароль", isSecure: true, text: $password)
                .padding(.bottom, 10)
            
            RoundedButtonView(title: "Войти", buttonColor: email.isValidEmail && password.isValidPassword ? .ourBlue : .gray, disabled: !email.isValidEmail || !password.isValidPassword) {
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    if let error = error {
                        self.error = error.localizedDescription
                        shouldShowAlert = true
                    } else {
                        withAnimation {
                            stage = 1
                        }
                    }
                }
            }
            
            HStack {
                Text("Ещё нет аккаунта?")
                    .padding(.trailing, 2)
                    .foregroundColor(.black)
                
                Button(action: {
                    withAnimation {
                        stage = 2
                    }
                }, label: {
                    Text("Присоединиться к нам")
                        .foregroundColor(.ourBlue)
                })
                .buttonStyle(PlainButtonStyle())
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                }
            }
        }.alert(isPresented: $shouldShowAlert) {
            Alert(title: Text("Ошибка входа").foregroundColor(.black), message: Text(error).foregroundColor(.black), dismissButton: .cancel())
        }
    }
}

struct RegistrationView: View {
    @State var repeatedPassword = ""
    
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    @Binding var area: String
    @Binding var stage: Int

    var body: some View {
        VStack {
            Text("Регистрация")
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .light))
                .padding(.bottom, 50)

            RoundedTextField(placeholder: "Ваше имя", isSecure: false, text: $name)
            RoundedTextField(placeholder: "Желаемая IT область", isSecure: false, text: $area)
            RoundedTextField(placeholder: "Введите Email", isSecure: false, text: $email)
            RoundedTextField(placeholder: "Придумайте пароль", isSecure: true, text: $password)
            RoundedTextField(placeholder: "Повторите пароль", isSecure: true, text: $repeatedPassword)
                .padding(.bottom, 10)

            RoundedButtonView(title: "Зарегестрироваться", buttonColor: (name.count > 0 && area.count > 5 && email.isValidEmail && password.isValidPassword && repeatedPassword == password) ? .ourBlue : .gray, disabled: !(name.count > 0 && area.count > 5 && email.count > 3 && password.isValidPassword && repeatedPassword == password)) {
                withAnimation {
                    stage = 3
                }
            }
            .onHover { hovering in
                hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
            }

            HStack {
                Text("Уже есть аккаунт?")
                    .padding(.trailing, 2)

                Button(action: {
                    withAnimation {
                        stage = 0
                    }
                }, label: {
                    Text("Войти")
                        .foregroundColor(.ourBlue)
                })
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct RoundedTextField: View {
    var placeholder: String
    var isSecure: Bool
    
    @Binding var text: String
    
    var body: some View {
        ZStack {
            Capsule()
                .stroke(Color.black, lineWidth: 1.0)
            
            if !isSecure {
                TextField(placeholder, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(width: NSScreen.main!.visibleFrame.width / 6)
            } else {
                SecureField(placeholder, text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .frame(width: NSScreen.main!.visibleFrame.width / 6)
            }
        }
        .frame(width: NSScreen.main!.visibleFrame.width / 6 + 20, height: 30)
    }
}

struct RoundedButtonView: View {
    var title: String
    var buttonColor: Color
    var disabled: Bool
    
    var action: (() -> Void)
    
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .foregroundColor(.white)
                .frame(width: NSScreen.main!.visibleFrame.width / 6 + 22, height: 32)
        })
        .onHover { hovering in
            hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
        }
        .buttonStyle(PlainButtonStyle())
        .background(buttonColor)
        .cornerRadius(15)
        .disabled(disabled)
        .padding(.bottom, 10)
    }
}

struct PreparingToTestView: View {
    @Binding var stage: Int
    
    var body: some View {
        VStack {
            Text("Отлично!")
                .font(.system(size: 20, weight: .light))
            Text("Теперь осталось пройти небольшой тест, чтобы определить Ваш примерный уровень знаний.")
                .font(.system(size: 20, weight: .light))
                .frame(width: 500)
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)
            
            RoundedButtonView(title: "Пройти тест", buttonColor: .ourBlue, disabled: false) {
                withAnimation {
                    stage = 4
                }
            }
            .onHover { hovering in
                hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
            }
            
            Button(action: {
                withAnimation {
                    stage = 0
                }
            }, label: {
                Text("На главный экран")
                    .foregroundColor(.ourBlue)
            })
            .onHover { hovering in
                hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct TestView: View {
    @Binding var stage: Int
    @Binding var rightAnswers: Int
    
    var question: String
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
    var rightAnswer: Int
    
    @State var selectedAnswer: Int?
    
    var body: some View {
        VStack {
            Text("Тест")
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .light))
            
            ZStack {
                Text(question)
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .light))
                    .padding(.top, -135)
                
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.ourBlue, lineWidth: 1)
                    .frame(width: 700, height: 300, alignment: .center)
                
                VStack(spacing: 30) {
                    HStack {
                        Checkbox(selectedAnswer: $selectedAnswer, value: 0)
                        Text(answer1)
                            .foregroundColor(.black)
                    }
                    .onHover { hovering in
                        hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                    }
                    .frame(width: 600, alignment: .leading)
                    .onTapGesture {
                        if selectedAnswer == 0 {
                            selectedAnswer = nil
                        } else {
                            selectedAnswer = 0
                        }
                    }
                    
                    HStack {
                        Checkbox(selectedAnswer: $selectedAnswer, value: 1)
                        Text(answer2)
                            .foregroundColor(.black)
                    }
                    .onHover { hovering in
                        hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                    }
                    .frame(width: 600, alignment: .leading)
                    .onTapGesture {
                        if selectedAnswer == 1 {
                            selectedAnswer = nil
                        } else {
                            selectedAnswer = 1
                        }
                    }
                    
                    HStack {
                        Checkbox(selectedAnswer: $selectedAnswer, value: 2)
                        Text(answer3)
                            .foregroundColor(.black)
                    }
                    .onHover { hovering in
                        hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                    }
                    .frame(width: 600, alignment: .leading)
                    .onTapGesture {
                        if selectedAnswer == 2 {
                            selectedAnswer = nil
                        } else {
                            selectedAnswer = 2
                        }
                    }
                    
                    HStack {
                        Checkbox(selectedAnswer: $selectedAnswer, value: 3)
                        Text(answer4)
                            .foregroundColor(.black)
                    }
                    .onHover { hovering in
                        hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                    }
                    .frame(width: 600, alignment: .leading)
                    .onTapGesture {
                        if selectedAnswer == 3 {
                            selectedAnswer = nil
                        } else {
                            selectedAnswer = 3
                        }
                    }
                }
                .padding(.bottom, -30)
            }
            
            RoundedButtonView(title: "К следующему вопросу", buttonColor: selectedAnswer == nil ? .gray : .ourBlue, disabled: selectedAnswer == nil) {
                if selectedAnswer == rightAnswer {
                    rightAnswers += 1
                }
                
                withAnimation {
                    stage += 1
                }
            }
            .onHover { hovering in
                hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
            }
            .padding(.top, 10)
        }
    }
}

struct EndTestView: View {
    @State var error = ""
    @State var shouldShowAlert = false
    
    @Binding var email: String
    @Binding var password: String
    @Binding var name: String
    @Binding var area: String
    @Binding var rightAnswers: Int
    @Binding var stage: Int
    
    var body: some View {
        VStack {
            Text("Тест")
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .light))
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.ourBlue, lineWidth: 1)
                    .frame(width: 700, height: 300, alignment: .center)
                
                VStack(spacing: 20) {
                    Text("Регистрация завершена")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .light))
                    
                    RoundedButtonView(title: "Личный кабинет", buttonColor: .ourBlue, disabled: false) {
                        Auth.auth().createUser(withEmail: email, password: password) { result, error in
                            if let error = error {
                                self.error = error.localizedDescription
                                shouldShowAlert = true
                            } else {
                                Network.safe([
                                    "name": name,
                                    "area": area,
                                    "email": email,
                                    "level": rightAnswers
                                ])
                            }
                        }
                        
                        withAnimation {
                            stage = 1
                        }
                    }
                    .onHover { hovering in
                        hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                    }
                }
            }
        }
        .alert(isPresented: $shouldShowAlert) {
            Alert(title: Text("Ошибка регистрации").foregroundColor(.black), message: Text(error).foregroundColor(.black), dismissButton: .cancel())
        }
    }
}

struct Checkbox: View {
    @Binding var selectedAnswer: Int?
    var value: Int
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 15, height: 15)
                .foregroundColor(Color.red.opacity(0.001))
                .onTapGesture {
                    selectedAnswer = value
                }
            
            Circle()
                .stroke(Color.gray, lineWidth: 1)
                .frame(width: 15, height: 15)
                
            
            if selectedAnswer == value {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct AboutUsView: View {
    @Binding var stage: Int
    
    var body: some View {
        VStack {
            Text("PELMENUS")
            
            Button(action: {
                withAnimation {
                    stage = 0
                }
            }, label: {
                Text("На главный экран")
                    .foregroundColor(.ourBlue)
            })
            .buttonStyle(PlainButtonStyle())
            .onHover { hovering in
                hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
            }
        }
    }
}

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(visibleStage: 0)
//    }
//}
