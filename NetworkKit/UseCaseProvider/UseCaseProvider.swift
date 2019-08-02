//
//  UseCaseProvider.swift
//  NetworkKit
//
//  Created by Anshu Raghuvansi on 01/08/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import Foundation
import Domain

public final class UseCaseProvider:Domain.UseCaseProvider{
    
    let networkProvider = NetworkProvider()
    public init(){}
    
    public func makeUserProfileUseCase() -> Domain.UserProfileUseCase {
        let network = networkProvider.makeProfileNetwork()
        return UserProfileUseCase(network: network)
    }
    
    public func makeUserAuthorizationUseCase() -> Domain.UserAuthorizationUseCase {
        let network = networkProvider.makeAuthorizationNetwork()
        return UserAuthorizationUseCase(network:network)
    }
}
