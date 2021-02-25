//
//  CenteredContent.swift
//  RCM Practice
//

import SwiftUI

struct HistoryRowView: View {
    let option: String
    let successRate: Float32

    var body: some View {
        HStack{
            Text(option)
            Spacer()
            Text(String(successRate * 100) + "%")
            .bold()
        }
    }
}

struct HistoryView: View {
    let historyEntries: [HistoryEntry]
    let historyOptions: [String]

    func createSuccessRateArray() -> [Float32] {
        var totalEntriesArray = historyOptions.map({ _ in 0 })
        var totalSuccessesEntriesArray = historyOptions.map({ _ in 0 })
        var successRateArray = historyOptions.map({ _ in Float32(0) })
        for historyEntry in historyEntries {
            let historyEntryIndex = Int(historyEntry.option)
            totalEntriesArray[historyEntryIndex] += 1
            if historyEntry.success {
                totalSuccessesEntriesArray[historyEntryIndex] += 1
            }
            successRateArray[historyEntryIndex] = Float32(totalSuccessesEntriesArray[historyEntryIndex]) / Float32(totalEntriesArray[historyEntryIndex])
        }

        return successRateArray
    }

    var body: some View {
        List {
            Section(header: Text("Success History")) {
                ForEach(Array(zip(historyOptions, createSuccessRateArray())), id: \.0) { option, successRate in
                    HistoryRowView(option: option, successRate: successRate)
                }
            }
        }.listStyle(InsetGroupedListStyle())
    }
}
