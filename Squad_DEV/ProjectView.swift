//
//  ProjectView.swift
//  Squad_DEV
//
//  Created by Даниил Храповицкий on 23.05.2021.
//

import SwiftUI

struct ProjectView: View {
    @State var selectedTab = 0
    
    @Binding var stages: Int
    
    @Binding var name: String
    @Binding var description: String
    @Binding var rating: Double
    
    @State var shouldShowPop = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Проект:")
                    .font(.system(size: 20, weight: .light))
                
                Text(name)
                    .foregroundColor(.ourBlue)
                    .font(.system(size: 20, weight: .light))
            }
            
            HStack {
                Button(action: {
                    selectedTab = 0
                }, label: {
                    Image("menu")
                        .renderingMode(.template)
                        .foregroundColor(selectedTab == 0 ? .ourBlue : .black)
                })
                .buttonStyle(PlainButtonStyle())
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                }
                
                Button(action: {
                    selectedTab = 1
                }, label: {
                    Image("database")
                        .renderingMode(.template)
                        .foregroundColor(selectedTab == 1 ? .ourBlue : .black)
                })
                .buttonStyle(PlainButtonStyle())
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                }
                
                Button(action: {
                    selectedTab = 2
                }, label: {
                    Image("video")
                        .renderingMode(.template)
                        .foregroundColor(selectedTab == 2 ? .ourBlue : .black)
                })
                .buttonStyle(PlainButtonStyle())
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                }
                
                Button(action: {
                    selectedTab = 3
                }, label: {
                    Image("trello")
                        .renderingMode(.template)
                        .foregroundColor(selectedTab == 3 ? .ourBlue : .black)
                })
                .buttonStyle(PlainButtonStyle())
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                }
                
                Button(action: {
                    selectedTab = 4
                }, label: {
                    Image("github")
                        .renderingMode(.template)
                        .foregroundColor(selectedTab == 4 ? .ourBlue : .black)
                })
                .buttonStyle(PlainButtonStyle())
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                }
            }
            .padding(.bottom, 40)
            
            Title(text: "Описание")
                .padding(.bottom, 4)
            
            Text(description)
                .multilineTextAlignment(.center)
                .font(.system(size: 17, weight: .light))
                .foregroundColor(.gray)
                .frame(width: 470)
            
            HStack(spacing: 2) {
                Button {
                    print("Вы поставили лайк")
                } label: {
                    ZStack {
                        Capsule()
                            .foregroundColor(.ourBlue)
                        
                        Text("Like")
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .frame(width: 100, height: 40)
                .padding(.trailing, 8)
                .onHover { hovering in
                    hovering ? NSCursor.pointingHand.push() : NSCursor.pop()
                }
                
                Image("star")
                Text(String(format: "%.1f", rating))
            }
            .padding(.bottom, 20)
            
            Title(text: "Команда")
            
            HStack {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            
            Spacer()
        }
        .padding(.top, 70)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

//struct ProjectView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectView(stages: .constant(9))
//    }
//}
