//
//  LoginView.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 29/04/2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel

    @State var username: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    @State var isPresented: Bool = false
    @State var errorMessage: String = ""

    var body: some View {
        ZStack {
            if isLoading(state: viewModel.state) {
                ProgressView()
                    .scaleEffect(2)
            }

            VStack {
                Text("login_main_title")
                    .font(.largeTitle)
                    .foregroundColor(CustomColor.background)
                    .modifier(TopDownSpacer())

                VStack(alignment: .leading) {
                    TextField("login_email_address", text: $username)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .overlay(Divider().frame(height: 1, alignment: .center).padding([.leading, .trailing], 16), alignment: .bottom)

                    ZStack(alignment: .trailing) {
                        TextField("login_password", text: $password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .textContentType(.password)
                            .opacity(showPassword ? 1 : 0)
                            .overlay(Divider().frame(height: 1, alignment: .center).padding([.leading, .trailing], 16), alignment: .bottom)

                        SecureField("login_password", text: $password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding()
                            .textContentType(.password)
                            .opacity(showPassword ? 0 : 1)
                            .overlay(Divider().frame(height: 1, alignment: .center).padding([.leading, .trailing], 16), alignment: .bottom)

                        Button(action: {
                            showPassword.toggle()
                        }, label: {
                            viewModel.togglePasswordImage(show: showPassword)
                        })
                    }
                }
                .padding([.leading, .trailing], 16)

                Spacer()

                Button {
                    Task {
                        do {
                            let success = try await viewModel.login(username: username, password: password)

                            if success {
                                Navigation.popToRootView()
                            }
                        } catch let error {
                            isPresented = true
                            errorMessage = error.localizedDescription
                        }
                    }
                } label: {
                    Text("login_login")
                        .foregroundColor(CustomColor.textReversed)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 5).fill(CustomColor.button).padding([.leading, .trailing], 32))
                }
                .alert(errorMessage, isPresented: $isPresented) {
                    Button("OK", role: .cancel) {
                        isPresented = false
                    }
                }

                Button(action: {} ) {
                    NavigationLink(destination: ResetPasswordView()
                        .environmentObject(ResetPasswordViewModel())) {
                        Text("login_forgot_password")
                            .foregroundColor(CustomColor.textPrimary)
                    }
                }
                .padding([.top], 16)

                Spacer()
            }
            .disabled(isLoading(state: viewModel.state))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginViewModel())
            //.previewDevice("iPhone SE (3rd generation)")
    }
}
