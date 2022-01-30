//
//  ColorSliderView.swift
//  Drawing SwiftUI
//
//  Created by Oleksandr Bogdanov on 30.01.22.
//

import SwiftUI

struct TestSliderView: View {
    @State private var sliderValue: Double = 0
    
    var body: some View {
        ColorSliderView(sliderValue: $sliderValue,
                        range: 0...100,
                        color: .pink)
    }
}

struct ColorSliderView: View {
    @Binding var sliderValue: Double
    var range: ClosedRange<Double> = 0...1
    var color: Color = .red
    
    var body: some View {
        let gradient = LinearGradient(gradient: Gradient(colors: [.black, color, .white]), startPoint: .leading, endPoint: .trailing)
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                gradient
                    .cornerRadius(20)
                    .frame(height: 20)
                CircleView(
                    value: self.$sliderValue,
                    range: self.range,
                    sliderWidth: geometry.size.width)
            }
        }
        .padding()
    }
}

struct CircleView: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    @State private var offset: CGSize = .zero
    
    let diameter: CGFloat = 30
    let sliderWidth: CGFloat
    
    var sliderValue: Double {
        let percent = Double(offset.width / (sliderWidth - diameter))
        let value = (range.upperBound - range.lowerBound) * percent + range.lowerBound
        return value
    }
    var body: some View {
        let drag = DragGesture()
            .onChanged {
                self.offset.width = clampWidth(translation: $0.translation.width)
                self.value = sliderValue
            }
        Circle()
            .foregroundColor(.white)
            .shadow(color: .gray, radius: 2)
            .frame(width: diameter, height: diameter)
            .gesture(drag)
            .offset(offset)
    }
    
    func clampWidth(translation: CGFloat) -> CGFloat {
        return min(sliderWidth - diameter, max(0, offset.width + translation))
    }
}

struct ColorSliderView_Previews: PreviewProvider {
    @State static var sliderValue: Double = 20
    
    static var previews: some View {
        ColorSliderView(sliderValue: $sliderValue,
                        range: 0...50,
                        color: .pink)
    }
}

