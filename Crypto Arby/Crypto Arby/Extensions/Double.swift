//
//  Double.swift
//  Crypto Arby
//
//  Created by Luka Stupar on 12.10.23..
//

import Foundation

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
