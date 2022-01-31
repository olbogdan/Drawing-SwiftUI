//
//  DrawingPad.swift
//  Drawing SwiftUI
//
//  Created by Oleksandr Bogdanov on 31.01.22.
//

import SwiftUI

struct DrawingPad: View {
    @State private var strokeColor: Color = .black
    @State private var drawingPath = DrawingPath()
    @State private var path: [DrawingPath] = []
    
    var body: some View {
        let drag = DragGesture(minimumDistance: 0)
            .onChanged { stroke in
                drawingPath.addLine(to: stroke.location, color: strokeColor)
            }
            .onEnded { stroke in
                if !drawingPath.path.isEmpty {
                    path.append(drawingPath)
                }
                drawingPath = DrawingPath()
            }
        return ZStack {
            Color("Yellow")
                .ignoresSafeArea()
                .gesture(drag)
            ForEach(path) { drawingPath in
                drawingPath.path
                    .stroke(lineWidth: 14)
                    .foregroundColor(drawingPath.color)
            }
            drawingPath.path
                .stroke(lineWidth: 14)
                .foregroundColor(drawingPath.color)
        }
        
    }
}

struct DrawingPath: Identifiable {
    var id: UUID = UUID()
    var path: Path = Path()
    var points: [CGPoint] = []
    var color: Color = .black
    
    mutating func addLine(to point: CGPoint, color: Color) {
        if points.isEmpty {
            path.move(to: point)
            self.color = color
        } else {
            path.addLine(to: point)
        }
        points.append(point)
    }
}

struct DrawingPad_Previews: PreviewProvider {
    static var previews: some View {
        DrawingPad()
    }
}

