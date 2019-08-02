//
//  SplashNavigator.swift
//  CleanArchitectureiOS
//
//  Created by Anshu Raghuvansi on 28/07/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import UIKit

final class SplashNavigator {
    
    let application:Application
    let storyBoard:UIStoryboard
    
    init(with application:Application,storyBoard:UIStoryboard) {
        self.application = application
        self.storyBoard = storyBoard
    }
    
    func toSplashScreen(){
        let vc:SplashViewController = storyBoard.instantiateViewController()
        vc.viewModel = SplashViewModel(navigator: self)
        application.setAnimatedRootController(controller: vc)
    }
    
    func showNextScreen(){
        application.showNextScreen()
    }
}
