//
//  ContentView.swift
//  RCM Practice
//

import SwiftUI

struct MenuMessages {
    static let GRADE_ONE = "Grade one"
    static let GRADE_ONE_INTERVAL_EXERCISE = "Interval exercise"
    static let GRADE_ONE_TRIAD_EXERCISE = "Triad exercise"
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text(MenuMessages.GRADE_ONE)
                HStack {
                    NavigationLink(destination: Grade1IntervalExercise()) {
                        Text(MenuMessages.GRADE_ONE_INTERVAL_EXERCISE)
                    }
                    NavigationLink(destination: Grade1TriadExercise()) {
                        Text(MenuMessages.GRADE_ONE_TRIAD_EXERCISE)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
