//
//  Application.swift
//  CleanArchitectureiOS
//
//  Created by Anshu Raghuvansi on 21/07/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import Common
import NetworkKit

final class Application {
    
    private var window = UIWindow(frame: UIScreen.main.bounds)
    static let shared = Application()
    
    var networkProvider = NetworkKit.UseCaseProvider()
    let userProfile = BehaviorRelay<UserProfile?>(value: nil)
    let authorization = BehaviorRelay<Authorization?>(value: nil)
    
    private let bag = DisposeBag()
    
    private init() {
        
        //get saved token
        if let token = UserDefaults.AuthToken{
            authorization.accept(Authorization(token:token))
        }
        
        authorization.subscribe(onNext: { (auth) in
            Network.token = auth?.token
            UserDefaults.AuthToken = auth?.token //save token
        }).disposed(by: bag)
    }
    
    func showNextScreen(){
        
        if let auth = authorization.value,auth.isValid{
            //user is loggedin show the profile screen
            showProfileScreen()
        }
        else {
            //user is not loggedin show the login screen
            showSigninScreen()
        }
    }
    
    func showSplashScreen(){
        let storyBoard = UIStoryboard.board(named: "Authorization")
        let navigator = SplashNavigator(with: self, storyBoard: storyBoard)
        navigator.toSplashScreen()
    }
    
    func showSigninScreen(){
        let storyBoard = UIStoryboard.board(named: "Authorization")
        let vc = UINavigationController()
        vc.isNavigationBarHidden = true
        let navigator = SigninNavigator(application: self,
                                        useCaseProvider: networkProvider,
                                        storyBoard: storyBoard, navigation: vc)
        navigator.toSigninScreen()
    }
    
    func showProfileScreen(){
        let storyBoard = UIStoryboard.board(named: "Profile")
        let navigation = UINavigationController()
        let navigator = ProfileNavigator(application: self,
                                         useCaseProvider: networkProvider,
                                         storyBoard: storyBoard,
                                         navigation: navigation)
        navigator.toProfileScreen()
    }
}

extension Application{
    
    func setAnimatedRootController(controller:UIViewController){
        
        let transition = CATransition()
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction( name:CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        CATransaction.begin()
        window.layer.add(transition, forKey: nil)
        window.rootViewController = controller
        window.makeKeyAndVisible()
        CATransaction.commit()
    }
}
