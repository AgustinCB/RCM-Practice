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
    @NSManaged public var intervalPlayerTypeId: Int16
    @NSManaged public var noteIds: Data?

    var intervalPlayerType: IntervalPlayerType {
        set {
            intervalPlayerTypeId = Int16(newValue.rawValue)
        }
        get {
            IntervalPlayerType.init(rawValue: UInt8(intervalPlayerTypeId))!
        }
    }
    
    var notes: [Note] {
        set {
            var newData = Data.init(capacity: newValue.count)
            newData.append(contentsOf: newValue.map({n in n.rawValue}))
            noteIds = newData
        }
        get {
            Array(noteIds!).map({n in Note.init(rawValue: n)!})
        }
    }
    
    func getExercise() -> ExerciseView<DynamicMessages, IntervalPlayer> {
        return self.intervalPlayerType.getExercise(self.notes, id!)
    }
}

extension CustomExercise : Identifiable {

}
