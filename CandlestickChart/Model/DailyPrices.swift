//
//  DailyPricesResponse.swift
//  CandlestickChart
//
//  Created by Ivan Slavov on 21.12.19.
//  Copyright © 2019 Ivan Slavov. All rights reserved.
//

import Foundation
import ObjectMapper

struct DailyPrices: Mappable {
    
    var dailyPricesArray: [String: PricesListObject] = [String: PricesListObject]()
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        dailyPricesArray   <- map["Time Series (Daily)"]
    }
}

struct PricesListObject: Mappable {
    var open: Double = 0.0
    var high: Double = 0.0
    var low: Double = 0.0
    var close: Double = 0.0
    var volume: Double = 0.0
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        map.JSON.forEach { (key, value) in
            let value = Double(value as! String)!.rounded(toPlaces: 4)
            switch key {
            case "1. open":
                open = value
            case "2. high":
                high = value
            case "3. low":
                low = value
            case "4. close":
                close = value
            case "5. volume":
                volume = value
            default:
                print("TODO")
            }
        }
    }
}
