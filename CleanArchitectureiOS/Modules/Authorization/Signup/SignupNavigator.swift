//
//  SignupNavigator.swift
//  CleanArchitectureiOS
//
//  Created by Anshu Raghuvansi on 21/07/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import UIKit
import Domain

final class SignupNavigator:BaseNavigator{
    
    private let application:Application
    
    init(application:Application,useCaseProvider:UseCaseProvider,
         storyBoard:UIStoryboard,navigation:UINavigationController) {
        self.application = application
        super.init(useCaseProvider: useCaseProvider,
                   storyBoard: storyBoard,
                   navigation:navigation)
    }
    
    func toSignupScreen(){
        let vc:SignupViewController = storyBoard.instantiateViewController()
        vc.viewModel = SignupViewModel(navigator: self)
        navigation.pushViewController(vc, animated: true)
    }
    
    func showNextScreen(with auth:Authorization){
        application.authorization.accept(auth)
        application.showNextScreen()
    }
    
    func goBack(){
        navigation.popViewController(animated: true)
    }
}
