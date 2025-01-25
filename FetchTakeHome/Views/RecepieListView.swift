//
//  RecepieListView.swift
//  FetchTakeHome
//
//  Created by Brandon Derbidge on 1/19/25.
//

import SwiftUI

struct RecepieListView: View {
    @State var viewModel: RecepieListViewModel
    var body: some View {
        Group {
            if let recepies = viewModel.recepies {
                List {
                    if recepies.isEmpty {
                        Text("No recipes are available")
                    } else {
                        ForEach(recepies, id: \.uuid) { recepie in
                            CardView(recepie: recepie)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .task {
                                    await viewModel.saveImageToDisk(recepie: recepie)
                                }
                        }
                    }
                }.refreshable {
                    await viewModel.load()
                }.scrollIndicators(.hidden)
            } else {
                ProgressView()
            }
        } .task {
            await viewModel.load()
        }.banner(data: $viewModel.bannerData, show: $viewModel.showAlert)
    }
}
