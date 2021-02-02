//
//  Grade6IntervalExerciseMessages.swift
//  RCM Practice
//

struct Grade6IntervalExerciseMessages: ExerciseMessages {
    let PLAY_MESSAGE: String = "Play Sequence"
    let PLAYING_MESSAGE: String = "Playing the Sequence..."
    let GUESSES: [String] = ["Minor Second", "Major Second", "Minor Third", "Major Third", "Perfect Forth", "Perfect Fifth", "Minor Sixth", "Major Sixth", "Octave"]
    let GUESSED_MESSAGES: [String] = [
        "Guessed Minor Second", "Guessed Major Second", "Guessed Minor Third", "Guessed Major Third", "Perfect Forth",
        "Guessed Perfect Fifth", "Guessed Minor Sixth", "Guessed Major Sixth", "Guessed Octave"
    ]
    let WELLCOME_MESSAGE = "Guess the interval"
}
