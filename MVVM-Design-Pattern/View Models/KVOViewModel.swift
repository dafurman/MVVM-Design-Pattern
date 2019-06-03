//
//  KVOViewModel.swift
//  MVVM-Design-Pattern
//
//  Created by David Furman on 6/2/19.
//  Copyright © 2019 David Furman. All rights reserved.
//

import Foundation

// Break the rules of importing UIKit in a view model to be able to be notified of changes to the text field. This is part of why KVO stinks for MVVM.
// Alternatively, the view controller could have been delegate of the text field, and then the delegate function called a view controller function to do the updating, but that isn't really much better.
import UIKit.UITextField

class KVOViewModel {
    
    // ========
    // MARK: - Properties
    // ========
    
    private var observers = [NSKeyValueObservation]()
    
    private var user: KVOUser
    
    var userNameDidChange: ((String) -> ())? {
        willSet {
            if userNameDidChange == nil && newValue != nil {
                observeUser()
            }
        }
    }
    
    // ========
    // MARK: - Initialization
    // ========

    init(user: KVOUser) {
        self.user = user
    }
    
    // ========
    // MARK: - Observation
    // ========
    
    private func observeUser() {
        let observer = user.observe(\KVOUser.name, options: [.new]) { [weak self](user, change) in
            self?.userNameDidChange?(user.name)
        }
        observers.append(observer)
    }
    
    @objc func nameInputDidChange() {
        user.name = ""
    }
}

extension KVOViewModel: ViewModel {
    func setName(_ name: String) {
        user.name = name
    }
}
