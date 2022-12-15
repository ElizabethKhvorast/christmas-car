//
//  DateExtension.swift
//  car
//
//  Created by Елизавета Хворост on 12/12/2022.
//

import Foundation

extension Date
{
    func dateString(formatted: String) -> String?
    {
        let formatter = DateFormatter()
        formatter.dateFormat = formatted
        return formatter.string(from: self)
    }
}
