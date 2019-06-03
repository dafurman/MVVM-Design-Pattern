//
//  UIViewController+Extensions.swift
//  MVVM-Design-Pattern
//
//  Created by David Furman on 6/2/19.
//  Copyright © 2019 David Furman. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
    /// The name of the view associated with this view controller.
    ///
    /// This property makes the assumption that the view is suffixed with `View`, and that this view controller is suffixed with either `VC` or `ViewController`.
    class var nameOfView: String {
        var name = nameOfClass
        name = name.replacingOccurrences(of: "VC", with: "View")
        name = name.replacingOccurrences(of: "ViewController", with: "View")
        return name
    }
}
