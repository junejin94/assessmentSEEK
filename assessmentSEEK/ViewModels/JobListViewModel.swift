//
//  JobListViewModel.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 30/04/2023.
//

import Combine
import SwiftUI
import Foundation

actor JobListViewModel: ObservableObject {
    @MainActor @AppStorage("jwt", store: .standard) var token: String = ""

    @MainActor private var cancellables = [AnyCancellable]()

    @MainActor @Published private(set) var state: ViewState = .idle

    @MainActor @Published var jobList: [JobViewModel] = [] { didSet { setCancellables() } }
    @MainActor @Published var appliedJobList: [JobViewModel] = []

    @MainActor private var page: Int = 0
    @MainActor private var size: Int = 0
    @MainActor private var hasNext: Bool = false
    @MainActor private var total: Int = 0

    private var counter = 1

    @MainActor private func setCancellables() {
        cancellables = jobList.map { job in
            job.objectWillChange.sink { [weak self] in
                guard let self = self else { return }

                self.appliedJobList = jobList.filter({ $0.haveIApplied })
            }
        }
    }

    @MainActor func loadData() async {
        if jobList.isEmpty && state != .loading {
            await loadFromWeb()
        }
    }

    @MainActor func loadMore() async {
        // Mock pagination
        await loadFromWeb()
    }

    @MainActor func resetIfNecessary(previous: String) async {
        if (previous.isEmpty && !token.isEmpty) || (!previous.isEmpty && token.isEmpty) {
            await clearData()
        }
    }
    
    private func loadFromWeb() async {
        // Mock data fetch from web
        await MainActor.run { state = .loading }

        try? await Task.sleep(for: .seconds(2))

        var temp = [JobViewModel]()

        for i in counter...(counter + 9) {
            let ctr = String(i)

            let id = ctr
            let positionTitle = "Job Title \(ctr)"
            let company = Company(id: ctr, name: "Company \(ctr)")
            let description = "This is a very brief description of the role's day-to-day responsibilities."
            let min = Int.random(in: 0..<49999)
            let max = Int.random(in: min..<99999)
            let salaryRange = SalaryRange(min: min, max: max)
            let location = 1
            let industry = 1
            let haveIapplied = await token.isEmpty ? false : Bool.random()

            let job = Job(id: id, positionTitle: positionTitle, company: company, description: description, salaryRange: salaryRange, location: location, industry: industry, haveIApplied: haveIapplied)

            temp.append(JobViewModel(job: job))

            counter += 1
        }

        await appendJob(jobs: temp)
    }

    @MainActor private func appendJob(jobs: [JobViewModel]) async {
        jobList.append(contentsOf: jobs)

        state = .loaded
        appliedJobList = jobList.filter({ $0.haveIApplied })
    }

    private func resetCounter() async {
        counter = 1
    }

    @MainActor private func clearData() async {
        jobList.removeAll()

        await resetCounter()
        await loadData()
    }
}
