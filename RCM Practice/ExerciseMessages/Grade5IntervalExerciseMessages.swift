//
//  Grade3IntervalExercise.swift
//  RCM Practice
//

import SwiftUI

struct Grade5IntervalExerciseMessages: ExerciseMessages {
    let PLAY_MESSAGE: String = "Play Sequence"
    let PLAYING_MESSAGE: String = "Playing the Sequence..."
    let GUESSES: [String] = ["Guess Minor Third", "Guess Major Third", "Perfect Forth", "Perfect Fifth", "Minor Sixth", "Major Sixth", "Octave"]
    let GUESSED_MESSAGES: [String] = [
        "Guessed Minor Third", "Guessed Major Third", "Perfect Forth", "Guessed Perfect Fifth", "Guessed Minor Sixth", "Guessed Major Sixth", "Guessed Octave"
    ]
    let WELLCOME_MESSAGE = "Guess the interval"
}
