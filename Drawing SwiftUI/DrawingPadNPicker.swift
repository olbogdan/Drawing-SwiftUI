//
//  DrawingPadNPicker.swift
//  Drawing SwiftUI
//
//  Created by Oleksandr Bogdanov on 31.01.22.
//

import SwiftUI

struct DrawingPadNPicker: View {
    @State var mainColor: PickedColor = PickedColor.black
    
    var body: some View {
        VStack {
            ColorPickerView(mainColor: $mainColor)
                .padding()
            Color.primary
                .frame(height: 1)
                .ignoresSafeArea()
            DrawingPadView(strokeColor: $mainColor)
        }
    }
}

struct DrawiingPadNPicker_Previews: PreviewProvider {
    static var previews: some View {
        DrawingPadNPicker()
    }
}
