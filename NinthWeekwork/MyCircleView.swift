//
//  MyCircleView.swift
//  NinthWeekwork
//
//  Created by fanyunyimac on 2018/11/9.
//  Copyright © 2018年 范云翼. All rights reserved.
//

import UIKit

@IBDesignable
class MyCircleView: UIView {
    
        @IBInspectable var myColor: UIColor?
        //构造函数中的方法
        func setup() {
            //在自定义视图中设置手势
            //设置一个UIPanGestureRecognizer(可以到处拖动)实例
            let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:)))
            //在本视图中添加pan手势
            self.addGestureRecognizer(panRecognizer)
            //设置一个UIPinchGestureRecognizer(可以缩放大小)实例
            let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch(recognizer:)))
            //在本视图中添加pinch手势
            self.addGestureRecognizer(pinchRecognizer)
            //设置一个UITapGestureRecognizer(可以次数点击)实例
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(recognizer:)))
            //在本视图中添加tag手势
            self.addGestureRecognizer(tapRecognizer)
            //设置为双击
            tapRecognizer.numberOfTapsRequired = 2
            //增加rotate旋转手势
            let rotateGuesture = UIRotationGestureRecognizer(target: self, action: #selector(rotate(recognizer:)))
            self.addGestureRecognizer(rotateGuesture)
            //rotateGuesture.delegate = ViewController
        }
        //与panRecognizer对应的自定义的pan方法
        @objc func pan(recognizer: UIPanGestureRecognizer) {
            if recognizer.state == .changed  || recognizer.state == .ended {
                //拖动的距离
                let translation = recognizer.translation(in: self)
                //拖动后的位置
                self.center.x += translation.x
                self.center.y += translation.y
                //重置拖动距离为0，不然就会变化距离不断增大
                recognizer.setTranslation(.zero, in: self)
            }
        }
        //与pinchRecognizer对应的自定义的pinch方法
        @objc func pinch(recognizer: UIPinchGestureRecognizer) {
            if recognizer.state == .changed  || recognizer.state == .ended {
                bounds = CGRect(x: 0, y: 0, width: bounds.width * recognizer.scale, height: bounds.height * recognizer.scale)
                recognizer.scale = 1
                
            }
        }
        //与tapRecognizer对应的自定义的tag方法
        @objc func tap(recognizer: UITapGestureRecognizer) {
            if recognizer.state == .recognized {
                print("我被点击了！！!")
            }
        }
        //与rotateRecognizer对应的自定义的tag方法
        @objc func rotate(recognizer: UIRotationGestureRecognizer) {
            let rotation = recognizer.rotation
            //要写成这种形式,因为rotated返回的是CGAffineTransform
            self.transform = self.transform.rotated(by: rotation)
            recognizer.rotation = 0
        }
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
        
        // Only override draw() if you perform custom drawing.
        // An empty implementation adversely affects performance during animation.
        override func draw(_ rect: CGRect) {
            //画圆
            let path = UIBezierPath(ovalIn: rect)
            UIColor.blue.setStroke()
            path.stroke()
            myColor = UIColor.red
            myColor!.setFill()
            path.fill()
        }
}
