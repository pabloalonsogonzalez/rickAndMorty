//
//  EpisodesViewModel.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez.
//

import Foundation
import Combine

struct EpisodesViewModel: BaseViewModel {
    
    final class Input: ObservableObject {
        let initTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        
        init(initTrigger: Driver<Void>,
             loadMoreTrigger: Driver<Void>) {
            self.initTrigger = initTrigger
            self.loadMoreTrigger = loadMoreTrigger
        }
    }
    
    final class Output: BaseOutput {
        @Published var showError = false
        @Published var isLoading = true
        @Published var seasons: [Season] = []
        @Published var canLoadMore = false
        var paginatedResult: PaginatedResult<Season>? = nil
    }
    
    private let getEpisodesUseCase: GetEpisodesUseCase
    
    init(getEpisodesUseCase: GetEpisodesUseCase) {
        self.getEpisodesUseCase = getEpisodesUseCase
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let errorTracker = ErrorTracker()
        let activityTracker = ActivityTracker(true)
        
        input.initTrigger
            .flatMap {
                getEpisodesUseCase
                    .execute()
                    .trackActivity(activityTracker)
                    .trackError(errorTracker)
            }
            .sink {
                output.paginatedResult = $0
                output.canLoadMore = $0.paginationInfo.nextUrl != nil
                output.seasons = $0.results
            }
            .store(in: cancelBag)
        
        input.loadMoreTrigger
            .filter {
                output.paginatedResult?.paginationInfo.nextUrl != nil
            }
            .flatMap { _ in
                getEpisodesUseCase
                    .execute(GetEpisodesUseCase.Query(previousResult: output.paginatedResult))
                    .trackError(errorTracker)
            }
            .sink {
                output.paginatedResult = $0
                output.canLoadMore = $0.paginationInfo.nextUrl != nil
                output.seasons = $0.results
            }
            .store(in: cancelBag)
        
        activityTracker
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        errorTracker.sink { _ in
            output.showError = true
        }
        .store(in: cancelBag)
        
        return output
    }
}
