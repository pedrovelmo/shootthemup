//
//  Color.swift
//  ShootThemUp
//
//  Created by Pedro Velmovitsky on 23/03/17.
//  Copyright © 2017 velmovitsky. All rights reserved.
//

import Foundation
import UIKit

// UIColor extensions
public extension UIColor {
    public static var redB: UIColor {
        return UIColor(red: 255.0/255.0, green: 100.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    }
    
    public static var greenB: UIColor {
        return UIColor(red: 83.0/255.0, green: 177.0/255.0, blue: 105.0/255.0, alpha: 1.0)
    }
    
    public static var blueB: UIColor {
        return UIColor(red: 83.0/255.0, green: 152.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
}
