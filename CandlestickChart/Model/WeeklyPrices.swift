//
//  WeeklyPricesResponse.swift
//  CandlestickChart
//
//  Created by Ivan Slavov on 22.12.19.
//  Copyright © 2019 Ivan Slavov. All rights reserved.
//

import Foundation
import ObjectMapper

struct WeeklyPrices: Mappable {
    
    var weeklyPricesArray: [String: PricesListObject] = [String: PricesListObject]()
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        weeklyPricesArray   <- map["Weekly Time Series"]
    }
}
struct MetaData: Mappable {
    var information: String?
    var symbol: String?
    var lastRefreshed: String?
    var timeZone: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        information <- map["1. Information"]
        symbol <- map["2. Symbol"]
        lastRefreshed <- map["3. Last Refreshed"]
        timeZone <- map["4. Time Zone"]
    }
}
