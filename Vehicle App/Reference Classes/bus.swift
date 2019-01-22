//
//  startDate.swift
//  Vehicle App
//
//  Created by Timothy P. Konopacki on 11/7/18.
//  Copyright © 2018 TK. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class Bus
{
    var availability:Bool
    var licensePlate:String
    var checkoutUser:String
    var dateIn:String
    var dateOut:String
    var timeIn:Int
    var timeOut:Int
    var key:String
    var requested:Bool
    init(availability a:Bool, licensePlate lp:String, checkoutUser cu:String, dateIn di:String, dateOut dot:String, timeIn ti:Int, timeOut to:Int, ky:String, requested re: Bool) {
        availability = a
        licensePlate = lp
        checkoutUser = cu
        dateIn = di
        dateOut = dot
        timeIn = ti
        timeOut = to
        key = ky
        requested = re
}
    
}
