//
//  CustomChordExerciseView.swift
//  RCM Practice
//
//  Created by Agustin Chiappe Berrini on 2021-02-09.
//

import SwiftUI

struct CustomChordExerciseView: View {
    let purple = UIColor.init(Color.init(red: 190/255, green: 185/255, blue: 210/255))
    let possibleTypes: [ExercisePlayerType] = [.chord, .chordBlockOnly, .chordWithPentatonic]
    @State var exerciseName = ""
    @State var status = ""
    @State var type = 0
    @State var selectedChords = ChordQuality.allCases.map({n in false})
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        List {
            Section(header: createHeader(self.status)) {
                CenteredContent {
                    TextField("Exercise Name", text: $exerciseName)
                }
                CenteredContent {
                    Picker("Exercise Type", selection: $type) {
                        ForEach(0 ..< possibleTypes.count) {
                            Text(possibleTypes[$0].toString())
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                Group {
                    ForEach(0 ..< ChordQuality.allCases.count) {
                        Toggle(ChordQuality.allCases[$0].toString(), isOn: $selectedChords[$0])
                    }
                }
                CenteredContent {
                    Button("Create Exercise", action: {
                        let customExercise = CustomExercise.init(context: viewContext)
                        customExercise.id = exerciseName
                        customExercise.exercisePlayerType = possibleTypes[type]
                        customExercise.qualities = selectedChords.enumerated()
                            .filter({index, active in active})
                            .map({index, active in
                            ChordQuality.allCases[index]
                        })
                        do {
                            try viewContext.save()
                            status = "Exercise \(exerciseName) created"
                        } catch {
                            status = error.localizedDescription
                        }
                    })
                    .buttonStyle(ActionButtonStyle())
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(MenuMessages.CREATE_CHORD_EXERCISE)
    }
}

struct CustomChordExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        CustomChordExerciseView()
    }
}
