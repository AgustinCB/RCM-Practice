//
//  ActionButtonStyle.swift
//  RCM Practice
//

import SwiftUI

struct ActionButtonStyle: ButtonStyle {
    var color: Color = .init(red: 1, green: 33/255, blue: 33/255)

    public func makeBody(configuration: ActionButtonStyle.Configuration) -> some View {
        configuration
            .label
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

