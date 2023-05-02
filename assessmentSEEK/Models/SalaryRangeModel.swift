//
//  SalaryRangeModel.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 30/04/2023.
//

import Foundation

struct SalaryRange: Codable {
    var min: Int
    var max: Int

    init(min: Int, max: Int) {
        self.min = min
        self.max = max
    }
}
