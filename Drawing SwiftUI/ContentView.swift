//
//  ContentView.swift
//  Drawing SwiftUI
//
//  Created by Oleksandr Bogdanov on 30.01.22.
//

import SwiftUI

struct ContentView: View {
    var gradient: Gradient {
        let stops: [Gradient.Stop] = [
            .init(color: Color("pink"), location: 0.45),
            .init(color: .blue, location: 0.55)]
        return Gradient(stops: stops)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            Image("cat")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 250)
                .overlay(Circle()
                            .inset(by: 5)
                            .stroke(lineWidth: 10)
                            .foregroundColor(.green))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.landscapeLeft)
                .colorScheme(.dark)
            ContentView()
                .previewInterfaceOrientation(.landscapeLeft)
                .colorScheme(.light)
        }
    }
}
