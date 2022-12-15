//
//  CarInterface.swift
//  car
//
//  Created by Елизавета Хворост on 23/11/2022.
//

import UIKit

protocol CarInterface: RoadInterface
{
    func checkIfCollisionDetected(with obstacles: [UIView]) -> Bool
    func initiate()
}
