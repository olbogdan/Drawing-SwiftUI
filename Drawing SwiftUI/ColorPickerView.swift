//
//  ColorPickerView.swift
//  Drawing SwiftUI
//
//  Created by Oleksandr Bogdanov on 31.01.22.
//

import SwiftUI

struct ColorPickerView: View {
    @State fileprivate var mainColor: PickedColor = PickedColor.black
    
    var body: some View {
        VStack {
            Circle()
                .foregroundColor(mainColor.color)
                .frame(width: 300)
            HStack(alignment: .center) {
                ForEach(PickedColor.allCases, id: \.self) { pickedColor in
                    CirclePicker(mainColor: $mainColor, pickedColor: pickedColor)
                }
            }
        }
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView()
    }
}

private struct CirclePicker : View {
    @Binding var mainColor: PickedColor
    var pickedColor: PickedColor
    let diameter: CGFloat = 40
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(pickedColor.color)
                .frame(width: diameter, height: diameter)
                .onTapGesture {
                    mainColor = pickedColor
                }
            if pickedColor == mainColor {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.white)
            }
        }
    }
}

private enum PickedColor: CaseIterable {
    case black, blue, green, orange, red, yellow
    
    var color: Color {
        return Color(uiColor)
    }
    
    var uiColor: UIColor {
        switch self {
        case .black:
            return UIColor(named: "Black")!
        case .blue:
            return UIColor(named: "Blue")!
        case .green:
            return UIColor(named: "Green")!
        case .orange:
            return UIColor(named: "Orange")!
        case .red:
            return UIColor(named: "Red")!
        case .yellow:
            return UIColor(named: "Yellow")!
        }
    }
}
