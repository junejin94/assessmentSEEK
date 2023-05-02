//
//  JobListView.swift
//  assessmentSEEK
//
//  Created by Phua June Jin on 30/04/2023.
//

import SwiftUI

struct JobListView: View {
    @EnvironmentObject var viewModel: JobListViewModel

    @State var filterText: String = ""

    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ZStack {
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(CustomColor.background)
                            .ignoresSafeArea()
                            .frame(height: geo.size.height * 0.1)

                        ZStack {
                            List(0..<viewModel.jobList.count, id: \.self) { idx in
                                JobCellView()
                                    .modifier(CellPadding())
                                    .environmentObject(viewModel.jobList[idx])
                                    .onAppear {
                                        if idx == viewModel.jobList.count - 1 {
                                            Task { await viewModel.loadMore() }
                                        }
                                    }
                                    .background(
                                        NavigationLink("", destination: JobDetailsView()
                                            .environmentObject(viewModel.jobList[idx])).opacity(0)
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
        .onAppear {
            Task { await viewModel.loadData() }
        }
    }
}

struct JobListView_Previews: PreviewProvider {
    static var previews: some View {
        JobListView()
            .environmentObject(JobListViewModel())
    }
}
