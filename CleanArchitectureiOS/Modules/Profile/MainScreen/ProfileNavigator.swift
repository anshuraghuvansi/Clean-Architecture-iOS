//
//  ProfileNavigator.swift
//  CleanArchitectureiOS
//
//  Created by Anshu Raghuvansi on 21/07/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import Foundation
import Domain

final class ProfileNavigator:BaseNavigator {
    
    private let application:Application
    
    init(application:Application,useCaseProvider:UseCaseProvider,
         storyBoard:UIStoryboard,navigation:UINavigationController) {
        self.application = application
        super.init(useCaseProvider: useCaseProvider,
                   storyBoard: storyBoard,
                   navigation:navigation)
    }
    
    func toProfileScreen(){
        let vc:ProfileViewController = storyBoard.instantiateViewController()
        vc.viewModel = ProfileViewModel(navigator: self)
        application.setAnimatedRootController(controller: vc)
    }
}
