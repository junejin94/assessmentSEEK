//
//  ProfileView.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 02/05/2023.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var viewModel: ProfileViewModel

    @State private var isPresented: Bool = false

    var body: some View {
        GeometryReader { geo in
            NavigationView {
                ZStack {
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(CustomColor.background)
                            .ignoresSafeArea()
                            .frame(height: geo.size.height * 0.1)

                        List {
                            if viewModel.token.isEmpty {
                                NavigationLink {
                                    LoginView()
                                        .environmentObject(LoginViewModel())
                                } label: {
                                    Text("profile_login")
                                }
                            } else {
                                NavigationLink {
                                    ProfileDetailsView()
                                        .environmentObject(ProfileViewModel())
                                } label: {
                                    Text("profile_my_profile")
                                }

                                NavigationLink {
                                    ProfileChangePasswordView()
                                        .environmentObject(ProfileChangePasswordViewModel())
                                } label: {
                                    Text("profile_reset_password")
                                }

                                Button {
                                    isPresented = true
                                } label: {
                                    Text("profile_logout")
                                }
                                .alert("profile_logout_message", isPresented: $isPresented) {
                                    Button("profile_yes", role: .destructive) {
                                        isPresented = false

                                        logOut()
                                    }

                                    Button("profile_no", role: .cancel) {
                                        isPresented = false
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        .scrollContentBackground(.hidden)
                        .background(CustomColor.backgroundSecondary)
                    }
                }
            }
        }
        .disabled(isLoading(state: viewModel.state))
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ProfileViewModel())
    }
}
