//
//  ViewModel.swift
//  MVVM-Design-Pattern
//
//  Created by David Furman on 6/2/19.
//  Copyright © 2019 David Furman. All rights reserved.
//

import Foundation

protocol ViewModel {
    /// A setter function is used to prevent the view controller from reaching the model directly.
    func setName(_ name: String)
}
