//
//  SigninNavigator.swift
//  CleanArchitectureiOS
//
//  Created by Anshu Raghuvansi on 21/07/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import Foundation
import Domain

final class SigninNavigator:BaseNavigator {
    
    private let application:Application
    
    init(application:Application,useCaseProvider:UseCaseProvider,
         storyBoard:UIStoryboard,navigation:UINavigationController) {
        self.application = application
        super.init(useCaseProvider: useCaseProvider,
                   storyBoard: storyBoard,
                   navigation:navigation)
    }
    
    func toSigninScreen(){
        let vc:SigninViewController = storyBoard.instantiateViewController()
        vc.viewModel = SigninViewModel(navigator: self)
        application.setAnimatedRootController(controller: navigation)
        navigation.pushViewController(vc, animated: true)
    }
    
    func toSignupScreen(){
        
        let navigator = SignupNavigator(application: application,
                                        useCaseProvider: useCaseProvider,
                                        storyBoard: storyBoard,
                                        navigation: navigation)
        navigator.toSignupScreen()
    }
    
    func showNextScreen(with auth:Authorization){
        application.authorization.accept(auth)
        application.showNextScreen()
    }
}
