//
//  History.swift
//  RCM Practice
//

import Foundation

struct HistoryEntry {
    let success: Bool
    let option: UInt8

    init(data: [UInt8]) {
        success = data[0] > 0 ? true : false
        option = data[1]
    }
    init(success: Bool, option: UInt8) {
        self.success = success
        self.option = option
    }
}

extension HistoryEntry {
    static func fromData(data: Data?) -> [HistoryEntry] {
        var history: [HistoryEntry] = []
        for index in 0..<(data ?? Data.init()).count / 2 {
            history.append(HistoryEntry.init(data: [data![index * 2], data![index * 2 + 1]]))
        }
        return history
    }
    func toData() -> [UInt8] {
        return [
            success ? 1 : 0, option
        ]
    }
}
