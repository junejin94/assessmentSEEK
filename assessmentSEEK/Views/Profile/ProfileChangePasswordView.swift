//
//  ProfileChangePasswordView.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 02/05/2023.
//

import SwiftUI

struct ProfileChangePasswordView: View {
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var viewModel: ProfileChangePasswordViewModel

    @State var oldPassword: String = ""
    @State var newPassword: String = ""
    @State var errorMessage: String = ""
    @State var showOldPassword: Bool = false
    @State var showNewpassword: Bool = false
    @State var isPresented: Bool = false
    @State var requiredLogin: Bool = false

    var body: some View {
        ZStack {
            if isLoading(state: viewModel.state) {
                ProgressView()
                    .scaleEffect(2)
            }

            VStack(spacing: 0) {
                Text("change_password_title")
                    .font(.largeTitle)
                    .modifier(TopDownSpacer())

                Spacer()

                ZStack(alignment: .trailing) {
                    TextField("change_password_old_password", text: $oldPassword)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .textContentType(.password)
                        .opacity(showOldPassword ? 1 : 0)
                        .overlay(Divider().frame(height: 1, alignment: .center).padding([.leading, .trailing], 16), alignment: .bottom)

                    SecureField("change_password_old_password", text: $oldPassword)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .textContentType(.password)
                        .opacity(showOldPassword ? 0 : 1)
                        .overlay(Divider().frame(height: 1, alignment: .center).padding([.leading, .trailing], 16), alignment: .bottom)

                    Button(action: {
                        showOldPassword.toggle()
                    }, label: {
                        viewModel.togglePasswordImage(show: showOldPassword)
                    })
                }

                ZStack(alignment: .trailing) {
                    TextField("change_password_new_password", text: $newPassword)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .textContentType(.password)
                        .opacity(showNewpassword ? 1 : 0)
                        .overlay(Divider().frame(height: 1, alignment: .center).padding([.leading, .trailing], 16), alignment: .bottom)

                    SecureField("change_password_new_password", text: $newPassword)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .textContentType(.password)
                        .opacity(showNewpassword ? 0 : 1)
                        .overlay(Divider().frame(height: 1, alignment: .center).padding([.leading, .trailing], 16), alignment: .bottom)

                    Button(action: {
                        showNewpassword.toggle()
                    }, label: {
                        viewModel.togglePasswordImage(show: showNewpassword)
                    })
                }

                Button {
                    Task {
                        do {
                            let success = try await viewModel.changePassword(oldPassword: oldPassword, newPassword: newPassword)

                            if success {
                                logOut()

                                requiredLogin = true
                                errorMessage = String(localized: "change_password_success_message")
                            }
                        } catch let error {
                            errorMessage = error.localizedDescription
                        }

                        isPresented = true
                    }
                } label: {
                    Text("change_password_button")
                        .foregroundColor(CustomColor.textReversed)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 5).fill(CustomColor.button))
                }
                .modifier(TopDownSpacer())
                .alert(errorMessage, isPresented: $isPresented) {
                    Button("OK", role: .cancel) {
                        isPresented = false

                        if requiredLogin {
                            dismiss()
                        }
                    }
                }
            }
            .padding([.leading, .trailing], 16)
            .disabled(isLoading(state: viewModel.state))
        }
    }
}

struct ProfileChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileChangePasswordView()
            .environmentObject(ProfileChangePasswordViewModel())
    }
}
