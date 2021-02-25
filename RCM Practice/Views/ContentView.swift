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
    static let CUSTOM_EXERCISES = "Custom exercises"
    static let CHORD_EXERCISE = "Chord exercise"
    static let INTERVAL_EXERCISE = "Interval exercise"
    static let TRIAD_EXERCISE = "Triad exercise"
    static let PROGRESSION_EXERCISE = "Progression exercise"
    static let NOTE_IN_TRIAD_EXERCISE = "Note in triad exercise"
    static let HEADER = "RCM Aural Practice"
    static let CREATE_INTERVAL_EXERCISE = "Create Interval Exercise"
    static let CREATE_CHORD_EXERCISE = "Create Chord Exercise"
}

func createNavigationButton(message: String) -> some View {
    Text(message)
}

func createHeader(_ content: String) -> some View {
    Text(content).foregroundColor(Color.black)
}

struct HomeView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("RCM Aural Practice for Piano - 2015 Edition")
                .font(.largeTitle)
                .foregroundColor(.primary)
                .accessibility(addTraits: .isHeader)
                .scaledToFill()
                .padding(10)
            Image(uiImage: UIImage(named: "Splash")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
            Spacer()
        }
        .frame(minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .aspectRatio(contentMode: .fill)
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let purple = UIColor.init(Color.init(red: 190/255, green: 185/255, blue: 210/255))
    @State private var showAlerts: [Bool] = []
 
    @FetchRequest(entity: CustomExercise.entity(), sortDescriptors: [])
    var exercises: FetchedResults<CustomExercise>

    @FetchRequest(entity: PreparatoryHistory.entity(), sortDescriptors: [])
    var preparatoryHistoryResult: FetchedResults<PreparatoryHistory>
    @FetchRequest(entity: Grade1IntervalHistory.entity(), sortDescriptors: [])
    var grade1IntervalHistoryResult: FetchedResults<Grade1IntervalHistory>
    @FetchRequest(entity: Grade1ChordHistory.entity(), sortDescriptors: [])
    var grade1ChordHistoryResult: FetchedResults<Grade1ChordHistory>
    @FetchRequest(entity: Grade2IntervalHistory.entity(), sortDescriptors: [])
    var grade2IntervalHistoryResult: FetchedResults<Grade2IntervalHistory>
    @FetchRequest(entity: Grade2ChordHistory.entity(), sortDescriptors: [])
    var grade2ChordHistoryResult: FetchedResults<Grade2ChordHistory>
    @FetchRequest(entity: Grade3IntervalHistory.entity(), sortDescriptors: [])
    var grade3IntervalHistoryResult: FetchedResults<Grade3IntervalHistory>
    @FetchRequest(entity: Grade3ChordHistory.entity(), sortDescriptors: [])
    var grade3ChordHistoryResult: FetchedResults<Grade3ChordHistory>
    @FetchRequest(entity: Grade3NoteInChordHistory.entity(), sortDescriptors: [])
    var grade3NoteInChordHistoryResult: FetchedResults<Grade3NoteInChordHistory>
    @FetchRequest(entity: Grade4IntervalHistory.entity(), sortDescriptors: [])
    var grade4IntervalHistoryResult: FetchedResults<Grade4IntervalHistory>
    @FetchRequest(entity: Grade4ChordHistory.entity(), sortDescriptors: [])
    var grade4ChordHistoryResult: FetchedResults<Grade4ChordHistory>
    @FetchRequest(entity: Grade4NoteInChordHistory.entity(), sortDescriptors: [])
    var grade4NoteInChordHistoryResult: FetchedResults<Grade4NoteInChordHistory>
    @FetchRequest(entity: Grade5IntervalHistory.entity(), sortDescriptors: [])
    var grade5IntervalHistoryResult: FetchedResults<Grade5IntervalHistory>
    @FetchRequest(entity: Grade5ChordHistory.entity(), sortDescriptors: [])
    var grade5ChordHistoryResult: FetchedResults<Grade5ChordHistory>
    @FetchRequest(entity: Grade5ProgressionHistory.entity(), sortDescriptors: [])
    var grade5ProgressionHistoryResult: FetchedResults<Grade5ProgressionHistory>
    @FetchRequest(entity: Grade6IntervalHistory.entity(), sortDescriptors: [])
    var grade6IntervalHistoryResult: FetchedResults<Grade6IntervalHistory>
    @FetchRequest(entity: Grade6ChordHistory.entity(), sortDescriptors: [])
    var grade6ChordHistoryResult: FetchedResults<Grade6ChordHistory>
    @FetchRequest(entity: Grade6ProgressionHistory.entity(), sortDescriptors: [])
    var grade6ProgressionHistoryResult: FetchedResults<Grade6ProgressionHistory>
    @FetchRequest(entity: Grade7IntervalHistory.entity(), sortDescriptors: [])
    var grade7IntervalHistoryResult: FetchedResults<Grade7IntervalHistory>
    @FetchRequest(entity: Grade7ChordHistory.entity(), sortDescriptors: [])
    var grade7ChordHistoryResult: FetchedResults<Grade7ChordHistory>
    @FetchRequest(entity: Grade7ProgressionHistory.entity(), sortDescriptors: [])
    var grade7ProgressionHistoryResult: FetchedResults<Grade7ProgressionHistory>
    @FetchRequest(entity: Grade8IntervalHistory.entity(), sortDescriptors: [])
    var grade8IntervalHistoryResult: FetchedResults<Grade8IntervalHistory>
    @FetchRequest(entity: Grade8ChordHistory.entity(), sortDescriptors: [])
    var grade8ChordHistoryResult: FetchedResults<Grade8ChordHistory>
    @FetchRequest(entity: Grade8ProgressionHistory.entity(), sortDescriptors: [])
    var grade8ProgressionHistoryResult: FetchedResults<Grade8ProgressionHistory>
    @FetchRequest(entity: Grade9IntervalHistory.entity(), sortDescriptors: [])
    var grade9IntervalHistoryResult: FetchedResults<Grade9IntervalHistory>
    @FetchRequest(entity: Grade9ChordHistory.entity(), sortDescriptors: [])
    var grade9ChordHistoryResult: FetchedResults<Grade9ChordHistory>
    @FetchRequest(entity: Grade9ProgressionHistory.entity(), sortDescriptors: [])
    var grade9ProgressionHistoryResult: FetchedResults<Grade9ProgressionHistory>
    @FetchRequest(entity: Grade10IntervalHistory.entity(), sortDescriptors: [])
    var grade10IntervalHistoryResult: FetchedResults<Grade10IntervalHistory>
    @FetchRequest(entity: Grade10ChordHistory.entity(), sortDescriptors: [])
    var grade10ChordHistoryResult: FetchedResults<Grade10ChordHistory>
    @FetchRequest(entity: Grade10ProgressionHistory.entity(), sortDescriptors: [])
    var grade10ProgressionHistoryResult: FetchedResults<Grade10ProgressionHistory>

    init() {
        UITableView.appearance().backgroundColor = purple
        UINavigationBar.appearance().backgroundColor = purple
    }
    
    func updateHistoryForExercise<H: FixedExerciseHistory>(_ won: Bool, _ index: UInt8, _ historyResult: FetchedResults<H>) {
        let newEntry = HistoryEntry(success: won, option: index)
        if historyResult.count == 0 {
            let newHistoryRecord = H.init(context: viewContext)
            newHistoryRecord.historyData = Data.init(newEntry.toData())
            print(newHistoryRecord.historyData!)
        } else {
            var newData: Data = (historyResult.first!.historyData ?? Data.init())
            newData.append(contentsOf: newEntry.toData())
            historyResult.first!.historyData = newData
            print(historyResult.first!.historyData!)
        }
        do {
            try viewContext.save()
        } catch {
            // do something
        }
    }

    func createHistoryNavigationLink(_ history: [HistoryEntry], _ historyOptions: [String], _ name: String) -> some View {
        NavigationLink(destination: HistoryView(
                historyEntries: history,
                historyOptions: historyOptions
        )) {
            createNavigationButton(message: "\(name) history")
        }
    }

    func createFixedExerciseNavigationLink<H: FixedExerciseHistory, M: ExerciseMessages, P: ExercisePlayer> (
            _ historyResult: FetchedResults<H>,
            _ messages: M,
            _ player: P,
            _ buttonMessage: String
    ) -> some View {
        Group {
            NavigationLink(destination: ExerciseView.init(action: { won, index in
                updateHistoryForExercise(won, index, historyResult)
            }, messages: messages, player: player)) {
                createNavigationButton(message: buttonMessage)
            }
            createHistoryNavigationLink(
                HistoryEntry.fromData(data: historyResult.first?.historyData),
                messages.GUESSES,
                buttonMessage
            )
        }
    }

    var body: some View {
        NavigationView {
            List {
                Group {
                    Section(header: Text(MenuMessages.CUSTOM_EXERCISES)) {
                        NavigationLink(destination: CustomIntervalExerciseView()) {
                            createNavigationButton(message: MenuMessages.CREATE_INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: CustomChordExerciseView()) {
                            createNavigationButton(message: MenuMessages.CREATE_CHORD_EXERCISE)
                        }
                        ForEach(exercises) { exercise in
                            Group {
                                if exercise.exercisePlayerType.isChordPlayer() {
                                    NavigationLink(destination:exercise.getChordExercise()) {
                                        TextWithDeleteOption(action: {
                                            viewContext.delete(exercise)
                                        }, message: exercise.id!)
                                    }
                                } else {
                                    NavigationLink(destination:exercise.getIntervalExercise()) {
                                        TextWithDeleteOption(action: {
                                            viewContext.delete(exercise)
                                        }, message: exercise.id!)
                                    }
                                }
                                createHistoryNavigationLink(
                                        exercise.history,
                                        exercise.exercisePlayerType.isChordPlayer() ? exercise.qualities.map({ c in c.toString() }) : exercise.notes.map({ i in i.toQualifiedString()}),
                                        exercise.id!
                                )
                            }
                        }
                    }
                }
                Group {
                    Section(header: Text(MenuMessages.PREPARATORY)) {
                        createFixedExerciseNavigationLink(
                          preparatoryHistoryResult, Grade1TriadExerciseMessages.init(), PentatonicAndChordPlayer.init(), MenuMessages.TRIAD_EXERCISE
                        )
                    }
                }
                Group {
                    Section(header: Text(MenuMessages.GRADE_ONE)) {
                        createFixedExerciseNavigationLink(
                                grade1IntervalHistoryResult, Grade1IntervalExerciseMessages.init(), TwoNotesIntervalPlayer.init(), MenuMessages.INTERVAL_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade1ChordHistoryResult, Grade1TriadExerciseMessages.init(), ChordPlayer.init(), MenuMessages.TRIAD_EXERCISE
                        )
                    }
                    Section(header: Text(MenuMessages.GRADE_TWO)) {
                        createFixedExerciseNavigationLink(
                                grade2IntervalHistoryResult, Grade2IntervalExerciseMessages.init(), ThreeNotesIntervalPlayer.init(), MenuMessages.INTERVAL_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade2ChordHistoryResult, Grade1TriadExerciseMessages.init(), BlockOnlyChordPlayer.init(), MenuMessages.TRIAD_EXERCISE
                        )
                    }
                    Section(header: Text(MenuMessages.GRADE_THREE)) {
                        createFixedExerciseNavigationLink(
                                grade3IntervalHistoryResult, Grade3IntervalExerciseMessages.init(), FourNotesIntervalPlayer.init(), MenuMessages.INTERVAL_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade3ChordHistoryResult, Grade1TriadExerciseMessages.init(), BlockOnlyChordPlayer.init(), MenuMessages.TRIAD_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade3NoteInChordHistoryResult, Grade3NoteInTriadExerciseMessages.init(), ChordAndIntervalPlayer.init(), MenuMessages.NOTE_IN_TRIAD_EXERCISE
                        )
                    }
                    Section(header: Text(MenuMessages.GRADE_FOUR)) {
                        createFixedExerciseNavigationLink(
                                grade4IntervalHistoryResult, Grade4IntervalExerciseMessages.init(), FiveNotesIntervalPlayer.init(), MenuMessages.INTERVAL_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade4ChordHistoryResult, Grade1TriadExerciseMessages.init(), BlockOnlyChordPlayer.init(), MenuMessages.TRIAD_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade4NoteInChordHistoryResult, Grade3NoteInTriadExerciseMessages.init(), ChordAndIntervalPlayer.init(), MenuMessages.NOTE_IN_TRIAD_EXERCISE
                        )
                    }
                    Section(header: Text(MenuMessages.GRADE_FIVE)) {
                        createFixedExerciseNavigationLink(
                                grade5IntervalHistoryResult, Grade5IntervalExerciseMessages.init(), SevenNotesIntervalPlayer.init(), MenuMessages.INTERVAL_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade5ChordHistoryResult, Grade5ChordExerciseMessages.init(), ThreeQualitiesChordPlayer.init(), MenuMessages.TRIAD_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade5ProgressionHistoryResult, Grade5ProgressionExerciseMessages.init(), ChordProgressionPlayer.init(), MenuMessages.PROGRESSION_EXERCISE
                        )
                    }
                }
                Group {
                    Section(header: Text(MenuMessages.GRADE_SIX)) {
                        createFixedExerciseNavigationLink(
                                grade6IntervalHistoryResult, Grade6IntervalExerciseMessages.init(), NineNotesIntervalPlayer.init(), MenuMessages.INTERVAL_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade6ChordHistoryResult, Grade6ChordExerciseMessages.init(), FourQualitiesChordPlayer.init(), MenuMessages.TRIAD_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade6ProgressionHistoryResult, Grade6ProgressionExerciseMessages.init(), FourOptionsChordProgressionPlayer.init(), MenuMessages.PROGRESSION_EXERCISE
                        )
                    }
                    Section(header: Text(MenuMessages.GRADE_SEVEN)) {
                        createFixedExerciseNavigationLink(
                                grade7IntervalHistoryResult, Grade7IntervalExerciseMessages.init(), ElevenNotesIntervalPlayer.init(), MenuMessages.INTERVAL_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade7ChordHistoryResult, Grade7ChordExerciseMessages.init(), FiveQualitiesChordPlayer.init(), MenuMessages.TRIAD_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade7ProgressionHistoryResult, Grade7ProgressionExerciseMessages.init(), SixOptionsChordProgressionPlayer.init(), MenuMessages.PROGRESSION_EXERCISE
                        )
                    }
                    Section(header: Text(MenuMessages.GRADE_EIGHT)) {
                        createFixedExerciseNavigationLink(
                                grade8IntervalHistoryResult, Grade8IntervalExerciseMessages.init(), TwelveNotesIntervalPlayer.init(), MenuMessages.INTERVAL_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade8ChordHistoryResult, Grade7ChordExerciseMessages.init(), FiveQualitiesChordPlayer.init(), MenuMessages.TRIAD_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade8ProgressionHistoryResult, Grade8ProgressionExerciseMessages.init(), EightOptionsChordProgressionPlayer.init(), MenuMessages.PROGRESSION_EXERCISE
                        )
                    }
                    Section(header: Text(MenuMessages.GRADE_NINE)) {
                        createFixedExerciseNavigationLink(
                                grade9IntervalHistoryResult, Grade8IntervalExerciseMessages.init(), TwelveNotesIntervalPlayer.init(), MenuMessages.INTERVAL_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade9ChordHistoryResult, Grade9ChordExerciseMessages.init(), SixQualitiesChordPlayer.init(), MenuMessages.TRIAD_EXERCISE
                        )
                        NavigationLink(destination: RandomChordProgressionView()) {
                            createNavigationButton(message: MenuMessages.PROGRESSION_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_TEN)) {
                        createFixedExerciseNavigationLink(
                                grade10IntervalHistoryResult, Grade10IntervalExerciseMessages.init(), FourteenNotesIntervalPlayer.init(), MenuMessages.INTERVAL_EXERCISE
                        )
                        createFixedExerciseNavigationLink(
                                grade10ChordHistoryResult, Grade10ChordExerciseMessages.init(), EightQualitiesChordPlayer.init(), MenuMessages.TRIAD_EXERCISE
                        )
                        NavigationLink(destination: RandomOrCadential64ChordProgressionView()) {
                            createNavigationButton(message: MenuMessages.PROGRESSION_EXERCISE)
                        }
                    }
                }
            }
            .background(Color(purple))
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(MenuMessages.HEADER)
            HomeView()
                .background(Color(purple))
        }
        .background(Color(purple))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
