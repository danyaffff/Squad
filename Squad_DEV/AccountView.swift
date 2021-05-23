//
//  AccountView.swift
//  Squad_DEV
//
//  Created by Даниил Храповицкий on 23.05.2021.
//

import SwiftUI
import FirebaseAuth

struct AccountView: View {
    @Binding var stage: Int
    @State var shouldShowPopover = false
    
    @State var name = ""
    @State var area = ""
    @State var level = ""
    
    @Binding var title: String
    @Binding var description: String
    @Binding var rating: Double
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)
                            .foregroundColor(.ourBlue)
                            .onTapGesture {
                                try! Auth.auth().signOut()
                                withAnimation {
                                    stage = 0
                                }
                                
                                print(Auth.auth().currentUser)
                            }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("\(name):")
                                    .foregroundColor(.black)
                                    .font(.system(size: 20, weight: .light))
                                Text("\(area)")
                                    .foregroundColor(.ourBlue)
                                    .font(.system(size: 20, weight: .light))
                                
                                Button(action: {
                                    print("Settings")
                                }, label: {
                                    Image(systemName: "gearshape")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.ourBlue)
                                })
                                .buttonStyle(PlainButtonStyle())
                                .onHover { hovering in
                                    hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                                }
                            }
                            
                            HStack(spacing: 20) {
                                HStack(spacing: 4) {
                                    Text("Уровень:")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 12, weight: .light))
                                    
                                    Text(level)
                                        .foregroundColor(.black)
                                        .font(.system(size: 12, weight: .light))
                                }
                                
                                HStack(spacing: 4) {
                                    Text("Рейтинг:")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 12, weight: .light))
                                    
                                    Text("-")
                                        .foregroundColor(.black)
                                        .font(.system(size: 12, weight: .light))
                                }
                                
                                HStack(spacing: 4) {
                                    Text("Подписка:")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 12, weight: .light))
                                    
                                    Text("Стандарт")
                                        .foregroundColor(.black)
                                        .font(.system(size: 12, weight: .light))
                                    
                                    
                                    Button(action: {
                                        shouldShowPopover = true
                                    }, label: {
                                        Image(systemName: "questionmark.circle")
                                            .resizable()
                                            .frame(width: 12, height: 12)
                                            .foregroundColor(.black)
                                    })
                                    .onHover { hovering in
                                        hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .popover(isPresented: $shouldShowPopover) {
                                        Text("Описание стандартной подписки")
                                            .padding()
                                            .padding(.vertical, 20)
                                    }
                                }
                            }
                        }
                    }
                    .padding(20)
                    .padding(.top)
                    
                    Spacer()
                    
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.ourBlue)
                            .cornerRadius(20)
                            .frame(width: 250, height: 100)
                        
                        HStack {
                            Image("icon")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.white)
                                .frame(width: 50, height: 50)
                            
                            Text("Squad_{DEV}")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .light))
                        }
                        .padding(.top, 33)
                        .padding(.trailing, 45)
                    }
                    .padding([.top, .trailing], -20)
                }
                
                
                HStack(alignment: .top, spacing: 0) {
                    VStack(alignment: .leading) {
                        Title(text: "Мои проекты")
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Project(stage: $stage, id: 0, name: "Desktop Chess", description: "Данный проект нацелен на начинающих учеников.\nВыполняется на языке Python с использованием библиотеки PyGame.\nОсновная цель: доработать логику.", complexity: "Легко", rating: 4.9, title: $title, desc: $description, rat: $rating)
                                
                                Button(action: {
                                    print("Поиск других уроков")
                                }, label: {
                                    Image(systemName: "plus.circle")
                                        .resizable()
                                        .foregroundColor(.ourBlue)
                                        .frame(width: 30, height: 30)
                                })
                                .buttonStyle(PlainButtonStyle())
                                .padding(.bottom, 40)
                                .onHover { hovering in
                                    hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                                }
                            }
                        }
                        
                        Title(text: "Активность")
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.ourBlue, lineWidth: 1)
                            .foregroundColor(.clear)
                            .frame(height: 120)
                    }
                    .frame(width: geometry.size.width / 2 - 140)
                    .padding(.leading, 40)
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Title(text: "Достижения")
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Acievement(image: "terminal", step: 1, description: "Описание терминал")
                                Acievement(image: "trello", step: 2, description: "Описание трелло")
                                Acievement(image: "git", step: 3, description: "Описание гит")
                            }
                        }
                        
                        Title(text: "Сертификаты")
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                Certificate(image: "terminal", name: "Terminal", rating: 1, date: Date())
                                Certificate(image: "trello", name: "Trello", rating: 1.5, date: Date())
                                Certificate(image: "git", name: "Git", rating: 2, date: Date())
                            }
                        }
                    }
                    .frame(width: geometry.size.width / 2 - 80)
                    .padding(.trailing, 40)
                    
                }
