//
//  Grade7IntervalExerciseMessages.swift
//  RCM Practice
//

struct Grade7IntervalExerciseMessages: ExerciseMessages {
    static let PLAY_MESSAGE: String = "Play Sequence"
    static let PLAYING_MESSAGE: String = "Playing the Sequence..."
    static var GUESSES: [String] = ["Minor Second", "Major Second", "Minor Third", "Major Third", "Perfect Forth", "Perfect Fifth", "Minor Sixth", "Major Sixth", "Minor Seventh", "Major Sevent", "Octave"]
    static var GUESSED_MESSAGES: [String] = [
        "Guessed Minor Second", "Guessed Major Second", "Guessed Minor Third", "Guessed Major Third", "Perfect Forth",
        "Guessed Perfect Fifth", "Guessed Minor Sixth", "Guessed Major Sixth", "Guessed Minor Seventh", "Guessed Major Sevent", "Guessed Octave"
    ]
    static let WELLCOME_MESSAGE = "Guess the interval"
}
