//
//  CharacterDetailView.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez.
//

import SwiftUI
import Combine

struct CharacterDetailView: View {
    
    @ObservedObject var input: CharacterDetailViewModel.Input
    @ObservedObject var output: CharacterDetailViewModel.Output
    
    private let cancelBag = CancelBag()
    
    private let initTrigger = PassthroughSubject<Void, Never>()
    
    enum ViewState {
        case loading
        case loaded(character: Character, episodes: [Episode])
    }
    
    var body: some View {
        BaseView(output: output) {
            switch output.viewState {
            case .loading:
                LoaderView()
            case .loaded(let character, let episodes):
                ScrollView {
                    LazyVStack {
                        VStack {
                            ZStack(alignment: .bottomTrailing) {
                                CustomAsyncImage(url: character.imageUrl, size: 150)
                                    .clipShape(Circle())
                                    .padding(.top)
                                if character.status == .unknown {
                                    Image(systemName: "questionmark.circle.fill")
                                        .foregroundStyle(Color.disabled)
                                        .frame(width: 20, height:  20)
                                        .padding([.trailing, .bottom], 10)
                                } else {
                                    Circle()
                                        .fill(character.status == .alive ? Color.green : Color.red)
                                        .frame(width: 20, height:  20)
                                        .padding([.trailing, .bottom], 10)
                                }
                            }
                            Text(character.name)
                                .font(.title)
                                .bold()
                                .padding(.bottom)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.accent.opacity(0.2))
                        
                        HStack {
                            Spacer()
                            VStack(alignment: .leading, spacing: 20) {
                                InfoView(infoLabel: "SpeciesLabel", valueLabel: character.species)
                                InfoView(infoLabel: "GenderLabel", valueLabel: character.gender)
                            }
                            Spacer()
                            VStack(alignment: .leading, spacing: 20) {
                                InfoView(infoLabel: "OriginLabel", valueLabel: character.origin.name)
                                InfoView(infoLabel: "LocationLabel", valueLabel: character.location.name)
                            }
                            Spacer()
                        }
                        .padding()
                        
                        Section {
                            ForEach(episodes, id: \.id) { episode in
                                EpisodeView(episode: episode)
                            }
                            .padding(.horizontal)
                        } header: {
                            HStack {
                                Text("EpisodesTitle")
                                    .font(.title2)
                                    .bold()
                                    .padding()
                                Spacer()
                            }
                        }

                    }
                }
            }
            output.addNavigations
        }
    }
    
    init(viewModel: CharacterDetailViewModel) {
        let input = CharacterDetailViewModel.Input(initTrigger: initTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
        initTrigger.send()
    }
}

struct InfoView: View {
    let infoLabel: LocalizedStringResource
    let valueLabel: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(infoLabel)
                .font(.caption)
                .foregroundStyle(Color.main.opacity(0.8))
            Text(valueLabel)
                .font(.callout)
        }
    }
}

#Preview {
    DefaultCharacterDetailAssembler
        .resolve(dependencies:
                    CharacterDetailDependencies(character:
                                                    Character(id: 1,
                                                              name: "Rick",
                                                              status: .alive,
                                                              species: "",
                                                              gender: "",
                                                              origin: SimpleLocation(name: "Origin location",
                                                                                     url: ""),
                                                              location: SimpleLocation(name: "Current location",
                                                                                       url: ""),
                                                              imageUrl: "",
                                                              episodesUrls: [""],
                                                              created: Date())))
}
