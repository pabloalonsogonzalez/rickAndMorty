//
//  CharacterDetailViewModel.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez.
//

import Foundation
import Combine

struct CharacterDetailViewModel: BaseViewModel {
    
    final class Input: ObservableObject {
        let initTrigger: Driver<Void>

        init(initTrigger: Driver<Void>) {
            self.initTrigger = initTrigger
        }
    }
    
    final class Output: BaseOutput {
        @Published var viewState: CharacterDetailView.ViewState = .loading
    }
    
    private let dependencies: CharacterDetailDependencies
    private let getEpisodesByIdUseCase: GetEpisodesByIdUseCase
    
    init(dependencies: CharacterDetailDependencies,
         getEpisodesByIdUseCase: GetEpisodesByIdUseCase) {
        self.dependencies = dependencies
        self.getEpisodesByIdUseCase = getEpisodesByIdUseCase
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let errorTracker = ErrorTracker()
        
        input.initTrigger
            .flatMap {
                getEpisodesByIdUseCase
                    .execute(GetEpisodesByIdUseCase.Query(urls: dependencies.character.episodesUrls))
                    .trackError(errorTracker)
            }
            .sink {
                output.viewState = .loaded(character: dependencies.character, episodes: $0)
            }
            .store(in: cancelBag)
      
        errorTracker.sink { _ in
            output.alertMessage = AlertMessage(title: "CharacterDetailErrorTitle",
                                               message: "CharacterDetailErrorMessage",
                                               actionText: "AlertMessageOkButton",
                                               action: {
                output.shouldDismiss = true
            })
        }
        .store(in: cancelBag)
    
        return output
    }
}
