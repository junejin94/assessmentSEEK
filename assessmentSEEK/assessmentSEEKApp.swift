//
//  assessmentSEEKApp.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 29/04/2023.
//

import SwiftUI

@main
struct assessmentSEEKApp: App {
    var body: some Scene {
        WindowGroup {
            LandingView()
                .environmentObject(JobListViewModel())
                .environmentObject(ProfileViewModel())
        }
    }
}

