//
//  BezierVC.swift
//  AnimationStudy
//
//  Created by Minjoo Kim on 11/27/23.
//

import UIKit

// 사용자 정의 UIView 서브클래스
class Bezier: UIView {
    
    override func draw(_ rect: CGRect) {
        
        UIColor.red.setStroke()
        
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 100, y: 200))
        //addLine = 직선
        //addCurve = 곡선
        //addQuadCurve = n차 곡선
        
        bezierPath.addLine(to: CGPoint(x: 200, y: 250))
        bezierPath.addCurve(to: CGPoint(x: 160, y: 140),
                            controlPoint1: CGPoint(x: 200, y: 80),
                            controlPoint2: CGPoint(x: 160, y: 80))
        bezierPath.addQuadCurve(to: CGPoint(x: 40, y: 140),
                                controlPoint: CGPoint(x: 100, y: 200))
        bezierPath.close()
        bezierPath.stroke()

    }
}

class BezierVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bezierView = Bezier()
        bezierView.frame = CGRect(x: 0, y: 250, width: 500, height: 500)
        bezierView.backgroundColor = .white
        self.view.addSubview(bezierView)
    }
}

