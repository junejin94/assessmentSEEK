//
//  JobAppliedView.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 01/05/2023.
//

import SwiftUI

struct JobAppliedView: View {
    @EnvironmentObject var viewModel: JobListViewModel

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ZStack {
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(CustomColor.background)
                            .ignoresSafeArea()
                            .frame(height: geo.size.height * 0.1)
     
                        if isLoading(state: viewModel.state) {
                            ProgressView()
                                .scaleEffect(2)
                                .modifier(TopDownSpacer())
                        } else if viewModel.appliedJobList.count == 0 {
                            VStack {
                                Spacer()

                                Image(systemName: "bin.xmark")
                                    .font(.system(size: 50))

                                Spacer()
                                    .frame(height: 8)

                                Text("job_applied_none")

                                Spacer()
                            }
                        } else {
                            ZStack {
                                List(0..<viewModel.appliedJobList.count, id: \.self) { idx in
                                    JobCellView()
                                        .modifier(CellPadding())
                                        .environmentObject(viewModel.appliedJobList[idx])
                                        .background(
                                            NavigationLink("", destination: JobDetailsView()
                                                .environmentObject(viewModel.appliedJobList[idx])).opacity(0)
                                        )
                                }
                                .scrollIndicators(.hidden)
                                .scrollContentBackground(.hidden)
                                .background(CustomColor.backgroundSecondary)

                                if isLoading(state: viewModel.state) {
                                    ProgressView()
                                        .scaleEffect(2)
                                }
                            }
                        }
                    }
                }
            }
            .disabled(isLoading(state: viewModel.state))
        }
    }
}

struct JobAppliedView_Previews: PreviewProvider {
    static var previews: some View {
        JobAppliedView()
            .environmentObject(JobListViewModel())
    }
}
