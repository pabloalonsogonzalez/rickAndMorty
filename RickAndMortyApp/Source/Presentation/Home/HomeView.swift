//
//  HomeView.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @ObservedObject var input: HomeViewModel.Input
    @ObservedObject var output: HomeViewModel.Output
    
    private let cancelBag = CancelBag()
    
    private let initTrigger = PassthroughSubject<Void, Never>()
    private let loadMoreTrigger = PassthroughSubject<Void, Never>()
    private let characterDetailTrigger = PassthroughSubject<Character, Never>()
    @State var isShowingSearchBar: Bool = false
    
    enum ViewState: Hashable {
        case loading
        case loaded(characters: [Character])
        case error
    }
    
    var body: some View {
        BaseView(output: output) {
            VStack {
                SearchBar(isShowing: $isShowingSearchBar,
                          searchText: $input.searchText,
                          selectedFilter: $input.selectedFilter)
                .disabled(output.viewState == .loading
                          || output.viewState == .error)
                .autocorrectionDisabled()
                .padding(.horizontal)
                .padding(.bottom, 10)
                switch output.viewState {
                case .loading:
                    LoaderView()
                case .error:
                    VStack {
                        Spacer()
                        Text("HomeErrorTitle")
                            .font(.headline)
                        Text("HomeErrorMessage")
                            .font(.caption)
                        Button("RetryButton") {
                            initTrigger.send()
                        }
                        .padding()
                        Spacer()
                    }
                    .padding()
                case .loaded(let characters):
                    if !characters.isEmpty {
                        ScrollView {
                            LazyVStack {
                                ForEach(characters, id: \.id) { character in
                                    CharacterView(character: character)
                                        .onTapGesture {
                                            characterDetailTrigger.send(character)
                                        }
                                }
                                LastRowView(canLoadMore: $output.canLoadMore)
                                    .onAppear {
                                        loadMoreTrigger.send()
                                    }
                            }
                            .padding()
                        }
                    } else {
                        VStack {
                            Spacer()
                            Text("SearchListNoResultsTitle")
                                .font(.headline)
                            Text("SearchListNoResultsMessage")
                                .font(.caption)
                            Spacer()
                        }
                    }
                }
            }
            
            output.addNavigations
        }
        .navigationTitle("TabItemHome")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        isShowingSearchBar = true
                    }
                } label: {
                    Image(systemName: "magnifyingglass")
                }
                .disabled(output.viewState == .loading
                          || output.viewState == .error)
            }
        }
    }
    
    init(viewModel: HomeViewModel) {
        let input = HomeViewModel.Input(initTrigger: initTrigger.asDriver(),
                                        loadMoreTrigger: loadMoreTrigger.asDriver(),
                                        characterDetailTrigger: characterDetailTrigger.asDriver())
        output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
        initTrigger.send()
    }
}

struct CharacterView: View {
    let character: Character
    
    var body: some View {
        HStack(spacing: 10) {
            CustomAsyncImage(url: character.imageUrl, size: 50)
                .clipShape(Circle())
            Text(character.name)
                .font(.callout)
                .bold()
                .foregroundStyle(Color(.background))
            Spacer()
        }
        .padding()
        .background(Color(.secondaryOption))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct SearchBar: View {
    
    @Binding var isShowing: Bool
    @Binding var searchText: String
    @Binding var selectedFilter: FilterTab.FilterTabData?
    @FocusState private var searchFocused: Bool
    
    var filterTabs: [FilterTab.FilterTabData] {
        FilterTab.FilterTabData.allCases
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if isShowing {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("SearchBarPlaceHolder", text: $searchText)
                            .focused($searchFocused)
                            .onAppear {
                                searchFocused = true
                            }
                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                            }
                        }
                    }
                    .padding(5)
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    Button("SearchBarCancelButton") {
                        withAnimation {
                            searchText = ""
                            isShowing = false
                        }
                    }
                }
                .padding(.bottom, 5)
            }
            HStack {
                ForEach(filterTabs, id: \.self) { data in
                    FilterTab(filterTabData: data, isSelected: Binding(get: {
                        selectedFilter == data
                    }, set: { newValue in
                        selectedFilter = newValue ? data : nil
                    }))
                }
                Spacer()
            }
        }
    }
}

struct FilterTab: View {
    enum FilterTabData: LocalizedStringResource, CaseIterable {
        case alive = "FilterTabAlive"
        case dead = "FilterTabDead"
        case unknown = "FilterTabUnknown"
        
        var status: Character.Status {
            switch self {
            case .alive: return .alive
            case .dead: return .dead
            case .unknown: return .unknown
            }
        }
    }
    
    var filterTabData: FilterTabData
    @Binding var isSelected: Bool
    
    var body: some View {
        Text(String(localized: filterTabData.rawValue))
            .foregroundStyle(Color(.background))
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(isSelected ? Color(.accent) : Color(.disabled))
            .clipShape(Capsule())
            .onTapGesture {
                isSelected.toggle()
            }
    }
}

#Preview {
    NavigationStack {
        DefaultHomeAssembler.resolve()
    }
}
