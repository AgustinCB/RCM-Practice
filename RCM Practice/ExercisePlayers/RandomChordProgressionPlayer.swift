//
//  RandomChordProgressionPlayer.swift
//  RCM Practice
//

import Foundation

class RandomChordProgressionPlayer: ExercisePlayer {
    typealias G = [AbstractChord]
    
    var majorChordOptions: [AbstractChord]
    var minorChordOptions: [AbstractChord]
    var chordOptions: [AbstractChord] = []
    var midiPlayer: MIDIPlayer! = MIDIPlayer()
    var chordProgression: [AbstractChord]!
    var isMajor: Bool = false
    
    required convenience init() {
        self.init([AbstractChord.init(note: Note.Root, chordQuality: .major), AbstractChord.init(note: Note.PerfectForth, chordQuality: .major), AbstractChord.init(note: Note.PerfectFifth, chordQuality: .major), AbstractChord.init(note: Note.MajorSixth, chordQuality: .minor)],
                  [AbstractChord.init(note: Note.Root, chordQuality: .minor), AbstractChord.init(note: Note.PerfectForth, chordQuality: .minor), AbstractChord.init(note: Note.PerfectFifth, chordQuality: .major), AbstractChord.init(note: Note.MinorSixth, chordQuality: .major)])
    }
    
    init(_ majorChordOptions: [AbstractChord], _ minorChordOptions: [AbstractChord]) {
        self.majorChordOptions = majorChordOptions
        self.minorChordOptions = minorChordOptions
        self.randomReset()
    }
    
    func checkGuess(_ guess: G) -> Bool {
        for (guessChord, progressionChord) in zip(guess, chordProgression) {
            if guessChord != progressionChord {
                return false
            }
        }
        return true
    }
    
    func guess(_ guessIndex: Int) -> G {
        fatalError("Doesn't make sense here!")
    }
    
    func randomReset() {
        let root = UInt8.random(in: 60...71)
        self.isMajor = [true, false].randomElement()!
        self.chordOptions = isMajor ? majorChordOptions : minorChordOptions
        let firstChord: AbstractChord = isMajor ? AbstractChord.init(note: Note.Root, chordQuality: .major) : AbstractChord.init(note: Note.Root, chordQuality: .minor)
        chordProgression = [firstChord] + chordOptions.shuffled()[0...2]
        let quality = firstChord.chordQuality
        self.setChord(Chord.init(chordQuality: quality, chordNotes: quality.createChordNotes(root: root), rootNote: root))
    }

    func play() {
        self.midiPlayer.play()
    }
    
    fileprivate func addChordEvents(_ previousChord: Chord, _ chordEvents: inout [UInt8]) {
        var chordOffEvents: [UInt8] = []
        var chordOnEvents: [UInt8] = []
        for (index, note) in previousChord.chordNotes.enumerated() {
            let chordTimeLapsus: UInt8 = index == 0 ? 0x02 : 0x00
            
            /*
             Expected sum of chordOnEvents and chordOffEvents
             0x00, 0x90, root, 0x60
             0x00, 0x90, third, 0x60
             0x00, 0x90, fifth, 0x60
             0x02, 0x80, root, 0x60
             0x00, 0x80, third, 0x60
             0x00, 0x80, fifth, 0x60
             
             Note that the first byte of every MIDI event is the ticks from the last event
             And not the ticks from the beginning of the sequence.
             */
            chordOnEvents += [
                0x00, 0x90, note, 0x60, // Note on on the chord
            ]
            chordOffEvents += [
                chordTimeLapsus, 0x80, note, 0x00 // Note off on the chord
            ]
        }
        chordEvents += chordOnEvents + [
            0x00, 0x90, previousChord.chordNotes[0] - 12, 0x60,
        ] + chordOffEvents + [
            0x00, 0x80, previousChord.chordNotes[0] - 12, 0x60,
        ]
    }
    
    func setChord(_ chord: Chord) {
        var chordEvents: [UInt8] = []
        
        var previousChord = chord
        for (i, nextAbstractChord) in chordProgression[1...chordProgression.count-1].enumerated() {
            addChordEvents(previousChord, &chordEvents)
            let transition = ChordTransition.init(from: chordProgression[i], to: nextAbstractChord)
            previousChord = transition.performTransition(chordFrom: previousChord)
        }
        addChordEvents(previousChord, &chordEvents)
        
        self.midiPlayer.setSequence(chordEvents)
    }
}

class RandomOrCadential64ChordProgressionPlayer : RandomChordProgressionPlayer {
    static let CADENTIAL_CHORD_PROGRESSION = [
        AbstractChord.init(note: .Root, chordQuality: .major),
        AbstractChord.init(note: .PerfectForth, chordQuality: .major),
        AbstractChord.init(note: .PerfectFifth, chordQuality: .fourSix),
        AbstractChord.init(note: .PerfectFifth, chordQuality: .major),
        AbstractChord.init(note: .Root, chordQuality: .major)
    ]
    var isCadential: Bool = false
    
    override func randomReset() {
        isCadential = [true, false].randomElement()!
        let root = UInt8.random(in: 60...71)
        self.isMajor = [true, false].randomElement()!
        self.chordOptions = isMajor ? majorChordOptions : minorChordOptions
        let firstChord: AbstractChord = isMajor ? AbstractChord.init(note: Note.Root, chordQuality: .major) : AbstractChord.init(note: Note.Root, chordQuality: .minor)
        if isCadential {
            chordProgression = RandomOrCadential64ChordProgressionPlayer.CADENTIAL_CHORD_PROGRESSION
        } else {
            chordProgression = [firstChord] + chordOptions.shuffled()[0...3]
        }
        let quality = isCadential ?
            .major :
            firstChord.chordQuality
        let initialChord = isCadential ?
            Chord.init(chordQuality: .major, chordNotes: ChordQuality.major.createChordNotes(root: root), rootNote: root) :
            Chord.init(chordQuality: quality, chordNotes: quality.createChordNotes(root: root), rootNote: root)
        print(isCadential, chordProgression)
        self.setChord(initialChord)
    }
}
