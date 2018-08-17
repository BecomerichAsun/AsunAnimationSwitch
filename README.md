# AsunAnimationSwitch-Swift
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/dearmiku/MK_Text/master/LICENSE) [![Support](https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/) 



# Features
> Support Click animation derived from native animation
>
>
> You can import this framework using cocoapods
>
> 


# The effect
![imag](https://github.com/BecomerichAsun/AsunAnimationSwitch/blob/master/Images/The%20effect.gif)

# Usage
## 


```
  let asun = AsunAnimationSwitch(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        asun.Basic.setDuration(value: 0.5)
        asun.Basic.setEndValue(value: 0.8)
        asun.Basic.setStartValue(value: 0.3)
        asun.Basic.setLineWidth(value: 4)
        asun.Basic.setAddValue(value: 0)
        asun.Basic.setStrokeColor(color: UIColor.blue)
        asun.Basic.setTrailColor(color: UIColor.red)
        view.addSubview(asun)
        asun.setSelected(isSelected: !asun.isSelected, animated: true)
```



## Basic
## 


```
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
```
## ChangeBasic
## 


```
    mutating func setEndValue(value:CGFloat)
    mutating func setStartValue(value:CGFloat)
    mutating func setAddValue(value:CGFloat)
    mutating func setDuration(value:CGFloat)
    mutating func setLineWidth(value:CGFloat)
    mutating func setStrokeColor(color:UIColor)
    mutating func setTrailColor(color:UIColor)
```

# Install
## CocoaPods
Add pod 'AsunAnimationSwitch' in Podfile


# System Requirements
 iOS 8.0

