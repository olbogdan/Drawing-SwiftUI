//
//  FlyoutMenuView.swift
//  Drawing SwiftUI
//
//  Created by Oleksandr Bogdanov on 31.01.22.
//

import SwiftUI

struct FlyoutMenuView: View {
    let iconDiameter: CGFloat = 50
    let menuDiameter: CGFloat = 160
    var radius: CGFloat {
        return menuDiameter / 2
    }
    var flyoutMenuOptions: [FlyoutMenuOption] = [
        FlyoutMenuOption(image: Image(systemName: "lasso.and.sparkles"), color: .orange),
        FlyoutMenuOption(image: Image(systemName: "opticaldisc"), color: .pink),
        FlyoutMenuOption(image: Image(systemName: "lock.open.display"), color: .cyan)
    ]
    @State var isOpen = false
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.yellow)
                .opacity(0.1)
                .frame(width: isOpen ? menuDiameter + iconDiameter : 0)
            ForEach(flyoutMenuOptions.indices) { index in
                drawOption(index: index)
            }
            FlyoutMenu(isOpen: $isOpen)
        }
    }
    
    func drawOption(index: Int) -> some View {
        let angle = .pi / 4 * CGFloat(index) - .pi
        let offset = CGSize(width: cos(angle) * radius, height: sin(angle) * radius)
        let option = flyoutMenuOptions[index]
        return Button {
            option.action()
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(option.color)
                option.image
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .offset(offset)
        .frame(width: iconDiameter)
    }
}

private struct FlyoutMenu: View {
    @Binding var isOpen: Bool
    @State var angle: Angle = Angle.degrees(0)
    var body: some View {
        Button {
            withAnimation {
                isOpen.toggle()
                endTextEditing()
            }
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(.green)
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                    .rotationEffect(isOpen ? Angle.degrees(45) : Angle.degrees(0))
            }
        }
        .frame(width: 50, height: 50)
        
    }
}

struct FlyoutMenuOption {
    var image: Image
    var color: Color
    var action: () -> Void = {}
}

func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

struct FlyoutMenu_Previews: PreviewProvider {
    static var previews: some View {
        FlyoutMenu(isOpen: .constant(false))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
