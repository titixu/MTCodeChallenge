//
//  ViewController.swift
//  MTCodeChallenge
//
//  Created by An Xu on 25/7/19.
//  Copyright © 2019 Sam Xu. All rights reserved.
//

import UIKit

extension UIViewController {
    func defaultNavigationBarLayout() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .appBackground
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColor]
    }
}
