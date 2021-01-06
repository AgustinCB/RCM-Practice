//
//  Grade3IntervalExercise.swift
//  RCM Practice
//

import SwiftUI

struct Grade5IntervalExerciseMessages: ExerciseMessages {
    static let PLAY_MESSAGE: String = "Play Sequence"
    static let PLAYING_MESSAGE: String = "Playing the Sequence..."
    static var GUESSES: [String] = ["Guess Minor Third", "Guess Major Third", "Perfect Forth", "Perfect Fifth", "Minor Sixth", "Major Sixth", "Octave"]
    static var GUESSED_MESSAGES: [String] = [
        "Guessed Minor Third", "Guessed Major Third", "Perfect Forth", "Guessed Perfect Fifth", "Guessed Minor Sixth", "Guessed Major Sixth", "Guessed Octave"
    ]
    static let WELLCOME_MESSAGE = "Guess the interval"
}
