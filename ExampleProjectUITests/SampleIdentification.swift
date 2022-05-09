//
//  SampleIdentification.swift
//  ExampleProjectUITests
//
//  Created by Aylwing Olivas on 4/29/22.
//

import Foundation

class SampleIdentification {
    var identifier: String
    var type: ElementType
    
    init(accessibilityIdentifier: String, elemenType: ElementType) {
        identifier = accessibilityIdentifier
        type = elemenType
    }
}

enum ElementType: UInt {
    case textField = 49
    case textView = 52
    case button = 9
}
