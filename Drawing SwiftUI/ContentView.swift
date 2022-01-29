//
//  ContentView.swift
//  Drawing SwiftUI
//
//  Created by Oleksandr Bogdanov on 30.01.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.yellow
                .edgesIgnoringSafeArea(.all)
            Image("cat")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 250)
                .overlay(Circle()
                            .inset(by: 5)
                            .stroke(lineWidth: 10))
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
