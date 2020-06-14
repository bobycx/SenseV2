//
//  global.swift
//  Sense
//
//  Created by Bob Yuan on 2020-06-11.
//  Copyright © 2020 Bob Yuan. All rights reserved.
//

import Foundation

class globalVariables {
    var level: Int = 1
    var cellLevel: Int = 1
    
    init(level: Int, cellLevel: Int) {
        self.level = level
        self.cellLevel = cellLevel
    }
}

var gVars = globalVariables(level: 1, cellLevel: 1)

