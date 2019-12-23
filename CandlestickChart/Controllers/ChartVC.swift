//
//  ViewController.swift
//  CandlestickChart
//
//  Created by Ivan Slavov on 21.12.19.
//  Copyright © 2019 Ivan Slavov. All rights reserved.
//

import UIKit
import Charts

class ChartVC: UIViewController {
    
    var priceService: PriceService?
    
    var dailyPrices: DailyPrices?
    var weeklyPrices: WeeklyPrices?
    var monthlyPrices: MonthlyPrices?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData() {
        let group = DispatchGroup()
       
        group.enter()
        PriceService.instance.getDailyPrices { (dailyPrices) in
            self.dailyPrices = dailyPrices
            group.leave()
        }
        group.enter()
        PriceService.instance.getWeeklyPrices { (weeklyPrices) in
            self.weeklyPrices = weeklyPrices
            group.leave()
        }
        group.enter()
        PriceService.instance.getMonthlyPrices { (monthlyPrices) in
            self.monthlyPrices = monthlyPrices
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("requests done")
        }
    }
    
}

