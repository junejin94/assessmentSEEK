//
//  LandingView.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 30/04/2023.
//

import SwiftUI

struct LandingView: View {
    @AppStorage("jwt", store: .standard) var token: String = ""

    @EnvironmentObject var jobViewModel: JobListViewModel
    @EnvironmentObject var profileViewModel: ProfileViewModel

    var body: some View {
        TabView {
            JobListView()
                .environmentObject(jobViewModel)
                .tabItem {
                    Label("landing_jobs", systemImage: "briefcase")
                }

            ProfileView()
                .environmentObject(profileViewModel)
                .tabItem {
                    Label("landing_my_profile", systemImage: "person.crop.circle.fill")
                }

            if !token.isEmpty {
                JobAppliedView()
                    .environmentObject(jobViewModel)
                    .badge(jobViewModel.appliedJobList.count)
                    .tabItem {
                        Label("landing_show_my_applications", systemImage: "tray.full")
                    }
            }
        }
        .onChange(of: token) { [oldValue = token] _ in
            Task { await jobViewModel.resetIfNecessary(previous: oldValue) }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
            .environmentObject(JobListViewModel())
            .environmentObject(ProfileViewModel())
    }
}