//                .padding(.top, 30)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
        .onAppear {
            Network.fetchUser { json in
                name = json["name"].stringValue
                area = json["area"].stringValue
                
                let level = json["level"].intValue
                
                switch level {
                case 0: self.level = "Начинающий"
                case 1: self.level = "Продолжающий"
                case 2: self.level = "Подготовленный"
                case 3: self.level = "Разбирающийся"
                default: break
                }
            }
        }
    }
}

struct Project: View {
    @Binding var stage: Int
    
    var id: Int
    var name: String
    var description: String
    var complexity: String
    var rating: Double
    
    @State var hovering = false
    
    @Binding var title: String
    @Binding var desc: String
    @Binding var rat: Double
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.ourBlue, lineWidth: 1)
                .foregroundColor(.clear)
            
            
            VStack(alignment: .leading) {
                HStack {
                    Image("server")
                    
                    Text(name)
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .light))
                }
                
                Spacer()
                
                Text(description[description.startIndex..<description.firstIndex(of: "\n")!])
                    .foregroundColor(.gray)
                    .font(.system(size: 14, weight: .light))
                
                Spacer()
                
                HStack {
                    Image("tag")
                    
                    Text(complexity)
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .light))
                    
                    Spacer()
                    
                    Image("star")
                    
                    Text(String(format: "%.1f", rating))
                        .foregroundColor(.black)
                        .font(.system(size: 14, weight: .light))
                }
            }
            .padding(12)
        }
        .scaleEffect(hovering ? 1.03 : 1)
        .frame(width: 240, height: 150)
        .padding(.bottom, 40)
        .padding(4)
        .onHover { hovering in
            withAnimation {
                self.hovering = hovering
            }
        }
        .onTapGesture {
            title = name
            desc = description
            rat = rating
            
            withAnimation {
                stage = 9
            }
        }
    }
}

struct Acievement: View {
    @State var hovering = false
    @State var achievementDescription = ""
    
    var image: String
    var step: Int
    var description: String
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(.ourBlue)
                    .frame(width: 80, height: 80)
                
                Image(image)
            }
            
            HStack {
                ForEach(0..<step) { _ in
                    Image("star")
                }
            }
        }
        .padding(.bottom, 40)
        .onHover{ hovering in
            self.hovering = hovering
        }
        .popover(isPresented: $hovering) {
            Text(description)
                .padding(.all)
                .padding(.vertical, 20)
        }
    }
}

struct Title: View {
    var text: String
    
    var body: some View {
        HStack(spacing: 0) {
            Text("</")
                .foregroundColor(.ourBlue)
                .font(.system(size: 20, weight: .light))
            Text(text)
                .font(.system(size: 20, weight: .light))
                .foregroundColor(.black)
            Text(">")
                .foregroundColor(.ourBlue)
                .font(.system(size: 20, weight: .light))
        }
    }
}

struct Certificate: View {
    var image: String
    var name: String
    var rating: Double
    var date: Date
    
    @State var hovering = false
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.ourBlue, lineWidth: 1)
                    .foregroundColor(.clear)
                
                VStack {
                    Spacer()
                    
                    HStack(spacing: 3) {
                        Image(image)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.ourBlue)
                            .frame(width: 18, height: 18)
                        
                        Text(name)
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .light))
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Image("star")
                        
                        Text(String(format: "%.1f", rating))
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .light))
                    }
                    .padding(12)
                }
            }
            .frame(width: 180, height: 113)
            .padding(.bottom, 8)
            
            Text("Получен " + DateFormatter.formatter.string(from: date))
                .foregroundColor(.gray)
                .font(.system(size: 12, weight: .light))
        }
        .padding(4)
        .scaleEffect(hovering ? 1.02 : 1)
        .onHover { hovering in
            withAnimation {
                self.hovering = hovering
            }
        }
    }
}

//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView(stage: .constant(1))
//    }
//}

extension DateFormatter {
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy г."
        return formatter
    }()
}
