//
//  ProfileDetailsView.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 02/05/2023.
//

import SwiftUI

struct ProfileDetailsView: View {
    @EnvironmentObject var viewModel: ProfileViewModel

    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(CustomColor.background)
                        .ignoresSafeArea()
                        .frame(height: geo.size.height * 0.05)

                    List {
                        NavigationLink(destination: ProfileChangeNameView()
                            .environmentObject(viewModel)) {
                                HStack {
                                    Text("profile_name")

                                    Spacer()

                                    Text(viewModel.name)
                                        .foregroundColor(CustomColor.textSecondary)
                                }
                        }
                    }
                }
            }
        }
        .navigationTitle("profile_details_my_profile")
    }
}

struct ProfileDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailsView()
            .environmentObject(ProfileViewModel())
    }
}
