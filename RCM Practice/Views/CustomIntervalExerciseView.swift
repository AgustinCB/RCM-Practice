//
//  CustomIntervalExerciseView.swift
//  RCM Practice
//

import SwiftUI

struct CustomIntervalExerciseView: View {
    let purple = UIColor.init(Color.init(red: 190/255, green: 185/255, blue: 210/255))
    let possibleTypes: [ExercisePlayerType] = [.intervalMelodicAndHarmonic, .intervalMelodicOrHarmonic, .intervalMelodicAscendingAndDescending]
    @State var exerciseName = ""
    @State var status = ""
    @State var type = 0
    @State var selectedNotes = Note.allCases.map({n in false})
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
                    ForEach(0 ..< Note.allCases.count) {
                        Toggle(Note.allCases[$0].toQualifiedString(), isOn: $selectedNotes[$0])
                    }
                }
                CenteredContent {
                    Button("Create Exercise", action: {
                        let customExercise = CustomExercise.init(context: viewContext)
                        customExercise.id = exerciseName
                        customExercise.exercisePlayerType = possibleTypes[type]
                        customExercise.notes = selectedNotes.enumerated()
                            .filter({index, active in active})
                            .map({index, active in
                            Note.allCases[index]
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
        .navigationBarTitle(MenuMessages.CREATE_INTERVAL_EXERCISE)
    }
}

struct CustomIntervalExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        CustomIntervalExerciseView()
    }
}
