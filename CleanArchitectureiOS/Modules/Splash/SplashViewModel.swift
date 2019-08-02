//
//  SplashViewModel.swift
//  CleanArchitectureiOS
//
//  Created by Anshu Raghuvansi on 31/07/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import Foundation

final class SplashViewModel{
    
    let navigator:SplashNavigator
    init(navigator:SplashNavigator) {
        self.navigator = navigator
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.navigator.showNextScreen()
        }
    }
}
