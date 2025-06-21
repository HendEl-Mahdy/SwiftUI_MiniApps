//
//  ContentView.swift
//  WeSplit
//
//  Created by Hend El Mahdy on 21/06/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            Form {
                Section(header: Text("Sec1"), content: {
                    Text("Hello")
                    Text("Hello")
                    Text("Hello")
                })
                
                Section {
                    Text("Hello")
                    Text("Hello")
                }
            }
            // note they are inside NavigationStack
            .navigationTitle("SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
