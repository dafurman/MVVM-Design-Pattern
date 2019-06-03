//
//  ObservableViewModel.swift
//  MVVM-Design-Pattern
//
//  Created by David Furman on 6/2/19.
//  Copyright © 2019 David Furman. All rights reserved.
//

import Foundation

struct ObservableViewModel {
    
    // ========
    // MARK: - Properties
    // ========

    let user: ObservableUser
    
    // ========
    // MARK: - Initialization
    // ========
    
    init(user: ObservableUser) {
        self.user = user
    }
}

// ========
// MARK: - ObservableViewModel: ViewModel
// ========
extension ObservableViewModel: ViewModel {
    func setName(_ name: String) {
        user.name.value = name
    }
}
