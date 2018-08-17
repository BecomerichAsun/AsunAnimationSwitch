//
//  AsunBasic.swift
//  ani
//
//  Created by 钟宏阳 on 2018/8/17.
//  Copyright © 2018年 Asun. All rights reserved.
//

import Foundation
import UIKit

protocol AsunBasic {
    /**  线宽  **/
    var lineWidth: CGFloat {get set}
    /**  动画结束位置  **/
    var finalStrokeEndForCheckmark: CGFloat {get set}
    /**  动画开始位置  **/
    var finalStrokeStartForCheckmark: CGFloat {get set}
    /**  动画增加距离  **/
    var checkmarkBounceAmount: CGFloat {get set}
    /**  动画持续时间  **/
    var animationDuration: CFTimeInterval {get set}
    /**  默认以及动画结束后标记的颜色  **/
    var strokeColor: UIColor {get set}
    /** 动画结束后的圆圈颜色  **/
    var trailStrokeColor: UIColor {get set}
    
    /**更变以上属性**/
    mutating func setEndValue(value:CGFloat)
    mutating func setStartValue(value:CGFloat)
    mutating func setAddValue(value:CGFloat)
    mutating func setDuration(value:CGFloat)
    mutating func setLineWidth(value:CGFloat)
    mutating func setStrokeColor(color:UIColor)
    mutating func setTrailColor(color:UIColor)
}

struct AsunBasicSet:AsunBasic {
    var strokeColor: UIColor = UIColor.red
    var trailStrokeColor: UIColor = UIColor.blue
    var finalStrokeEndForCheckmark: CGFloat = 0.85
    var finalStrokeStartForCheckmark: CGFloat = 0.3
    var checkmarkBounceAmount: CGFloat = 0.1
    var animationDuration: CFTimeInterval = 0.8
    var lineWidth:CGFloat = 2
    
    mutating func setEndValue(value: CGFloat) {
        finalStrokeEndForCheckmark = value
    }
    
    mutating func setStartValue(value: CGFloat) {
        finalStrokeStartForCheckmark = value
    }
    
    mutating func setAddValue(value: CGFloat) {
        checkmarkBounceAmount = value
    }
    
    mutating func setDuration(value: CGFloat) {
        animationDuration = CFTimeInterval(value)
    }
    
    mutating func setLineWidth(value: CGFloat) {
        lineWidth = value
    }
    
    mutating func setStrokeColor(color: UIColor) {
        strokeColor = color
    }
    
    mutating func setTrailColor(color: UIColor) {
        trailStrokeColor = color
    }
}


