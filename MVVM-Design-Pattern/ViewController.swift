//
//  ViewController.swift
//  MVVM-Design-Pattern
//
//  Created by David Furman on 6/2/19.
//  Copyright © 2019 David Furman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // ========
    // MARK: - IBOutlets
    // ========
    
    @IBOutlet private weak var textField: BoundTextField! {
        didSet {
            switch viewModel {
            case let kvoVM as KVOViewModel:
                // Binding from VM to VC
                kvoVM.userNameDidChange = { [weak self] (newValue) in
                    self?.textField.text = newValue
                }
                
                // Binding from VC to VM
                textField.addTarget(self, action: #selector(KVOtextFieldDidChange(textField:)), for: .editingChanged)
            case let observableVM as ObservableViewModel:
                textField.bind(to: observableVM.user.name)
            default:
                break
            }
        }
    }
    
    @IBOutlet private weak var bindingPatternTitleLabel: UILabel! {
        didSet {
            let text: String = {
                switch viewModel {
                case is KVOViewModel:
                    return "KVO"
                case is ObservableViewModel:
                    return "Observable"
                default:
                    return ""
                }
            }()
            
            bindingPatternTitleLabel.text = text
        }
    }
    
    // ========
    // MARK: - Properties
    // ========

    private let viewModel: ViewModel
    
    // ========
    // MARK: - Initialization
    // ========

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: ViewController.nameOfView, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // ========
    // MARK: - KVO Observer Helper
    // ========
    
    /// This function is used to allow the text field to update the view model. It's the closest thing we can really get to with binding for KVO.
    @objc private func KVOtextFieldDidChange(textField: UITextField) {
        viewModel.setName(textField.text ?? "")
    }
    
    // ========
    // MARK: - IBActions
    // ========
    
    @IBAction private func pressedSetModelValue() {
        let testName = "Bilbro Swaggins"
        
        viewModel.setName(testName)
    }
}

