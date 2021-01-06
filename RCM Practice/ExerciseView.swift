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
    static var WELLCOME_MESSAGE: String { get }
    static var PLAY_MESSAGE: String { get }
    static var PLAYING_MESSAGE: String { get }
    static var GUESSES: [String] { get }
    static var GUESSED_MESSAGES: [String] { get }
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
    @State var score: Int = 0
    @State var message: String = M.WELLCOME_MESSAGE
    @State var player: P! = P.init()
    
    fileprivate func processGuess(quality: P.G) {
        var result: String = ""
        if self.player!.checkGuess(quality) {
            self.score += 1
            result = GeneralMessages.CORRECT_GUESS
        } else {
            result = GeneralMessages.INCORRECT_GUESS
        }
        self.message = result
        self.player!.randomReset()
    }
    
    var body: some View {
        List {
            Section(header: Button(M.PLAY_MESSAGE, action: {
                self.message = M.PLAYING_MESSAGE
                self.player!.play()
            }), footer: Text(self.message)) {
                ForEach(Array(zip(M.GUESSES.indices, M.GUESSES)), id: \.0) { guessIndex, guessMessage in
                    Button(guessMessage, action: {
                        self.message = M.GUESSED_MESSAGES[guessIndex]
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            self.processGuess(quality: self.player!.guess(guessIndex))
                        }
                    })
                }
            }
        }.navigationBarTitle(M.WELLCOME_MESSAGE)
    }
}

struct ExerciseView_Previews<M: ExerciseMessages, P: ExercisePlayer>: PreviewProvider {
    static var previews: some View {
        ExerciseView<M, P>()
    }
}
