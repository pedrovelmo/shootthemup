//
//  PhysicsCategory.swift
//  ShootThemUp
//
//  Created by Pedro Velmovitsky on 14/03/17.
//  Copyright © 2017 velmovitsky. All rights reserved.
//

import Foundation

// Types of objects in the game to configure collisions
public enum PhysicsCategory {
    static let None     : UInt32 = 0
    static let Ball     : UInt32 = 0b010
    static let Brick    : UInt32 = 0b011
    static let Paddle   : UInt32 = 0b100

}
