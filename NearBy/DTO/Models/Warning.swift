//
//  Warning.swift
//  NearBy
//
//  Created by Ahmed Moussa on 7/19/20.
//  Copyright © 2020 Moussa Tech. All rights reserved.
//

import Foundation

public class Warning: CodableEquatable {
    public let text: String

    public init(text: String) {
        self.text = text
    }
    
    public static func == (lhs: Warning, rhs: Warning) -> Bool {
        return lhs.text == rhs.text
    }
}
