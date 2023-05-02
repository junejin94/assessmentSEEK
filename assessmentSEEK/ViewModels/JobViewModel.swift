//
//  JobViewModel.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 30/04/2023.
//

import SwiftUI
import Foundation

actor JobViewModel: ObservableObject {
    @MainActor private var job: Job

    @MainActor @Published private(set) var state: ViewState = .loaded

    init(job: Job) {
        self.job = job
    }

    @MainActor var id: String { return job.id }
    @MainActor var positionTitle: String { return job.positionTitle }
    @MainActor var company: String { return job.company.name }
    @MainActor var description: String { return job.description }
    @MainActor var salaryRange: String { return getSalaryRange(salaryRange: job.salaryRange, location: job.location) }
    @MainActor var location: String { return getLocation(location: job.location) }
    @MainActor var industry: String { return getIndustry(industry: job.industry) }
    @MainActor var haveIApplied: Bool { return job.haveIApplied }

    func apply() async -> Bool {
        // Mock apply
        await MainActor.run { state = .loading }

        try? await Task.sleep(for: .seconds(2))

        await MainActor.run {
            state = .loaded
            job.haveIApplied = true

            self.objectWillChange.send()
        }

        return true
    }
}
