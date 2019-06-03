//
//  BoundTextField.swift
//  MVVM-Design-Pattern
//
//  Created by David Furman on 6/2/19.
//  Copyright © 2019 David Furman. All rights reserved.
//

import UIKit.UITextField

class BoundTextField: UITextField {
    
    // ========
    // MARK: - Properties
    // ========
    
    /// We call this when the `editingChanged` event happens.
    var changedClosure: (() -> ())?
    
    // ========
    // MARK: - Functions
    // ========

    /// Attach this as a selector. All it does is trigger the `changedClosure`.
    @objc func valueChanged() {
        changedClosure?()
    }
    
    /// 1. Accept any Observable value that stores a string underneath, because that’s what our text fields work with.
    /// 2. Add the text field as its own handler for the the editingChanged event, pointing it at the valueChanged() method we just wrote.
    /// 3. Set the text field’s changedClosure to some code that calls the bindingChanged() method on its observed object.”
    /// 4. Set the observable’s valueChanged closure to some code that updates the text in the text field.
    func bind(to observable: Observable<String>) {
        addTarget(self, action: #selector(BoundTextField.valueChanged), for: .editingChanged)
        
        changedClosure = { [weak self] in
            observable.value = self?.text
        }
        
        observable.valueChanged = { [weak self] newValue in
            self?.text = newValue
        }
    }
}
