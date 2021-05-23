//
//  ContentView.swift
//  Squad_DEV
//
//  Created by Даниил Храповицкий on 22.05.2021.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @State var visibleStages = 9
    @State var name = "Desktop Chess"
    @State var description = "Данный проект нацелен на начинающих учеников.\nВыполняется на языке Python с использованием библиотеки PyGame.\nОсновная цель: доработать логику."
    @State var rating = 4.9
    
    var body: some View {
        if visibleStages == 1 {
            AccountView(stage: $visibleStages, title: $name, description: $description, rating: $rating)
                .ignoresSafeArea(edges: .all)
        } else if visibleStages == 9 {
            ProjectView(stages: $visibleStages, name: $name, description: $description, rating: $rating)
                .ignoresSafeArea(edges: .all)
        } else {
            HomeView(visibleStage: $visibleStages)
                .ignoresSafeArea(edges: .all)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
