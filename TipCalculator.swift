//
//  TipCalculator.swift
//  TipCalculator
//
//  Created by Richard Goldberg on 2/14/15.
//  Copyright (c) 2015 Richard Goldberg. All rights reserved.
//

import Foundation

class TipCalculatorModel {
    var total: Double
    var taxPct: Double
    var subtotal: Double {
        get {
            return total/(taxPct + 1)
        }
    }
    
    init (total:Double, taxPct:Double) {
        self.total = total
        self.taxPct = taxPct
    }
    
    func calcWithTipPct (tipPct:Double) -> (tipAmt:Double, tipTotal:Double) {
        let tipAmt = self.subtotal * tipPct
        let finalTotal = total + tipAmt
        return (tipAmt, finalTotal)
    }
    
    func returnPossibleTips() -> [Int:(tipAmt:Double, tipTotal:Double)] {
        let possibleTipsInferred = [0.15, 0.18, 0.20]
        var retVal = Dictionary <Int, (tipAmt:Double, tipTotal:Double)>()
        for possibleTip in possibleTipsInferred {
            let intPct = Int (possibleTip*100)
            retVal[intPct] = calcWithTipPct(possibleTip)
        }
        return retVal
        
    }
}
/*
import UIKit

class TestDataSource: NSObject {
    let tipCalc = TipCalculatorModel (total: 33.25, taxPct: 0.06)
    var possibleTips = Dictionary<Int, (tipAmt:Double, tipTotal: Double)>()
    
    var sortedKeys:[Int] = []
    
    override init() {
        possibleTips = tipCalc.returnPossibleTips()
        sortedKeys = sorted(Array(possibleTips.keys))
        super.init()
        
    }
    

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedKeys.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: nil)
        let tipPct = sortedKeys[indexPath.row]
        let tipAmt = possibleTips[tipPct]!.tipAmt
        let total = possibleTips[tipPct]!.tipTotal
        
        cell.textLabel?.text = "\(tipPct)%:"
        cell.detailTextLabel?.text = String(format:"Tip:$%0.2f, Total: $%0.2f", tipAmt,total)
        return cell
    }

}
*/