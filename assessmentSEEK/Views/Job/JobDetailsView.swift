//
//  JobDetailsView.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 01/05/2023.
//

import SwiftUI

struct JobDetailsView: View {
    @AppStorage("jwt", store: .standard) var token: String = ""

    @EnvironmentObject var viewModel: JobViewModel

    @State var isPresented: Bool = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                if isLoading(state: viewModel.state) {
                    ProgressView()
                        .scaleEffect(2)
                }

                VStack(alignment: .leading, spacing: 0) {
                    Rectangle()
                        .foregroundColor(CustomColor.background)
                        .ignoresSafeArea()
                        .frame(height: geo.size.height * 0.05)

                    Spacer()

                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(viewModel.positionTitle)
                                    .font(.largeTitle)
                                    .bold()

                                if viewModel.haveIApplied {
                                    Text("job_details_applied")
                                        .font(.caption2)
                                        .foregroundColor(CustomColor.textReversed)
                                        .padding(4)
                                        .background(RoundedRectangle(cornerRadius: 5).fill(.green))
                                }
                            }

                            Text(viewModel.company)

                            Spacer()
                                .frame(height: 16)

                            Text(viewModel.location)
                                .bold()

                            Text(viewModel.salaryRange)
                                .bold()

                            Spacer()
                                .frame(height: 24)

                            Text("job_details_description")
                                .bold()

                            Spacer()

                            Text(viewModel.description)
                        }
                        .foregroundColor(CustomColor.textPrimary)
                        .padding([.leading, .trailing], 16)
                    }
                    .frame(maxWidth: .infinity)

                    Button(action: {
                        if token.isEmpty {
                            isPresented = true
                        } else {
                            Task { await viewModel.apply() }
                        }
                    }) {
                        Text(viewModel.haveIApplied ? "job_details_applied" : "job_details_apply")
                            .foregroundColor(CustomColor.textReversed)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(RoundedRectangle(cornerRadius: 5).fill(viewModel.haveIApplied ? CustomColor.textSecondary : CustomColor.button).padding([.leading, .trailing], 16))
                            .disabled(viewModel.haveIApplied)
                    }
                    .disabled(viewModel.haveIApplied)
                    .padding([.top], 16)
                    .navigationDestination(isPresented: $isPresented) {
                        LoginView()
                            .environmentObject(LoginViewModel())
                    }

                    Spacer()
                }
            }
        }
    }
}

struct JobDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        JobDetailsView()
            .environmentObject(JobViewModel(job: Job(id: "1", positionTitle: "Job Title 1", company:Company(id: "1", name: "Company name 1"), description: "This is a very brief description of the role's day-to-day responsibilities.", salaryRange: SalaryRange(min: 0, max: 1), location: 1, industry: 1, haveIApplied: false)))
    }
}
