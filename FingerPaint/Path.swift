//
//  Path.swift
//  FingerPaint
//
//  Created by darkgod on 14/11/5.
//  Copyright (c) 2014年 darkgod. All rights reserved.
//

import UIKit

class Path {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    var points: [CGPoint] = []
    let color: UIColor
    init(color: UIColor) {
        self.color = color
    }

    func add(point: CGPoint) {
        points.append(point)
    }
}
