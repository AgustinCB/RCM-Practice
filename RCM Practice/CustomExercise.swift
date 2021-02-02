//
//  CustomExercise+CoreDataProperties.swift
//  RCM Practice
//
//  Created by Agustin Chiappe Berrini on 2021-01-28.
//
//

import Foundation
import CoreData

/*
@objc(CustomExercise)
public class CustomExercise: NSManagedObject {

}

extension CustomExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomExercise> {
        return NSFetchRequest<CustomExercise>(entityName: "CustomExercise")
    }

    @NSManaged public var id: String?
    @NSManaged public var intervalPlayerTypeId: Int16
    @NSManaged public var noteIds: Data?
    
    var intervalPlayerType: IntervalPlayerType {
        set {
            intervalPlayerTypeId = newValue.rawValue
        }
        get {
            IntervalPlayerType.init(rawValue: intervalPlayerTypeId)!
        }
    }
    
    var notes: [Note] {
        set {
            noteIds = newValue.map({n in n.rawValue})
        }
        get {
            noteIds.map({n in Note.init(rawValue: n)!})
        }
    }

}

extension CustomExercise : Identifiable {

}
*/
