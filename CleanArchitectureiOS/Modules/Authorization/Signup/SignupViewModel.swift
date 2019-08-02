//
//  SignupViewModel.swift
//  CleanArchitectureiOS
//
//  Created by Anshu Raghuvansi on 21/07/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Domain

final class SignupViewModel:ViewModelProtocol {
    
    var input: SignupViewModel.Input!
    var output: SignupViewModel.Output!
    
    private let bag = DisposeBag()
    private let navigator:SignupNavigator
    
    init(navigator:SignupNavigator) {
        self.navigator = navigator
        self.output = Output()
        handleInput()
    }
    
    func signup(){
        
        let params = SignupBodyParams(name:input.name.value,
                                      email: input.email.value,
                                      password: input.password.value)
        
        let err = params.validate()
        output.error.accept(err)
        if err != nil{ return }
        
        navigator.useCaseProvider
            .makeUserAuthorizationUseCase()
            .signup(params: params)
            .subscribe(onNext: {[weak self](auth) in
                guard let self = self else { return }
                self.navigator.showNextScreen(with: auth)
            },onError: { [weak self](error) in
                self?.output.error.accept(error)
            }).disposed(by: bag)
    }
}

extension SignupViewModel {
    
    struct Input {
        
        let signupTap = PublishRelay<Void>()
        let backTap = PublishRelay<Void>()
        
        let name = BehaviorRelay<String?>(value: nil)
        let email = BehaviorRelay<String?>(value: nil)
        let password = BehaviorRelay<String?>(value: nil)
    }
    
    struct Output {
         let error = PublishRelay<Error?>()
    }
    
    func handleInput() {
        
        input = Input()
        
        input.signupTap.subscribe(onNext: { [weak self] _  in
            self?.signup()
        }).disposed(by: bag)
        
        input.backTap.subscribe(onNext: { [weak self] _  in
            self?.navigator.goBack()
        }).disposed(by: bag)
    }
}
