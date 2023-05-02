//
//  ProfileChangeNameView.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 02/05/2023.
//

import SwiftUI

struct ProfileChangeNameView: View {
    @EnvironmentObject var viewModel: ProfileViewModel

    @State var username: String = ""
    @State var defaultMessage: String = String(localized: "profile_details_change_name_message")
    @State var message: String = ""
    @State var isPresented: Bool = false
    @State var isWarningPresented: Bool = false
    @State var isMessagePresented: Bool = false
    @State var displayMessage: Bool = false

    @FocusState private var nameIsFocused: Bool

    var body: some View {
        GeometryReader { geo in
            VStack {
                Rectangle()
                    .foregroundColor(CustomColor.background)
                    .ignoresSafeArea()
                    .frame(height: geo.size.height * 0.05)

                ZStack {
                    if isLoading(state: viewModel.state) {
                        ProgressView()
                            .scaleEffect(2)
                    }

                    VStack {
                        Spacer()

                        Text("profile_details_change_name_title")
                            .font(.largeTitle)
                            .foregroundColor(CustomColor.background)

                        Spacer()

                        TextField("profile_details_new_name", text: $username)
                            .focused($nameIsFocused)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding()
                            .overlay(Divider().frame(height: 1, alignment: .center).padding([.leading, .trailing], 16), alignment: .bottom)
                            .padding([.leading, .trailing], 16)

                        Spacer()

                        Button {
                            isWarningPresented = true
                            nameIsFocused = false
                        } label: {
                            Text("profile_change_name")
                                .foregroundColor(CustomColor.textReversed)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 5).fill(CustomColor.button).padding([.leading, .trailing], 32))
                        }
                        .alert("profile_details_change_name_message", isPresented: $isWarningPresented, actions: {
                            Button("profile_details_yes", role: .destructive, action: {
                                isWarningPresented = false

                                Task {
                                    do {
                                        let success = try await viewModel.changeName(newName: username)

                                        if success {
                                            isMessagePresented = true
                                            message = String(localized: "profile_details_success")
                                        }
                                    } catch let error {
                                        isMessagePresented = true
                                        message = error.localizedDescription
                                    }
                                }
                            })

                            Button("profile_details_no", role: .cancel) {
                                isWarningPresented = false
                            }
                        })
                        .alert(message, isPresented: $isMessagePresented, actions: {
                            Button("profile_details_ok", role: .cancel) {
                                isMessagePresented = false
                            }
                        })

                        Spacer()
                    }
                    .disabled(isLoading(state: viewModel.state))
                }
            }
        }
        .navigationTitle("profile_change_name")
    }
}

struct ProfileChangeNameView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileChangeNameView()
            .environmentObject(ProfileViewModel())
    }
}
