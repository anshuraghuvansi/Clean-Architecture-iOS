//
//  SigninViewModel.swift
//  CleanArchitectureiOS
//
//  Created by Anshu Raghuvansi on 21/07/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Domain

final class SigninViewModel:ViewModelProtocol {
    
    var input: SigninViewModel.Input!
    var output: SigninViewModel.Output!
    
    private let bag = DisposeBag()
    private let navigator:SigninNavigator
    
    init(navigator:SigninNavigator) {
        self.navigator = navigator
        output = Output()
        handleInput()
    }
    
    func signin(){
        
        let params = SigninBodyParams(email: input.email.value,
                                      password: input.password.value)
        
        let err = params.validate()
        output.error.accept(err)
        if err != nil{ return }
        
        navigator.useCaseProvider
        .makeUserAuthorizationUseCase()
        .signin(params: params)
        .subscribe(onNext: {[weak self](auth) in
            guard let self = self else { return }
            self.navigator.showNextScreen(with: auth)
        },onError: { [weak self](error) in
            self?.output.error.accept(error)
        }).disposed(by: bag)
    }
}

extension SigninViewModel{
    
    struct Input {
        let signinTap = PublishRelay<Void>()
        let signupTap = PublishRelay<Void>()
        
        let email = BehaviorRelay<String?>(value: nil)
        let password = BehaviorRelay<String?>(value: nil)
    }
    
    struct Output {
        let error = PublishRelay<Error?>()
    }
    
    func handleInput() {
        
        input = Input()
        
        input.signinTap.subscribe(onNext: { [weak self]_ in
            self?.signin()
        }).disposed(by: bag)
        
        input.signupTap.subscribe(onNext: { [weak self]_ in
            self?.navigator.toSignupScreen()
        }).disposed(by: bag)
    }
}
