//
//  Double+Extesion.swift
//  ECommerce
//
//  Created by Suryansh Mishra on 20/11/25.
//

import Foundation

extension Double{
    func roundedUp(toPlaces places: Int) -> Double{
        let divisor = pow(10.0, Double(places))
        return ceil(divisor * self) / divisor
    }
}
