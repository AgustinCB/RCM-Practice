//
//  CustomExercise+CoreDataProperties.swift
//  RCM Practice
//
//  Created by Agustin Chiappe Berrini on 2021-01-28.
//
//

import Foundation
import CoreData


extension CustomExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomExercise> {
        return NSFetchRequest<CustomExercise>(entityName: "CustomExercise")
    }

    @NSManaged public var id: String?
    @NSManaged public var exercisePlayerTypeId: Int16
    @NSManaged public var data: Data?
    @NSManaged public var historyData: Data?

    var exercisePlayerType: ExercisePlayerType {
        set {
            exercisePlayerTypeId = Int16(newValue.rawValue)
        }
        get {
            ExercisePlayerType.init(rawValue: UInt8(exercisePlayerTypeId))!
        }
    }
    
    var notes: [Note] {
        set {
            var newData = Data.init(capacity: newValue.count)
            newData.append(contentsOf: newValue.map({n in n.rawValue}))
            data = newData
        }
        get {
            Array(data!).map({n in Note.init(rawValue: n)!})
        }
    }
    
    var qualities: [ChordQuality] {
        set {
            var newData = Data.init(capacity: newValue.count)
            newData.append(contentsOf: newValue.map({n in n.rawValue}))
            data = newData
        }
        get {
            Array(data!).map({n in ChordQuality.init(rawValue: n)!})
        }
    }
    
    var history: [HistoryEntry] {
        set {
            var newData = Data.init(capacity: newValue.count * 2)
            newData.append(contentsOf: newValue.map({ n in n.toData() }).flatMap { $0 })
            historyData = newData
        }
        get {
            return HistoryEntry.fromData(data: historyData)
        }
    }
    
    func getIntervalExercise() -> ExerciseView<DynamicMessages, IntervalPlayer> {
        return self.exercisePlayerType.getExercise(self.notes, id!, action: { won, index in
            let newHistoryEntry = HistoryEntry(success: won, option: index)
            self.history = self.history + [newHistoryEntry]
        })
    }
    
    func getChordExercise() -> ExerciseView<DynamicMessages, ChordPlayer> {
        return self.exercisePlayerType.getExercise(self.qualities, id!, action: { won, index in
            let newHistoryEntry = HistoryEntry(success: won, option: index)
            self.history = self.history + [newHistoryEntry]
        })
    }
}

extension CustomExercise : Identifiable {

}
