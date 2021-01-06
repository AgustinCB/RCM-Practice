//
//  ContentView.swift
//  RCM Practice
//

import SwiftUI

struct MenuMessages {
    static let PREPARATORY = "Preparatory A and B"
    static let GRADE_ONE = "Grade one"
    static let GRADE_TWO = "Grade two"
    static let GRADE_THREE = "Grade three"
    static let GRADE_FOUR = "Grade four"
    static let GRADE_FIVE = "Grade five"
    static let GRADE_SIX = "Grade six"
    static let GRADE_SEVEN = "Grade seven"
    static let GRADE_EIGHT = "Grade eight"
    static let GRADE_NINE = "Grade nine"
    static let GRADE_TEN = "Grade ten"
    static let CHORD_EXERCISE = "Chord exercise"
    static let INTERVAL_EXERCISE = "Interval exercise"
    static let TRIAD_EXERCISE = "Triad exercise"
    static let PROGRESSION_EXERCISE = "Progression exercise"
    static let NOTE_IN_TRIAD_EXERCISE = "Note in triad exercise"
    static let HEADER = "RCM Aural Practice"
}

func createNavigationButton(message: String) -> some View {
    Text(message)
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Group {
                    Section(header: Text(MenuMessages.PREPARATORY)) {
                        NavigationLink(destination: ExerciseView<Grade1TriadExerciseMessages, PentatonicAndChordPlayer>()) {
                            createNavigationButton(message: MenuMessages.TRIAD_EXERCISE)
                        }
                    }
                }
                Group {
                    Section(header: Text(MenuMessages.GRADE_ONE)) {
                        NavigationLink(destination: ExerciseView<Grade1IntervalExerciseMessages, TwoNotesIntervalPlayer>()) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade1TriadExerciseMessages, ChordPlayer>()) {
                            createNavigationButton(message: MenuMessages.TRIAD_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_TWO)) {
                        NavigationLink(destination: ExerciseView<Grade2IntervalExerciseMessages, ThreeNotesIntervalPlayer>()) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade1TriadExerciseMessages, BlockOnlyChordPlayer>()) {
                            createNavigationButton(message: MenuMessages.TRIAD_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_THREE)) {
                        NavigationLink(destination: ExerciseView<Grade3IntervalExerciseMessages, FourNotesIntervalPlayer>()) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade1TriadExerciseMessages, BlockOnlyChordPlayer>()) {
                            createNavigationButton(message: MenuMessages.TRIAD_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade3NoteInTriadExerciseMessages, ChordAndIntervalPlayer>()) {
                            createNavigationButton(message: MenuMessages.NOTE_IN_TRIAD_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_FOUR)) {
                        NavigationLink(destination: ExerciseView<Grade4IntervalExerciseMessages, FiveNotesIntervalPlayer>()) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade1TriadExerciseMessages, BlockOnlyChordPlayer>()) {
                            createNavigationButton(message: MenuMessages.TRIAD_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade3NoteInTriadExerciseMessages, ChordAndIntervalPlayer>()) {
                            createNavigationButton(message: MenuMessages.NOTE_IN_TRIAD_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_FIVE)) {
                        NavigationLink(destination: ExerciseView<Grade5IntervalExerciseMessages, SevenNotesIntervalPlayer>()) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade5ChordExerciseMessages, ThreeQualitiesChordPlayer>()) {
                            createNavigationButton(message: MenuMessages.CHORD_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade5ProgressionExerciseMessages, ChordProgressionPlayer>()) {
                            createNavigationButton(message: MenuMessages.PROGRESSION_EXERCISE)
                        }
                    }
                }
                Group {
                    Section(header: Text(MenuMessages.GRADE_SIX)) {
                        NavigationLink(destination: ExerciseView<Grade6IntervalExerciseMessages, NineNotesIntervalPlayer>()) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade6ChordExerciseMessages, FourQualitiesChordPlayer>()) {
                            createNavigationButton(message: MenuMessages.CHORD_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade6ProgressionExerciseMessages, FourOptionsChordProgressionPlayer>()) {
                            createNavigationButton(message: MenuMessages.PROGRESSION_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_SEVEN)) {
                        NavigationLink(destination: ExerciseView<Grade7IntervalExerciseMessages, ElevenNotesIntervalPlayer>()) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade7ChordExerciseMessages, FiveQualitiesChordPlayer>()) {
                            createNavigationButton(message: MenuMessages.CHORD_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade7ProgressionExerciseMessages, SixOptionsChordProgressionPlayer>()) {
                            createNavigationButton(message: MenuMessages.PROGRESSION_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_EIGHT)) {
                        NavigationLink(destination: ExerciseView<Grade8IntervalExerciseMessages, TwelveNotesIntervalPlayer>()) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade7ChordExerciseMessages, FiveQualitiesChordPlayer>()) {
                            createNavigationButton(message: MenuMessages.CHORD_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade8ProgressionExerciseMessages, EightOptionsChordProgressionPlayer>()) {
                            createNavigationButton(message: MenuMessages.PROGRESSION_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_NINE)) {
                        NavigationLink(destination: ExerciseView<Grade8IntervalExerciseMessages, TwelveNotesIntervalPlayer>()) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade9ChordExerciseMessages, SixQualitiesChordPlayer>()) {
                            createNavigationButton(message: MenuMessages.CHORD_EXERCISE)
                        }
                        NavigationLink(destination: RandomChordProgressionView()) {
                            createNavigationButton(message: MenuMessages.PROGRESSION_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_TEN)) {
                        NavigationLink(destination: ExerciseView<Grade10IntervalExerciseMessages, FourteenNotesIntervalPlayer>()) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView<Grade10ChordExerciseMessages, EightQualitiesChordPlayer>()) {
                            createNavigationButton(message: MenuMessages.CHORD_EXERCISE)
                        }
                        NavigationLink(destination: RandomOrCadential64ChordProgressionView()) {
                            createNavigationButton(message: MenuMessages.PROGRESSION_EXERCISE)
                        }
                    }
                }
            }.navigationBarTitle(MenuMessages.HEADER)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
