//
//  JobCellView.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 30/04/2023.
//

import SwiftUI

struct JobCellView: View {
    @EnvironmentObject var viewModel: JobViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(CustomColor.cardBackground)

            VStack (alignment: .leading, spacing: 4) {
                Spacer()

                HStack {
                    Text(viewModel.positionTitle)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(CustomColor.textPrimary)

                    if viewModel.haveIApplied {
                        Text("Applied")
                            .font(.caption2)
                            .foregroundColor(CustomColor.textReversed)
                            .padding(4)
                            .background(RoundedRectangle(cornerRadius: 5).fill(.green))
                    }
                }

                Text(viewModel.company)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(CustomColor.textSecondary)

                Text(viewModel.description)
                    .font(.system(size: 16))
                    .foregroundColor(CustomColor.textPrimary)
                    .modifier(TopDownSpacer())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
        }
        .opacity(viewModel.haveIApplied ? 0.5 : 1)
    }
}

struct JobCellView_Previews: PreviewProvider {
    static var previews: some View {
        JobCellView()
            .environmentObject(JobViewModel(job: Job(id: "1", positionTitle: "Job Title 1", company: Company(id: "1", name: "Company name 1"), description: "This is a very brief description of the role's day-to-day responsibilities.", salaryRange: SalaryRange(min: 0, max: 1), location: 1, industry: 1, haveIApplied: false)))
    }
}
