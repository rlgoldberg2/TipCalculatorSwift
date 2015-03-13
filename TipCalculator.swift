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
