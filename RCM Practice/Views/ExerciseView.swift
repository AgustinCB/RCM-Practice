//
//  ExerciseView.swift
//  RCM Practice
//

import SwiftUI

struct GeneralMessages {
    static var CORRECT_GUESS = "You guessed correctly! Hurray!"
    static var INCORRECT_GUESS = "You guessed wrongly! Looser!"
}

protocol ExerciseMessages {
    var WELLCOME_MESSAGE: String { get }
    var PLAY_MESSAGE: String { get }
    var PLAYING_MESSAGE: String { get }
    var GUESSES: [String] { get }
    var GUESSED_MESSAGES: [String] { get }
    
    init()
}

struct DynamicMessages: ExerciseMessages {
    var WELLCOME_MESSAGE: String
    var PLAY_MESSAGE: String
    var PLAYING_MESSAGE: String
    var GUESSES: [String]
    var GUESSED_MESSAGES: [String]
    
    init(){
        WELLCOME_MESSAGE = ""
        PLAY_MESSAGE = ""
        PLAYING_MESSAGE = ""
        GUESSES = []
        GUESSED_MESSAGES = []
    }
    
    init(notes: [Note], name: String) {
        self.WELLCOME_MESSAGE = name
        self.PLAY_MESSAGE = "Play \(name)"
        self.PLAYING_MESSAGE = "Playing \(name)"
        self.GUESSES = notes.map({n in "Guess \(n.toQualifiedString())"})
        self.GUESSED_MESSAGES = notes.map({n in "Guessed \(n.toQualifiedString())"})
    }
    
    init(qualities: [ChordQuality], name: String) {
        self.WELLCOME_MESSAGE = name
        self.PLAY_MESSAGE = "Play \(name)"
        self.PLAYING_MESSAGE = "Playing \(name)"
        self.GUESSES = qualities.map({n in "Guess \(n.toString())"})
        self.GUESSED_MESSAGES = qualities.map({n in "Guessed \(n.toString())"})
    }
}

protocol ExercisePlayer	{
    associatedtype G
    init()
    func checkGuess(_ guess: G) -> Bool
    mutating func randomReset()
    func play()
    func guess(_ guessIndex: Int) -> G
}

struct ExerciseView<M: ExerciseMessages, P: ExercisePlayer>: View {
    var action: ((Bool, UInt8) -> Void)? = nil
    var messages: M = M.init()
    @State var score: Int = 0
    @State var message: String = ""
    @State var player: P?
    @Environment(\.managedObjectContext) private var viewContext
    
    fileprivate func processGuess(quality: P.G, index: Int) {
        var result: String = ""
        let won = self.player!.checkGuess(quality)
        if won {
            self.score += 1
            result = GeneralMessages.CORRECT_GUESS
        } else {
            result = GeneralMessages.INCORRECT_GUESS
        }
        self.message = result
        if action != nil {
            action!(won, UInt8(index))
            do {
                try viewContext.save()
            } catch {
                self.message = error.localizedDescription
            }
        }
        self.player!.randomReset()
    }
    
    var body: some View {
        List {
            Section(header: createHeader(self.message)) {
                Group {
                    CenteredContent {
                        Button(messages.PLAY_MESSAGE, action: {
                            self.message = self.messages.PLAYING_MESSAGE
                            self.player!.play()
                        })
                        .buttonStyle(ActionButtonStyle())
                    }
                    ForEach(Array(zip(messages.GUESSES.indices, messages.GUESSES)), id: \.0) { guessIndex, guessMessage in
                        CenteredContent {
                            Button(guessMessage, action: {
                                self.message = messages.GUESSED_MESSAGES[guessIndex]
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                                    self.processGuess(quality: self.player!.guess(guessIndex), index: guessIndex)
                                }
                            })
                            .buttonStyle(OptionButtonStyle())
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(messages.WELLCOME_MESSAGE)
    }
}

struct ExerciseView_Previews<M: ExerciseMessages, P: ExercisePlayer>: PreviewProvider {
    static var previews: some View {
        ExerciseView<M, P>(messages: M.init())
    }
}
