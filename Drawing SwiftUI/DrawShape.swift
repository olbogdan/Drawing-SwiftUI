//
//  DrawShape.swift
//  Drawing SwiftUI
//
//  Created by Oleksandr Bogdanov on 30.01.22.
//

import SwiftUI

struct DrawShape: View {
    var body: some View {
        let strokeStyle = StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)
        HStack {
            Chevron()
            .stroke(style: strokeStyle)
            Heart()
                .stroke(style: strokeStyle)
            Diamond()
                .stroke(style: strokeStyle)
        }
    }
}

struct Heart: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.width*0.25, y: rect.height*0.25), radius: rect.width*0.25, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: true)
        
        let control1 = CGPoint(x: 0, y: rect.height*0.8)
        let control2 = CGPoint(x: rect.width*0.25, y: rect.height*0.95)
        path.addCurve(to: CGPoint(x: rect.width * 0.5, y: rect.height), control1: control1, control2: control2)
        
        var transform = CGAffineTransform(translationX: rect.width, y: 0)
        transform = transform.scaledBy(x: -1, y: 1)
        path.addPath(path, transform: transform)
        return path
    }
    
    
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let width = rect.width
            let height = rect.height
            path.addLines([
                CGPoint(x: width / 2, y: 0),
                CGPoint(x: width, y: height / 2),
                CGPoint(x: width / 2, y: height),
                CGPoint(x: 0, y: height / 2)
            ])
            path.closeSubpath()
        }
    }
}

struct Chevron: Shape {
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            path.addLines([
                .zero,
                CGPoint(x: rect.width*0.8, y: 0),
                CGPoint(x: rect.width, y: rect.height/2),
                CGPoint(x: rect.width*0.8, y: rect.height),
                CGPoint(x: 0, y: rect.height),
                CGPoint(x: rect.width*0.2, y: rect.height/2)
            ])
            path.closeSubpath()
        }
    }
    
    
}

struct DrawShape_Previews: PreviewProvider {
    static var previews: some View {
        DrawShape()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
