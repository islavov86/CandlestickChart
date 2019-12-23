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
    
    @IBOutlet var chartView: CandleStickChartView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var dailyPrices: [String : PricesListObject]?
    var weeklyPrices: [String : PricesListObject]?
    var monthlyPrices: [String : PricesListObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupChart()
    }
    
    func getData() {
        let group = DispatchGroup()
        self.activityIndicator.startAnimating()
        group.enter()
        PriceService.instance.getDailyPrices { (dailyPrices) in
            self.dailyPrices = dailyPrices!.dailyPricesArray
            group.leave()
        }
        group.enter()
        PriceService.instance.getWeeklyPrices { (weeklyPrices) in
            self.weeklyPrices = weeklyPrices!.weeklyPricesArray
            group.leave()
        }
        group.enter()
        PriceService.instance.getMonthlyPrices { (monthlyPrices) in
            self.monthlyPrices = monthlyPrices!.monthlyPricesArray
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("requests done")
            self.activityIndicator.stopAnimating()
            self.setDataCount(prices: self.dailyPrices!)
            
        }
    }
    
    func setupChart() {
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = true
        
        chartView.drawGridBackgroundEnabled = false
        chartView.drawMarkers = true
        
        chartView.setScaleEnabled(true)
        chartView.maxVisibleCount = 500
        chartView.pinchZoomEnabled = true
        
        chartView.legend.enabled = false
        
        chartView.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        chartView.leftAxis.spaceTop = 0.3
        chartView.leftAxis.spaceBottom = 0.3
        chartView.leftAxis.axisMinimum = 0
        
        chartView.rightAxis.enabled = false
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 8)!
    }
    
    func setDataCount(prices: [String : PricesListObject]) {
        chartView.clear()
        let keys = prices.keys.sorted()
        let yVals1 = (0..<keys.count).map { (i) -> CandleChartDataEntry in
            let price = prices[keys[i]]!
            let high = price.high
            let low = price.low
            let open = price.open
            let close = price.close
            let even = i % 2 == 0
            return CandleChartDataEntry(x: Double(i), shadowH: high, shadowL: low, open: even ? open : open, close: even ? close : close, icon: UIImage(named: "icon")!)
        }
        
        let set1 = CandleChartDataSet(entries: yVals1, label: "Data Set")
        
        set1.axisDependency = .left
        set1.setColor(UIColor(white: 80/255, alpha: 1))
        set1.drawIconsEnabled = false
        set1.shadowColor = .darkGray
        set1.shadowWidth = 0.7
        set1.decreasingColor = .red
        set1.decreasingFilled = true
        set1.increasingColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1)
        set1.increasingFilled = true
        set1.neutralColor = .blue
        
        set1.drawValuesEnabled = false
        
        let data = CandleChartData(dataSet: set1)
        chartView.data = data
        chartView.setVisibleXRangeMinimum(20.0)
        chartView.setVisibleXRangeMaximum(20.0)
        chartView.moveViewToX(Double(keys.count))
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: keys)
        
    }
}

//MARK: - EVENTS
extension ChartVC {
    
    @IBAction func dailyBtnClicked(_ sender: UIButton) {
        self.setDataCount(prices: self.dailyPrices!)
    }
    
    @IBAction func weeklyBtnClicked(_ sender: UIButton) {
        self.setDataCount(prices: self.weeklyPrices!)
    }
    
    @IBAction func monthlyBtnClicked(_ sender: UIButton) {
        self.setDataCount(prices: self.monthlyPrices!)
    }
}
