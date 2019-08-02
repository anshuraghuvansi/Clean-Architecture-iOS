//
//  ProfileViewController.swift
//  CleanArchitectureiOS
//
//  Created by Anshu Raghuvansi on 21/07/19.
//  Copyright © 2019 anshuraghuvansi. All rights reserved.
//

import UIKit
import RxSwift

final class ProfileViewController: UIViewController {

    @IBOutlet var nameLabel:UILabel!
    @IBOutlet var emailLabel:UILabel!
    @IBOutlet var messageLabel:UILabel!
    
    var viewModel:ProfileViewModel!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.fetchProfile()
    }

    func bind(){
        viewModel.output.name.bind(to:nameLabel.rx.text).disposed(by: bag)
        viewModel.output.email.bind(to:emailLabel.rx.text).disposed(by: bag)
        viewModel.output.error.map{$0?.localizedDescription}
            .bind(to: messageLabel.rx.text).disposed(by: bag)
    }
}
