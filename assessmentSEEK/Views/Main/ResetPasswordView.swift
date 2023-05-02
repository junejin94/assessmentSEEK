//
//  ResetPasswordView.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 30/04/2023.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var viewModel: ResetPasswordViewModel

    @State var username: String = ""
    @State var errorMessage: String = ""
    @State var isPresented: Bool = false

    var body: some View {
        ZStack {
            if isLoading(state: viewModel.state) {
                ProgressView()
                    .scaleEffect(2)
            }

            VStack {
                Text("forgot_forgot_password")
                    .font(.largeTitle)
                    .modifier(TopDownSpacer())

                Text("forgot_description")
                    .multilineTextAlignment(.center)
                    .foregroundColor(CustomColor.textPrimary)
                    .modifier(TopDownSpacer())

                TextField("forgot_email_address", text: $username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding()
                    .overlay(Divider().frame(height: 1, alignment: .center), alignment: .bottom)
                    .padding([.bottom], 16)

                Button {
                    Task {
                        do {
                            let success = try await viewModel.sendEmail(username: username)

                            if success {
                                errorMessage = String(localized: "forgot_success_message")
                            }
                        } catch let error {
                            errorMessage = error.localizedDescription
                        }

                        isPresented = true
                    }
                } label: {
                    Text("forgot_button")
                        .foregroundColor(CustomColor.textReversed)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 5).fill(CustomColor.button))
                }
                .alert(errorMessage, isPresented: $isPresented) {
                    Button("OK", role: .cancel) {
                        isPresented = false
                    }
                }

                Spacer()

                Text("forgot_info")
                    .multilineTextAlignment(.center)
                    .foregroundColor(CustomColor.textPrimary)
            }
            .padding([.leading, .trailing], 16)
            .disabled(isLoading(state: viewModel.state))
        }
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
            .environmentObject(ResetPasswordViewModel())
    }
}
