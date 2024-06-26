//
//  TestView.swift
//  GuessTheFlag
//
//  Created by Rodrigo on 24-06-24.
//

import SwiftUI

struct TestView: View {
    @State private var showingAlert = false
    
    var body: some View {
        Button("Button 1") {}
            .buttonStyle(.bordered)
        
        Button("Button 2", role: .destructive) {}
            .buttonStyle(.bordered)
        
        Button("Button 3") {}
            .buttonStyle(.borderedProminent)
            .tint(.indigo)
        
        Button("Button 4", role: .destructive) {}
            .buttonStyle(.borderedProminent)
        
        Button {
            print("Button was tapped")
        } label: {
            Text("Tap Me")
                .padding()
                .foregroundStyle(.white)
                .background(.red)
        }
        
        Button {
            print("Button was tapped")
        } label: {
            Label("Edit", systemImage: "pencil")
                .padding()
                .foregroundStyle(.white)
                .background(.red)
        }
        
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important Message", isPresented: $showingAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {}
        } message: {
            Text("This is important info that you have to read")
        }
    }
}

#Preview {
    TestView()
}
