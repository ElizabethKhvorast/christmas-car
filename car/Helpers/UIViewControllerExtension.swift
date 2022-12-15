//
//  UIViewControllerExtension.swift
//  car
//
//  Created by Елизавета Хворост on 24/11/2022.
//

import UIKit

extension UIViewController
{
//    func showAlertWith(title: String? ,
//                       message: String?,
//                       buttonTitle: String?,
//                       completion: (()->())?)
//    {
//        let alert = UIAlertController(title: title,
//                                      message: message,
//                                      preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: buttonTitle,
//                                      style: .default,
//                                      handler: { action in
//               completion?()
//        }))
//        self.present(alert, animated: true)
//    }
    
    func showAlertWith(title: String? ,
                       message: String?,
                       firstButtonTitle: String?,
                       secondButtonTitle: String? = nil,
                       firstCompletion: (()->())?,
                       secondCompletion: (()->())? = nil)
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: firstButtonTitle,
                                      style: .default,
                                      handler: { action in
               firstCompletion?()
        }))
        if let _ = secondButtonTitle
        {
            alert.addAction(UIAlertAction(title: secondButtonTitle,
                                          style: .default,
                                          handler: { action in
                   secondCompletion?()
            }))
        }
        self.present(alert, animated: true)
    }
}

