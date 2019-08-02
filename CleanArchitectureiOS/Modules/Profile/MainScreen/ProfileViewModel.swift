//
//  ProfileViewModel.swift
//  CleanArchitectureiOS
//
//  Created by Anshu Raghuvansi on 21/07/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class ProfileViewModel:ViewModelOutputProtocol{
    
    var output: ProfileViewModel.Output!
    
    private let navigator:ProfileNavigator
    private let bag = DisposeBag()
    
    init(navigator:ProfileNavigator) {
        self.navigator = navigator
        self.output = Output()
    }
    
    func fetchProfile(){
        
        navigator.useCaseProvider
            .makeUserProfileUseCase()
            .fetchProfile()
            .subscribe(onNext: {[weak self](profile) in
                
                guard let self = self else { return }
                self.output.email.accept(profile.email)
                self.output.name.accept(profile.name)
                Application.shared.userProfile.accept(profile)
                
            }, onError: { [weak self](error) in
                self?.output.error.accept(error)
            }).disposed(by: bag)
    }
}

extension ProfileViewModel {
    
    struct Output {
        let error = PublishRelay<Error?>()
        let email = BehaviorRelay<String?>(value: nil)
        let name = BehaviorRelay<String?>(value: nil)
    }
}
