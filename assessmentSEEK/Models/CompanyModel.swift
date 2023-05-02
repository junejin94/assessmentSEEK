//
//  CompanyModel.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 30/04/2023.
//

import Foundation

struct Company: Codable {
    var id: String
    var name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
