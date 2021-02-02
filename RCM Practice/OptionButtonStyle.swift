//
//  OptionButtonStyle.swift
//  RCM Practice
//

import SwiftUI

struct OptionButtonStyle: ButtonStyle {
    let color: Color = .init(red: 0, green: 66/255, blue: 137/255)

    public func makeBody(configuration: OptionButtonStyle.Configuration) -> some View {
        configuration.label
            .scaledToFit()
            .foregroundColor(.white)
            .padding(10)
            .frame(idealWidth: 400, maxWidth: 400)
            .background(RoundedRectangle(cornerRadius: 5).fill(color))
            .compositingGroup()
            .shadow(color: .black, radius: 3)
            .opacity(configuration.isPressed ? 0.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
   }
}
