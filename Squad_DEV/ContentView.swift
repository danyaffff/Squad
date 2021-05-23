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
    @State var visibleStages = 0
    
    var body: some View {
        if visibleStages == 1 || Auth.auth().currentUser != nil {
            AccountView(stage: $visibleStages)
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
