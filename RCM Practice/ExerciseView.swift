//
//  ExerciseView.swift
//  RCM Practice
//
//  Created by Agustin Chiappe Berrini on 2020-11-12.
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
    static var FIRST_GUESS: String { get }
    static var SECOND_GUESS: String { get }
    static var GUESSED_FIRST: String { get }
    static var GUESSED_SECOND: String { get }
}

protocol ExercisePlayer	{
    associatedtype G
    init()
    func checkGuess(_ guess: G) -> Bool
    mutating func randomReset()
    func play()
    static func firstGuess() -> G
    static func secondGuess() -> G
}

struct ExerciseView<M: ExerciseMessages, P: ExercisePlayer>: View {
    @State var score: Int = 0
    @State var message: String = M.WELLCOME_MESSAGE
    @State var player: P! = P.init()
    
    fileprivate func processGuess(quality: P.G) {
        var result: String = ""
        if self.player.checkGuess(quality) {
            self.score += 1
            result = GeneralMessages.CORRECT_GUESS
        } else {
            result = GeneralMessages.INCORRECT_GUESS
        }
        self.message = result
        self.player.randomReset()
    }
    
    var body: some View {
        VStack {
            Text("\(self.message)")
                .padding()
            Button(M.PLAY_MESSAGE, action: {
                self.message = M.PLAYING_MESSAGE
                self.player.play()
            })
            .padding(.bottom)
            HStack {
                Button(M.FIRST_GUESS, action: {
                    self.message = M.GUESSED_FIRST;
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        processGuess(quality: P.firstGuess())
                    }
                })
                .padding(.leading)
                Button(M.SECOND_GUESS, action: {
                    self.message = M.GUESSED_SECOND
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        processGuess(quality: P.secondGuess())
                    }
                })
                .padding(.trailing)
            }
            Text("Your score is \(self.score)")
                .padding(.top)
        }
    }
}

struct ExerciseView_Previews<M: ExerciseMessages, P: ExercisePlayer>: PreviewProvider {
    static var previews: some View {
        ExerciseView<M, P>()
    }
}
