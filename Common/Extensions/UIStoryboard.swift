//
//  UIStoryboard.swift
//  Common
//
//  Created by Anshu Raghuvansi on 28/07/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import Foundation

public extension UIStoryboard{
    
    static func board(named:String)->UIStoryboard{
        return UIStoryboard(name: named, bundle: nil)
    }
    
    //This function required story board Identifier should be
    //same as UIViewController class name
    func instantiateViewController<T: UIViewController>() -> T {
        return instantiateViewController(withIdentifier: T.className) as! T
    }
}
