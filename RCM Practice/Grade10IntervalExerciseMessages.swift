//
//  Grade10IntervalExerciseMessages.swift
//  RCM Practice
//

struct Grade10IntervalExerciseMessages: ExerciseMessages {
    let PLAY_MESSAGE: String = "Play Sequence"
    let PLAYING_MESSAGE: String = "Playing the Sequence..."
    let GUESSES: [String] = ["Minor Second", "Major Second", "Minor Third", "Major Third", "Perfect Forth", "Tritone", "Perfect Fifth", "Minor Sixth", "Major Sixth", "Minor Seventh", "Major Sevent", "Octave", "Minor Nineth", "Major Nineth"]
    let GUESSED_MESSAGES: [String] = [
        "Guessed Minor Second", "Guessed Major Second", "Guessed Minor Third", "Guessed Major Third", "Perfect Forth", "Guessed Tritone",
        "Guessed Perfect Fifth", "Guessed Minor Sixth", "Guessed Major Sixth", "Guessed Minor Seventh", "Guessed Major Sevent", "Guessed Octave",
        "Guessed Minor Nineth", "Guessed Major Nineth"
    ]
    let WELLCOME_MESSAGE = "Guess the interval"
}
