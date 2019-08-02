//
//  UserProfileUseCase.swift
//  NetworkKit
//
//  Created by Anshu Raghuvansi on 02/08/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class UserProfileUseCase:Domain.UserProfileUseCase{
    
    private let network:ProfileNetwork
    
    init(network:ProfileNetwork) {
        self.network = network
    }
    
    func fetchProfile() -> Observable<UserProfile> {
        return network.fetchProfile()
    }
}
