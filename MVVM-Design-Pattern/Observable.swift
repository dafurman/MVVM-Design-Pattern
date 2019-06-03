//
//  Observable.swift
//  MVVM-Design-Pattern
//
//  Created by David Furman on 6/2/19.
//  Copyright © 2019 David Furman. All rights reserved.
//

import Foundation

/// An `Observable` class is a wrapper designed to monitor one value.
/// It's a class because it allows us to mutate it freely, but you'll probably want to switch to a struct for the extra immutability it provides, or just move to a framework like Bond.
class Observable<ObservedType> {
    
    // ========
    // MARK: - Properties
    // ========
    
    /// The stored value is private: we don't want other folks to touch this by accident.
    private var _value: ObservedType?
    
    public var value: ObservedType? {
        get {
            return _value
        } set {
            _value = newValue
            print("Value is now \(String(describing: newValue))")
            valueChanged?(_value)
        }
    }
    
    var valueChanged: ((ObservedType?) -> ())?
    
    // ========
    // MARK: - Initialization
    // ========
    
    init(_ value: ObservedType) {
        _value = value
    }
    
    // ========
    // MARK: - Functions
    // ========
    
    func bindingChanged(to newValue: ObservedType) {
        _value = newValue
        print("Value is now \(newValue)")
    }
}
