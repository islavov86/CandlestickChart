//
//  PriceService.swift
//  CandlestickChart
//
//  Created by Ivan Slavov on 21.12.19.
//  Copyright © 2019 Ivan Slavov. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class PriceService {
    
    static let instance = PriceService()
    
    func getDailyPrices(completion: @escaping( _ response: DailyPrices?) -> ()) {
        let dailyPricesURL = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&apikey=demo")!
        let dailyPricesRequest = createGetRequest(url: dailyPricesURL)
        AF.request(dailyPricesRequest).validate().responseObject {  (dataResponse: AFDataResponse<DailyPrices>) in
            switch dataResponse.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getWeeklyPrices(completion: @escaping( _ response: WeeklyPrices?) -> ()) {
        let weeklyPricesURL = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_WEEKLY&symbol=MSFT&apikey=demo")!
        let weeklyPricesRequest = createGetRequest(url: weeklyPricesURL)
        AF.request(weeklyPricesRequest).validate().responseObject {  (dataResponse: AFDataResponse<WeeklyPrices>) in
            switch dataResponse.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getMonthlyPrices(completion: @escaping( _ response: MonthlyPrices?) -> ()) {
        let monthlyPricesURL = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=MSFT&apikey=demo")!
        let monthlyPricesRequest = createGetRequest(url: monthlyPricesURL)
        AF.request(monthlyPricesRequest).validate().responseObject {  (dataResponse: AFDataResponse<MonthlyPrices>) in
            switch dataResponse.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func createGetRequest(url: URL) -> URLRequestConvertible {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
