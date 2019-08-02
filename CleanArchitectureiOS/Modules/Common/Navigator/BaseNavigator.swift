//
//  BaseNavigator.swift
//  CleanArchitectureiOS
//
//  Created by Anshu Raghuvansi on 31/07/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import Foundation
import Domain

class BaseNavigator {
    
    let useCaseProvider:UseCaseProvider
    let storyBoard:UIStoryboard
    weak var navigation:UINavigationController! //to avoid retain cycle
    
    init(useCaseProvider:UseCaseProvider,
         storyBoard:UIStoryboard,
         navigation:UINavigationController) {
        self.storyBoard = storyBoard
        self.useCaseProvider = useCaseProvider
        self.navigation = navigation
    }
}
