//
//  EpisodesView.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez.
//

import SwiftUI
import Combine

struct EpisodesView: View {
    
    @ObservedObject var input: EpisodesViewModel.Input
    @ObservedObject var output: EpisodesViewModel.Output
    
    private let cancelBag = CancelBag()
    
    private let initTrigger = PassthroughSubject<Void, Never>()
    private let loadMoreTrigger = PassthroughSubject<Void, Never>()
    
    var body: some View {
        BaseView(output: output) {
            if output.showError {
                VStack {
                    Spacer()
                    Text("EpisodesErrorTitle")
                        .font(.headline)
                    Text("EpisodesErrorMessage")
                        .font(.caption)
                    Button("RetryButton") {
                        output.showError = false
                        initTrigger.send()
                    }
                    .padding()
                    Spacer()
                }
                .padding()
            } else if output.isLoading {
                LoaderView()
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10, pinnedViews: [.sectionHeaders]) {
                        ForEach(output.seasons, id: \.seasonNumber) { season in
                            Section {
                                ForEach(season.episodes, id: \.id) { episode in
                                    EpisodeView(episode: episode)
                                }
                                .padding(.horizontal)
                            } header: {
                                HStack {
                                    Text("Season \(season.seasonNumber)")
                                        .font(.title)
                                        .bold()
                                        .padding()
                                    Spacer()
                                }
                                .background(Color(.background))
                            }
                        }
                        LastRowView(canLoadMore: $output.canLoadMore)
                            .onAppear {
                                loadMoreTrigger.send()
                            }
                    }
                }
            }
            output.addNavigations
        }
        .navigationTitle("TabItemEpisodes")
    }
    
    init(viewModel: EpisodesViewModel) {
        let input = EpisodesViewModel.Input(initTrigger: initTrigger.asDriver(),
                                            loadMoreTrigger: loadMoreTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
        initTrigger.send()
    }
}

struct EpisodeView: View {
    let episode: Episode
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text("#\(episode.id) " + episode.name)
                    .font(.callout)
                    .bold()
                    .foregroundStyle(Color(.background))
                Spacer()
                Text(episode.airDate.toString)
                    .font(.caption)
                    .foregroundStyle(Color(.background).opacity(0.6))
            }
            Text("Number of characters: \(episode.charactersUrls.count)")
                .font(.caption)
                .foregroundStyle(Color(.background).opacity(0.6))
        }
        .padding()
        .background(Color(.secondaryOption))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    NavigationStack {
        DefaultEpisodesAssembler.resolve()
    }
}

#Preview {
    EpisodeView(episode: Episode(id: 1,
                                 name: "Pilot",
                                 airDate: Date(),
                                 episodeCode: "S01E01",
                                 charactersUrls: [""],
                                 url: "",
                                 created: Date()))
}
