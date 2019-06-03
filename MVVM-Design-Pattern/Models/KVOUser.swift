//
//  User-KVO.swift
//  MVVM-Design-Pattern
//
//  Created by David Furman on 6/2/19.
//  Copyright © 2019 David Furman. All rights reserved.
//

import Foundation

/// To use KVO...
/// You use a class.
/// Your class inherits from NSObject.
/// All your observable types are visible to Objective-C. (No structs or enums.)
/// All your observable types are marked @objc.
/// All your observable types are marked dynamic.”
class KVOUser: NSObject {
    
    // ========
    // MARK: - Properties
    // ========
    
    @objc dynamic var name: String {
        didSet {
            print("Value is now \(name)")
        }
    }
    
    // ========
    // MARK: - Initialization
    // ========
    
    init(name: String) {
        self.name = name
        
        super.init()
    }
}
