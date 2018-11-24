//
//  ViewController.swift
//  NinthWeekwork
//
//  Created by fanyunyimac on 2018/11/9.
//  Copyright © 2018年 范云翼. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func AddItem(_ sender: Any) {
        //随机生成x y
        let x = Int(arc4random()) % Int(self.view.bounds.width)
        let y = Int(arc4random()) % Int(self.view.bounds.height)
        //添加label
        let label = UILabel(frame: CGRect(x: x, y: y, width: 40, height: 40))
        label.text = "fyy"
        label.textAlignment = .center
        label.backgroundColor = UIColor.yellow
        //设置label的隐影
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 10, height: 10)
        label.layer.shadowOpacity = 1
        //在viewController中添加手势及相应
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:)))
        label.addGestureRecognizer(panRecognizer)
        //设置label为可互动
        label.isUserInteractionEnabled = true
        //在本视图中添加pinch手势
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch(recognizer:)))
        label.addGestureRecognizer(pinchRecognizer)
        //添加tap手势
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(recognizer:)))
        label.addGestureRecognizer(tapRecognizer)
        //设置单机次数为2
        tapRecognizer.numberOfTapsRequired = 2
        //设置rotate手势
        let rotateRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotate(recognizer:)))
        label.addGestureRecognizer(rotateRecognizer)
        rotateRecognizer.delegate = self
        
        self.view.addSubview(label)
        
    }
    //拖动视图
    @objc func pan(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .changed  || recognizer.state == .ended {
            let translation = recognizer.translation(in: self.view)
            recognizer.view?.center.x += translation.x
            recognizer.view?.center.y += translation.y
            recognizer.setTranslation(.zero, in: self.view)
        }
    }
    //点击就把recognizer对应的view删除掉
    @objc func tap(recognizer: UITapGestureRecognizer) {
        if recognizer.state == .recognized {
            recognizer.view?.removeFromSuperview()
            
        }
    }
    //与pinchRecognizer对应的自定义的pinch方法
    @objc func pinch(recognizer: UIPinchGestureRecognizer) {
        if recognizer.state == .changed  || recognizer.state == .ended {
            recognizer.view?.bounds = CGRect(x: 0, y: 0, width: (recognizer.view?.bounds.width)! * recognizer.scale, height: (recognizer.view?.bounds.height)! * recognizer.scale)
            recognizer.scale = 1
        }
    }
    //旋转
    @objc func rotate(recognizer: UIRotationGestureRecognizer){
        recognizer.view?.transform = (recognizer.view?.transform.rotated(by: recognizer.rotation))!
        recognizer.rotation = 0
    }
    
    //移动
    @IBAction func MoveItems(_ sender: Any) {
        for label in self.view.subviews {
            if label is UILabel {
                UIView.animate(withDuration: 1) {
                    let x = Int(arc4random()) % Int(self.view.bounds.width)
                    let y = Int(arc4random()) % Int(self.view.bounds.height)
                    label.center = CGPoint(x: x, y: y)
                }
            }
        }
    }
    //删除
    @IBAction func DeleteItems(_ sender: Any) {
        for label in self.view.subviews {
            if label is UILabel {
                label.removeFromSuperview()
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

