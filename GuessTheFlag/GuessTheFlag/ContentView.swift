//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Hend El Mahdy on 21/06/2025.
//

import SwiftUI

///All of these gradient types can have stops provided
struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        //        LinearGradient(colors: [.white, .black], startPoint: .top, endPoint: .bottom)
        //            .ignoresSafeArea()
        
        //        LinearGradient(stops: [
        //            .init(color: .white, location: 0.45),
        //            .init(color: .black, location: 0.55),
        //        ], startPoint: .top, endPoint: .bottom)
        //        .ignoresSafeArea()
        
        //        RadialGradient(colors: [.blue, .black], center: .center, startRadius: 20, endRadius: 200)
        //            .ignoresSafeArea()
        
        //        AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
        //            .ignoresSafeArea()
        
        //        Text("Your content")
        //            .frame(maxWidth: .infinity, maxHeight: .infinity)
        //            .foregroundStyle(.white)
        //            .background(.red.gradient) //.gradient after any color – SwiftUI will automatically convert your color into a very gentle linear gradient
        
        VStack {
            Button("Button 1") { }
                .buttonStyle(.bordered)
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)
            Button {
                print("Button was tapped")
            } label: {
                Text("Tap me!")
                    .padding()
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 25.0, style: .circular)
                            .tint(.indigo)
                    )
                
            }.padding()
            
            Button {
                print("Edit button was tapped")
            } label: {
                Image(systemName: "pencil")
            }.padding()
            
            Button("Edit", systemImage: "pencil") {
                print("Edit button was tapped")
            }.padding()
            
            Button("Show Alert") {
                showingAlert = true
            }
            .alert("Important message", isPresented: $showingAlert) {
                Button("Delete", role: .destructive) { }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Please read this.")
            }
        }
    }
    
    func executeDelete() {
        print("Now deleting…")
    }
}

#Preview {
    ContentView()
}
