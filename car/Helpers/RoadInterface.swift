//
//  RoadInterface.swift
//  car
//
//  Created by Елизавета Хворост on 23/11/2022.
//

import Foundation

protocol RoadInterface
{
    func update()
    func invalidate()
}

//to make it optional
extension RoadInterface
{
    func update()
    {
        
    }
}
