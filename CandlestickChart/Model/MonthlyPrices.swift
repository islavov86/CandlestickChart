//
//  MonthlyPrices.swift
//  CandlestickChart
//
//  Created by Ivan Slavov on 22.12.19.
//  Copyright © 2019 Ivan Slavov. All rights reserved.
//

import Foundation
import ObjectMapper

struct MonthlyPrices: Mappable {
    
    var monthlyPricesArray: [String: PricesListObject] = [String: PricesListObject]()
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        monthlyPricesArray   <- map["Monthly Time Series"]
    }
}
