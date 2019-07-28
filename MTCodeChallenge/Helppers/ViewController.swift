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
        // to make the bar display it own color
        navigationController?.navigationBar.isTranslucent = false
        
        // use the same color as to the view controller's background
        navigationController?.navigationBar.barTintColor = .appBackground
        
        // change the title text color to white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColor]
        
        // change the back button and text to white color
        navigationController?.navigationBar.tintColor = .white
    }
}
