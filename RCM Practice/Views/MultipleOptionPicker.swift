//
//  MultipleOptionPicker.swift
//  RCM Practice
//
//  Created by Agustin Chiappe Berrini on 2021-02-09.
//
/*
import SwiftUI

struct PickerItem {
    var label: String?
    var state: Bool?
}

struct MultipleOptionPicker<Content: View>: View {
    let content: Content
    @State var options: Binding<[PickerItem]>?
    
    init(options: Binding<[PickerItem]>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.options = options
    }
    
    var body: some View {
        Group {
            ForEach(0 ..< ChordQuality.allCases.count) { index in
                Toggle(ChordQuality.allCases[index].toString(), isOn: Binding(
                    get: { options[index].state.wrappedValue! },
                    set: {
                        options[index].state.wrappedValue = $0
                    }
                ))
            }
        }
    }
}
*/
