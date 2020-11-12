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
                    NavigationLink(destination: ExerciseView<Grade1IntervalExerciseMessages, IntervalPlayer>()) {
                        Text(MenuMessages.GRADE_ONE_INTERVAL_EXERCISE)
                    }
                    NavigationLink(destination: ExerciseView<Grade1TriadExerciseMessages, ChordPlayer>()) {
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
