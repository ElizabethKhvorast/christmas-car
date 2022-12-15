//
//  NavigationController.swift
//  car
//
//  Created by Елизавета Хворост on 15/12/2022.
//

import UIKit

class NavigationController: UINavigationController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                              NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)]
        self.navigationBar.titleTextAttributes = textAttributes
        self.navigationBar.barTintColor = UIColor.black
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white, .font : UIFont.systemFont(ofSize: 20)]
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()
        navBarAppearance.backgroundColor = UIColor.black
        navBarAppearance.shadowImage = UIImage()
        navBarAppearance.shadowColor = UIColor.clear
        navBarAppearance.titleTextAttributes = textAttributes
        self.navigationBar.standardAppearance = navBarAppearance
        self.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.navigationBar.isTranslucent = true
        self.navigationBar.shadowImage = UIImage()
    }
}
