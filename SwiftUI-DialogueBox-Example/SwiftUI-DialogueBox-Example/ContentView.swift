//
//  ContentView.swift
//  SUI_Option_Dialogue_Example
//
//  Created by Dominik Butz on 31/10/2022.
//

import SwiftUI
import SwiftUI_DialogueBox

struct ContentView: View {
    
    @State var selectedTab: Int = 0
    

    
    var body: some View {
        GeometryReader { proxy in
            NavigationView {
                VStack(alignment: .leading, spacing: 10) {
                    NavigationLink {
                        SimpleDialogueExample()
                    } label: {
                        Text("Simple Dialogue")
                    }.padding()
                    
                    NavigationLink {
                        CheckmarkExample()
                    } label: {
                        Text("Checkmark Example")
                    }.padding()
                    Spacer()
                }
                
                SimpleDialogueExample()
                
            }
        }.accentColor(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
