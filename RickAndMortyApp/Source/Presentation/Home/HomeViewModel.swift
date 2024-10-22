//
//  HomeViewModel.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez.
//

import Foundation
import Combine

struct HomeViewModel: BaseViewModel {
    
    final class Input: ObservableObject {
        let initTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let characterDetailTrigger: Driver<Character>
        @Published var searchText: String = ""
        @Published var selectedFilter: FilterTab.FilterTabData? = nil
        
        init(initTrigger: Driver<Void>,
             loadMoreTrigger: Driver<Void>,
             characterDetailTrigger: Driver<Character>) {
            self.initTrigger = initTrigger
            self.loadMoreTrigger = loadMoreTrigger
            self.characterDetailTrigger = characterDetailTrigger
        }
    }
    
    final class Output: BaseOutput {
        @Published var viewState: HomeView.ViewState = .loading
        @Published var canLoadMore = false
        var paginatedResult: PaginatedResult<Character>? = nil
    }
    
    private let getCharactersUseCase: GetCharactersUseCase
    
    init(getCharactersUseCase: GetCharactersUseCase) {
        self.getCharactersUseCase = getCharactersUseCase
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let errorTracker = ErrorTracker()
        
        input.initTrigger
            .flatMap {
                getCharactersUseCase.execute()
                    .trackError(errorTracker)
            }
            .sink {
                showResults(result: $0, output: output)
            }
            .store(in: cancelBag)
        
        Publishers.CombineLatest(input.$searchText.removeDuplicates().debounce(for: .seconds(0.8),
                                  scheduler: DispatchQueue.main),
                                 input.$selectedFilter)
        .flatMap({ searchText, selectedFilter in
            output.viewState = .loading
            return getCharactersUseCase.execute(GetCharactersUseCase.Query(name: searchText,
                                                                           status: selectedFilter?.status))
            .trackError(errorTracker)
        })
        .sink {
            showResults(result: $0, output: output)
        }
        .store(in: cancelBag)
        
        input.loadMoreTrigger
            .filter {
                output.paginatedResult?.paginationInfo.nextUrl != nil
            }
            .flatMap { _ in
                getCharactersUseCase
                    .execute(GetCharactersUseCase.Query(previousResult: output.paginatedResult))
                    .trackError(errorTracker)
            }
            .sink {
                showResults(result: $0, output: output)
            }
            .store(in: cancelBag)
        
        input.characterDetailTrigger
            .sink {
                output.pushNavigation = .characterDetail(CharacterDetailDependencies(character: $0))
            }
            .store(in: cancelBag)
        
        
        errorTracker.sink {
            if ($0 as? RickAndMortyError) == .noCharactersFound {
                showResults(result: nil, output: output)
            } else {
                output.viewState = .error
            }
        }
        .store(in: cancelBag)
        
        
        return output
    }
    
    private func showResults(result: PaginatedResult<Character>?, output: HomeViewModel.Output ) {
        output.paginatedResult = result
        output.canLoadMore = result?.paginationInfo.nextUrl != nil
        output.viewState = .loaded(characters: result?.results ?? [])
    }
}
