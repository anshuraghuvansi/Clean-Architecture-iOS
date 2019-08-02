//
//  SigninViewController.swift
//  CleanArchitectureiOS
//
//  Created by Anshu Raghuvansi on 21/07/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import UIKit
import RxSwift

final class SigninViewController: UIViewController {

    @IBOutlet var signinButton:UIButton!
    @IBOutlet var signupButton:UIButton!
    @IBOutlet var messageLabel:UILabel!
    @IBOutlet var emailTextField:UITextField!
    @IBOutlet var passwordTextField:UITextField!
    
    var viewModel:SigninViewModel!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    func bind(){
        emailTextField.rx.text.bind(to: viewModel.input.email).disposed(by: bag)
        passwordTextField.rx.text.bind(to: viewModel.input.password).disposed(by: bag)
        signinButton.rx.tap.bind(to: viewModel.input.signinTap).disposed(by: bag)
        signupButton.rx.tap.bind(to: viewModel.input.signupTap).disposed(by: bag)
        viewModel.output.error.map{$0?.localizedDescription}
            .bind(to: messageLabel.rx.text).disposed(by: bag)
    }
}
