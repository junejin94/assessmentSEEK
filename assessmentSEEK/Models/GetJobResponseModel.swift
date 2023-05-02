//
//  GetJobResponse.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 30/04/2023.
//

import Foundation

struct GetJobResponse: Codable {
    var page: Int
    var size: Int
    var hasNext: Bool
    var total: Int
    var jobs: [Job]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.page = try container.decode(Int.self, forKey: .page)
        self.size = try container.decode(Int.self, forKey: .size)
        self.hasNext = try container.decode(Bool.self, forKey: .hasNext)
        self.total = try container.decode(Int.self, forKey: .total)
        self.jobs = try container.decode([Job].self, forKey: .jobs)
    }
}
