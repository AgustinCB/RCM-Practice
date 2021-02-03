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
    
    @FetchRequest(entity: CustomExercise.entity(), sortDescriptors: [])
    var exercises: FetchedResults<CustomExercise>
    
    init() {
        UITableView.appearance().backgroundColor = purple
        UINavigationBar.appearance().backgroundColor = purple
    }
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    Section(header: Text(MenuMessages.CUSTOM_EXERCISES)) {
                        ForEach(exercises) { exercise in
                            if exercise.exercisePlayerType.isChordPlayer() {
                                NavigationLink(destination:exercise.getChordExercise()) {
                                    createNavigationButton(message: exercise.id!)
                                }
                            } else {
                                NavigationLink(destination:exercise.getIntervalExercise()) {
                                    createNavigationButton(message: exercise.id!)
                                }
                                
                            }
                        }
                    }
                }
                Group {
                    Section(header: Text(MenuMessages.PREPARATORY)) {
                        NavigationLink(destination: ExerciseView.init(messages: Grade1TriadExerciseMessages.init(), player: PentatonicAndChordPlayer.init())) {
                            createNavigationButton(message: MenuMessages.TRIAD_EXERCISE)
                        }
                    }
                }
                Group {
                    Section(header: Text(MenuMessages.GRADE_ONE)) {
                        NavigationLink(destination: ExerciseView.init(messages: Grade1IntervalExerciseMessages.init(), player: TwoNotesIntervalPlayer.init())) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade1TriadExerciseMessages.init(), player: ChordPlayer.init())) {
                            createNavigationButton(message: MenuMessages.TRIAD_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_TWO)) {
                        NavigationLink(destination: ExerciseView.init(messages: Grade2IntervalExerciseMessages.init(), player: ThreeNotesIntervalPlayer.init())) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade1TriadExerciseMessages.init(), player: BlockOnlyChordPlayer.init())) {
                            createNavigationButton(message: MenuMessages.TRIAD_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_THREE)) {
                        NavigationLink(destination: ExerciseView.init(messages: Grade3IntervalExerciseMessages.init(), player: FourNotesIntervalPlayer.init())) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade1TriadExerciseMessages.init(), player: BlockOnlyChordPlayer.init())) {
                            createNavigationButton(message: MenuMessages.TRIAD_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade3NoteInTriadExerciseMessages.init(), player: ChordAndIntervalPlayer.init())) {
                            createNavigationButton(message: MenuMessages.NOTE_IN_TRIAD_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_FOUR)) {
                        NavigationLink(destination: ExerciseView.init(messages: Grade4IntervalExerciseMessages.init(), player: FiveNotesIntervalPlayer.init())) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade1TriadExerciseMessages.init(), player: BlockOnlyChordPlayer.init())) {
                            createNavigationButton(message: MenuMessages.TRIAD_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade3NoteInTriadExerciseMessages.init(), player: ChordAndIntervalPlayer.init())) {
                            createNavigationButton(message: MenuMessages.NOTE_IN_TRIAD_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_FIVE)) {
                        NavigationLink(destination: ExerciseView.init(messages: Grade5IntervalExerciseMessages.init(), player: SevenNotesIntervalPlayer.init())) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade5ChordExerciseMessages.init(), player: ThreeQualitiesChordPlayer.init())) {
                            createNavigationButton(message: MenuMessages.CHORD_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade5ProgressionExerciseMessages.init(), player: ChordProgressionPlayer.init())) {
                            createNavigationButton(message: MenuMessages.PROGRESSION_EXERCISE)
                        }
                    }
                }
                Group {
                    Section(header: Text(MenuMessages.GRADE_SIX)) {
                        NavigationLink(destination: ExerciseView.init(messages: Grade6IntervalExerciseMessages.init(), player: NineNotesIntervalPlayer.init())) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade6ChordExerciseMessages.init(), player: FourQualitiesChordPlayer.init())) {
                            createNavigationButton(message: MenuMessages.CHORD_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade6ProgressionExerciseMessages.init(), player: FourOptionsChordProgressionPlayer.init())) {
                            createNavigationButton(message: MenuMessages.PROGRESSION_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_SEVEN)) {
                        NavigationLink(destination: ExerciseView.init(messages: Grade7IntervalExerciseMessages.init(), player: ElevenNotesIntervalPlayer.init())) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade7ChordExerciseMessages.init(), player: FiveQualitiesChordPlayer.init())) {
                            createNavigationButton(message: MenuMessages.CHORD_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade7ProgressionExerciseMessages.init(), player: SixOptionsChordProgressionPlayer.init())) {
                            createNavigationButton(message: MenuMessages.PROGRESSION_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_EIGHT)) {
                        NavigationLink(destination: ExerciseView.init(messages: Grade8IntervalExerciseMessages.init(), player: TwelveNotesIntervalPlayer.init())) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade7ChordExerciseMessages.init(), player: FiveQualitiesChordPlayer.init())) {
                            createNavigationButton(message: MenuMessages.CHORD_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade8ProgressionExerciseMessages.init(), player: EightOptionsChordProgressionPlayer.init())) {
                            createNavigationButton(message: MenuMessages.PROGRESSION_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_NINE)) {
                        NavigationLink(destination: ExerciseView.init(messages: Grade8IntervalExerciseMessages.init(), player: TwelveNotesIntervalPlayer.init())) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade9ChordExerciseMessages.init(), player: SixQualitiesChordPlayer.init())) {
                            createNavigationButton(message: MenuMessages.CHORD_EXERCISE)
                        }
                        NavigationLink(destination: RandomChordProgressionView()) {
                            createNavigationButton(message: MenuMessages.PROGRESSION_EXERCISE)
                        }
                    }
                    Section(header: Text(MenuMessages.GRADE_TEN)) {
                        NavigationLink(destination: ExerciseView.init(messages: Grade10IntervalExerciseMessages.init(), player: FourteenNotesIntervalPlayer.init())) {
                            createNavigationButton(message: MenuMessages.INTERVAL_EXERCISE)
                        }
                        NavigationLink(destination: ExerciseView.init(messages: Grade10ChordExerciseMessages.init(), player: EightQualitiesChordPlayer.init())) {
                            createNavigationButton(message: MenuMessages.CHORD_EXERCISE)
                        }
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
