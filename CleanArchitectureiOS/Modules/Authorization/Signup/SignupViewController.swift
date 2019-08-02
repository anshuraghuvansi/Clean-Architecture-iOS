//
//  SignupViewController.swift
//  CleanArchitectureiOS
//
//  Created by Anshu Raghuvansi on 21/07/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import UIKit
import RxSwift

final class SignupViewController: UIViewController {

    @IBOutlet var backButton:UIButton!
    @IBOutlet var messageLabel:UILabel!
    @IBOutlet var signupButton:UIButton!
    @IBOutlet var nameTextField:UITextField!
    @IBOutlet var emailTextField:UITextField!
    @IBOutlet var passwordTextField:UITextField!
    
    var viewModel:SignupViewModel!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind(){
        nameTextField.rx.text.bind(to: viewModel.input.name).disposed(by: bag)
        emailTextField.rx.text.bind(to: viewModel.input.email).disposed(by: bag)
        passwordTextField.rx.text.bind(to: viewModel.input.password).disposed(by: bag)
        signupButton.rx.tap.bind(to: viewModel.input.signupTap).disposed(by: bag)
        backButton.rx.tap.bind(to: viewModel.input.backTap).disposed(by: bag)
        viewModel.output.error.map{$0?.localizedDescription}
            .bind(to: messageLabel.rx.text).disposed(by: bag)
    }
}
