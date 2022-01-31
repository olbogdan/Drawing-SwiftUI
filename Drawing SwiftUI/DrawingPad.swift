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
                    drawingPath.smoothLine()
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
    
    mutating func smoothLine() {
        var newPath = Path()
        newPath.interpolatePointsWithHermite(interpolationPoints: points)
        path = newPath
    }
}

struct DrawingPad_Previews: PreviewProvider {
    static var previews: some View {
        DrawingPad()
    }
}

extension Path {
    mutating func interpolatePointsWithHermite(interpolationPoints : [CGPoint], alpha : CGFloat = 1.0/3.0) {
        
        guard !interpolationPoints.isEmpty else { return }
        self.move(to: interpolationPoints[0])
        
        let n = interpolationPoints.count - 1
        
        for index in 0..<n {
            var currentPoint = interpolationPoints[index]
            var nextIndex = (index + 1) % interpolationPoints.count
            var prevIndex = index == 0 ? interpolationPoints.count - 1 : index - 1
            var previousPoint = interpolationPoints[prevIndex]
            var nextPoint = interpolationPoints[nextIndex]
            let endPoint = nextPoint
            var mx: CGFloat
            var my: CGFloat
            
            if index > 0 {
                mx = (nextPoint.x - previousPoint.x) / 2.0
                my = (nextPoint.y - previousPoint.y) / 2.0
            }
            else {
                mx = (nextPoint.x - currentPoint.x) / 2.0
                my = (nextPoint.y - currentPoint.y) / 2.0
            }
            
            let controlPoint1 = CGPoint(x: currentPoint.x + mx * alpha, y: currentPoint.y + my * alpha)
            currentPoint = interpolationPoints[nextIndex]
            nextIndex = (nextIndex + 1) % interpolationPoints.count
            prevIndex = index
            previousPoint = interpolationPoints[prevIndex]
            nextPoint = interpolationPoints[nextIndex]
            
            if index < n - 1 {
                mx = (nextPoint.x - previousPoint.x) / 2.0
                my = (nextPoint.y - previousPoint.y) / 2.0
            }
            else {
                mx = (currentPoint.x - previousPoint.x) / 2.0
                my = (currentPoint.y - previousPoint.y) / 2.0
            }
            
            let controlPoint2 = CGPoint(x: currentPoint.x - mx * alpha, y: currentPoint.y - my * alpha)
            self.addCurve(to: endPoint, control1: controlPoint1, control2: controlPoint2)
        }
    }
}
