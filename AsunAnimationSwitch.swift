
//
//  AsunSwitch.Swift
//  AsunAnimationSwitch
//
//  Created by Asun on 2018/8/14.
//  Copyright © 2018年 Asun. All rights reserved.
//

import UIKit

public class AsunAnimationSwitch: UIControl {
    
    public var Basic:AsunBasicSet = AsunBasicSet()
    
    private var trailCircle: CAShapeLayer = CAShapeLayer()
    private var circle: CAShapeLayer = CAShapeLayer()
    private var checkmark: CAShapeLayer = CAShapeLayer()
    private var checkmarkMidPoint: CGPoint = CGPoint.zero
    private var selected_internal: Bool = false
    
    public override var isSelected: Bool {
        get {
            return selected_internal
        }
        set {
            super.isSelected = newValue
            //todo
            self.setSelected(isSelected: newValue, animated: false)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    public override func awakeFromNib() {
        setupViews()
    }
    
    public override func layoutSubviews() {
        configure()
    }
    
    public func setupViews() {
        self.backgroundColor = UIColor.clear
        configureShapeLayer(shapeLayer: trailCircle)
        configureShapeLayer(shapeLayer: circle)
        configureShapeLayer(shapeLayer: checkmark)
        self.isSelected = false
        self.addTarget(self, action: #selector(onTouchUpInside), for: UIControlEvents.touchUpInside)
    }
    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        if layer == self.layer {
            var offset: CGPoint = CGPoint.zero
            let radius = fmin(self.bounds.width, self.bounds.height)/2
            offset.x = (self.bounds.width - radius * 2) / 2.0
            offset.y = (self.bounds.height - radius * 2) / 2.0
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            
            let ovalRect = CGRect(x: offset.x, y: offset.y, width: radius*2, height: radius*2)
            
            let circlePath = UIBezierPath(ovalIn: ovalRect)
            
            trailCircle.path = circlePath.cgPath
            
            circle.transform = CATransform3DIdentity
            
            circle.frame = self.bounds
            circle.path = UIBezierPath(ovalIn: ovalRect).cgPath
            circle.transform = CATransform3DMakeRotation(CGFloat(212 * Double.pi / 180), 0, 0, 1)
            let origin = CGPoint(x: offset.x + radius, y: offset.y + radius)
            var checkStartPoint = CGPoint.zero
            checkStartPoint.x = origin.x + radius * CGFloat(cos(212 * Double.pi / 180))
            checkStartPoint.y = origin.y + radius * CGFloat(sin(212 * Double.pi / 180))
            
            let checkmarkPath = UIBezierPath()
            checkmarkPath.move(to: checkStartPoint)
            
            self.checkmarkMidPoint = CGPoint(x: offset.x + radius * 0.9, y: offset.y + radius * 1.4)
            checkmarkPath.addLine(to: self.checkmarkMidPoint)
            
            var checkEndPoint = CGPoint.zero
            checkEndPoint.x = origin.x + radius * CGFloat(cos(320 * Double.pi / 180))
            checkEndPoint.y = origin.y + radius * CGFloat(sin(320 * Double.pi / 180))
            
            checkmarkPath.addLine(to: checkEndPoint)
            
            checkmark.frame = self.bounds
            checkmark.path = checkmarkPath.cgPath
            
            CATransaction.commit()
        }
    }
    
    private func configure() {
        self.circle.lineWidth = Basic.lineWidth
        self.checkmark.lineWidth = Basic.lineWidth
        self.trailCircle.lineWidth = Basic.lineWidth
        self.circle.strokeColor = Basic.strokeColor.cgColor
        self.checkmark.strokeColor = Basic.strokeColor.cgColor
        self.trailCircle.strokeColor = Basic.trailStrokeColor.cgColor
    }
    
    @objc func onTouchUpInside(sender: AnyObject) {
        self.setSelected(isSelected: !self.isSelected, animated: true)
        self.sendActions(for: UIControlEvents.valueChanged)
    }
    
    public func setSelected(isSelected: Bool, animated: Bool) {
        self.selected_internal = isSelected
        
        checkmark.removeAllAnimations()
        circle.removeAllAnimations()
        trailCircle.removeAllAnimations()
        
        self.resetValues(animated: animated)
        
        if animated {
            self.addAnimationsForSelected(selected: selected_internal)
        }
    }
    
    private func configureShapeLayer(shapeLayer: CAShapeLayer) {
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineWidth = Basic.lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(shapeLayer)
    }
    
    private func resetValues(animated: Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if (selected_internal && animated) || (selected_internal == false && animated == false)  {
            checkmark.strokeEnd = 0.0
            checkmark.strokeStart = 0.0
            trailCircle.opacity = 0.0
            circle.strokeStart = 0.0
            circle.strokeEnd = 1.0
        } else {
            checkmark.strokeEnd = Basic.finalStrokeEndForCheckmark
            checkmark.strokeStart = Basic.finalStrokeStartForCheckmark
            trailCircle.opacity = 1.0
            circle.strokeStart = 0.0
            circle.strokeEnd = 0.0
        }
        
        CATransaction.commit()
    }
    
    private func addAnimationsForSelected(selected: Bool) {
        let circleAnimationDuration = Basic.animationDuration * 0.5
        
        let checkmarkEndDuration = Basic.animationDuration * 0.8
        let checkmarkStartDuration = checkmarkEndDuration - circleAnimationDuration
        let checkmarkBounceDuration = Basic.animationDuration - checkmarkEndDuration
        
        let checkmarkAnimationGroup = CAAnimationGroup()
        checkmarkAnimationGroup.isRemovedOnCompletion = false
        checkmarkAnimationGroup.fillMode = kCAFillModeForwards
        checkmarkAnimationGroup.duration = Basic.animationDuration
        checkmarkAnimationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let checkmarkStrokeEnd = CAKeyframeAnimation(keyPath: "strokeEnd")
        checkmarkStrokeEnd.duration = checkmarkEndDuration + checkmarkBounceDuration
        checkmarkStrokeEnd.isRemovedOnCompletion = false
        checkmarkStrokeEnd.fillMode = kCAFillModeForwards
        checkmarkStrokeEnd.calculationMode = kCAAnimationPaced
        
        if selected {
            checkmarkStrokeEnd.values = [NSNumber(value: 0.0), NSNumber(value: Float(Basic.finalStrokeEndForCheckmark + Basic.checkmarkBounceAmount)), NSNumber(value: Float(Basic.finalStrokeEndForCheckmark))]
            checkmarkStrokeEnd.keyTimes = [NSNumber(value: 0.0), NSNumber(value: checkmarkEndDuration), NSNumber(value: checkmarkEndDuration + checkmarkBounceDuration)]
        } else {
            checkmarkStrokeEnd.values = [ NSNumber(value: Float(Basic.finalStrokeEndForCheckmark)), NSNumber(value: Float(Basic.finalStrokeEndForCheckmark + Basic.checkmarkBounceAmount)), NSNumber(value: -0.1)]
            checkmarkStrokeEnd.keyTimes = [NSNumber(value: 0.0), NSNumber(value: checkmarkBounceDuration), NSNumber(value: checkmarkEndDuration + checkmarkBounceDuration)]
        }
        
        let checkmarkStrokeStart = CAKeyframeAnimation(keyPath: "strokeStart")
        checkmarkStrokeStart.duration = checkmarkStartDuration + checkmarkBounceDuration
        checkmarkStrokeStart.isRemovedOnCompletion = false
        checkmarkStrokeStart.fillMode = kCAFillModeForwards
        checkmarkStrokeStart.calculationMode = kCAAnimationPaced
        
        if selected {
            checkmarkStrokeStart.values = [ NSNumber(value: 0.0), NSNumber(value: Float(Basic.finalStrokeStartForCheckmark + Basic.checkmarkBounceAmount)), NSNumber(value: Float(Basic.finalStrokeStartForCheckmark))]
            checkmarkStrokeStart.keyTimes = [NSNumber(value: 0.0), NSNumber(value: checkmarkStartDuration), NSNumber(value: checkmarkStartDuration + checkmarkBounceDuration)]
        } else {
            checkmarkStrokeStart.values = [NSNumber(value: Float(Basic.finalStrokeStartForCheckmark)), NSNumber(value: Float(Basic.finalStrokeStartForCheckmark + Basic.checkmarkBounceAmount)), NSNumber(value: 0.0)]
            checkmarkStrokeStart.keyTimes = [NSNumber(value: 0.0), NSNumber(value: checkmarkBounceDuration), NSNumber(value: checkmarkStartDuration + checkmarkBounceDuration)]
        }
        
        if selected {
            checkmarkStrokeStart.beginTime = circleAnimationDuration
        }
        
        checkmarkAnimationGroup.animations = [checkmarkStrokeEnd, checkmarkStrokeStart]
        checkmark.add(checkmarkAnimationGroup, forKey: "checkmarkAnimation")
        
        let circleAnimationGroup = CAAnimationGroup()
        circleAnimationGroup.duration = Basic.animationDuration
        circleAnimationGroup.isRemovedOnCompletion = false
        circleAnimationGroup.fillMode = kCAFillModeForwards
        circleAnimationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let circleStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        circleStrokeEnd.duration = circleAnimationDuration
        if selected {
            circleStrokeEnd.beginTime = 0.0
            
            circleStrokeEnd.fromValue = NSNumber(value: 1.0)
            circleStrokeEnd.toValue = NSNumber(value: -0.1)
        } else {
            circleStrokeEnd.beginTime = Basic.animationDuration - circleAnimationDuration
            
            circleStrokeEnd.fromValue = NSNumber(value: 0.0)
            circleStrokeEnd.toValue = NSNumber(value: 1.0)
        }
        circleStrokeEnd.isRemovedOnCompletion = false
        circleStrokeEnd.fillMode = kCAFillModeForwards
        
        circleAnimationGroup.animations = [circleStrokeEnd]
        circle.add(circleAnimationGroup, forKey: "circleStrokeEnd")
        
        let trailCircleColor = CABasicAnimation(keyPath: "opacity")
        trailCircleColor.duration = Basic.animationDuration
        if selected {
            trailCircleColor.fromValue = NSNumber(value: 0.0)
            trailCircleColor.toValue = NSNumber(value: 1.0)
        } else {
            trailCircleColor.fromValue = NSNumber(value: 1.0)
            trailCircleColor.toValue = NSNumber(value: 0.0)
        }
        trailCircleColor.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        trailCircleColor.fillMode = kCAFillModeForwards
        trailCircleColor.isRemovedOnCompletion = false
        trailCircle.add(trailCircleColor, forKey: "trailCircleColor")
    }    
}
