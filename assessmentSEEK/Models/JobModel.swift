//
//  JobModel.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 30/04/2023.
//

import Foundation

struct Job: Codable {
    var id: String
    var positionTitle: String
    var company: Company
    var description: String
    var salaryRange: SalaryRange
    var location: Int
    var industry: Int
    var haveIApplied: Bool

    init(id: String, positionTitle: String, company: Company, description: String, salaryRange: SalaryRange, location: Int, industry: Int, haveIApplied: Bool) {
        self.id = id
        self.positionTitle = positionTitle
        self.company = company
        self.description = description
        self.salaryRange = salaryRange
        self.location = location
        self.industry = industry
        self.haveIApplied = haveIApplied
    }
}
