//
//  ProfileViewModel.swift
//  Gutify
//
//  Created by Pablo Alonso Gonzalez.
//

import Foundation
import Combine

struct ProfileViewModel: BaseViewModel {
    
    final class Input: ObservableObject {
    }
    
    final class Output: BaseOutput {
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let errorTracker = ErrorTracker()
        return output
    }
}
