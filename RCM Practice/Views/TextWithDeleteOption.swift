//
//  TextWithDeleteOption.swift
//  RCM Practice
//
//  Created by Agustin Chiappe Berrini on 2021-02-11.
//

import SwiftUI

struct TextWithDeleteOption: View {
    let action: (() -> Void)?
    let message: String?
    @State private var showAlert = false
    
    var body: some View {
        HStack {
            Text(message!)
            Text("Delete")
            .foregroundColor(.white)
            .padding(2)
            .frame(width: 70, height: 15)
            .background(RoundedRectangle(cornerRadius: 2).fill(Color.red))
            .compositingGroup()
            .shadow(color: .black, radius: 3)
            .onTapGesture {
                showAlert = true
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Are you sure you want to delete \(message!)?"),
                    message: Text("This action will erase all data related with the exercise."),
                    primaryButton: .default(
                        Text("Cancel"),
                        action: {showAlert = false}
                    ),
                    secondaryButton: .destructive(
                        Text("Delete"),
                        action: action
                    )
                )
            }
        }
    }
}
