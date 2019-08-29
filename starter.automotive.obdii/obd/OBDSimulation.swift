/**
 * Copyright 2019 IBM Corp. All Rights Reserved.
 *
 * Licensed under the IBM License, a copy of which may be obtained at:
 *
 * https://github.com/ibm-watson-iot/iota-starter-obd-ios/blob/master/LICENSE
 *
 * You may not use this file except in compliance with the license.
 */

import Foundation

class OBDSimulation {
    weak var delegate: OBDStreamDelegate?
    private var fuelLevel: Double?
    private var engineCoolant: Double?
    private var engineRPM: Double?
    private var engineOilTemp: Double?
    
    func connect() {
        fuelLevel = Double(arc4random_uniform(50) + 10)
        engineRPM = round(Double(arc4random_uniform(2000))/100)*100 + 2000
        engineOilTemp = Double(Int(arc4random_uniform(115) + 50))
        engineCoolant = Double(Int(arc4random_uniform(115) + 50))
        updateTable()
    }
    
    func updateSimulatedValues() {
        fuelLevel = fuelLevel! - round(Double(arc4random_uniform(10))/10.0)
        if fuelLevel! < 5.0 {
            fuelLevel = Double(arc4random_uniform(50) + 10)
        }
        engineRPM = engineRPM! + round(Double(arc4random_uniform(400))/100)*100 - 200
        if engineRPM! < 0.0 || engineRPM! > 8000.0 {
            engineRPM = Double(arc4random_uniform(2000) + 1000)
        }
        engineOilTemp = engineOilTemp! + Double(arc4random_uniform(500)/10) - 20.0
        if engineOilTemp! < -10.0 || engineOilTemp! > 350.0 {
            engineOilTemp = Double(Int(arc4random_uniform(115) + 50))
        }
        engineCoolant = engineCoolant! + Double(arc4random_uniform(500)/10) - 20.0
        if engineCoolant! < -10.0 || engineCoolant! > 350.0 {
            engineCoolant = Double(Int(arc4random_uniform(115) + 50))
        }
        updateTable()
    }
    
    private func updateTable() {
        var speed = ViewController.location?.speed ?? 0
        if (speed < 0) {
            speed = 0
        }
        let currentSpeed: Int = Int(round(speed));
        ViewController.tableItemsValues = ["\(currentSpeed)", "\(engineRPM!)", "\(fuelLevel!)", "\(engineOilTemp!)", "\(engineCoolant!)"]
        delegate?.updateOBDValues()
    }

}
