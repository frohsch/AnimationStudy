//
//  Transform3DChangeViewController.swift
//  AnimationStudy
//
//  Created by Minjoo Kim on 11/27/23.
//

import UIKit

import SnapKit
import Then

class Transform3DChangeViewController: UIViewController {
    
    private var returnButton = UIButton()
    private var boyImage = UIImageView(image: UIImage(named: "Boy"))
    private var axisSegment = UISegmentedControl(items: ["X-Axis", "Y-Axis", "Z-Axis"])
    private var axisLabel = UILabel()
    private var dividerSlider = UISlider()
    private var degreeSlider = UISlider()
    private var xSlider = UISlider()
    private var ySlider = UISlider()
    
    var transform = CATransform3DIdentity
    var divider: CGFloat = 500
    var degree: Double = 0
    var x: CGFloat = 1
    var y: CGFloat = 0
    var z: CGFloat = 0
    var anchorPointX = 0.5
    var anchorPointY = 0.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setHi()
        setLayout()
    }
    
    private func setStyle() {
        self.view.backgroundColor = .white
        
        returnButton.do {
            $0.setTitle("  재현씨 얼굴을 똑바로 되돌려놔!  ", for: .normal)
            $0.titleLabel?.font = UIFont(name: "Korail-Round-Gothic-Light", size: 20)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.backgroundColor = UIColor.brown.cgColor
            $0.layer.cornerRadius = 15
            $0.addTarget(self, action: #selector(returnBtn), for: .touchUpInside)
        }
        
        boyImage.do {
            $0.layer.transform = transform3D()
        }
        
        axisSegment.do {
            $0.selectedSegmentIndex = 0
            $0.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        }
        
        axisLabel.do {
            $0.font = UIFont(name: "Korail-Round-Gothic-Light", size: 18)
            $0.text = "💖x-axis 로 돌릴게요💖"
            $0.textColor = .darkGray
        }
        
        dividerSlider.do {
            $0.minimumValue = 100
            $0.maximumValue = 1000
            $0.value = Float(divider)
            $0.addTarget(self, action: #selector(dividerChanged(_:)), for: .valueChanged)
        }
        
        degreeSlider.do {
            $0.minimumValue = 0
            $0.maximumValue = 360
            $0.value = Float(degree)
            $0.addTarget(self, action: #selector(degreeChanged(_:)), for: .valueChanged)
        }
        
        xSlider.do {
            $0.minimumValue = 0.3
            $0.maximumValue = 0.8
            $0.value = Float(anchorPointX)
            $0.addTarget(self, action: #selector(anchorXChanged(_:)), for: .valueChanged)
        }
        
        ySlider.do {
            $0.minimumValue = 0.4
            $0.maximumValue = 0.8
            $0.value = Float(anchorPointY)
            $0.addTarget(self, action: #selector(anchorYChanged(_:)), for: .valueChanged)
        }
    }
    
    private func setHi() {
        self.view.addSubviews(returnButton, boyImage, axisSegment, axisLabel, dividerSlider, degreeSlider, xSlider, ySlider)
    }
    
    private func setLayout() {
        returnButton.snp.makeConstraints() {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(100)
        }
        
        boyImage.snp.makeConstraints() {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(180)
            $0.width.equalTo(300)
            $0.height.equalTo(250)
        }
        
        axisSegment.snp.makeConstraints() {
            $0.top.equalTo(boyImage.snp.bottom).offset(80)
            $0.centerX.equalToSuperview()
        }
        
        axisLabel.snp.makeConstraints() {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(axisSegment.snp.bottom).offset(30)
        }
        
        dividerSlider.snp.makeConstraints() {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(axisLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        degreeSlider.snp.makeConstraints() {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(dividerSlider.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        xSlider.snp.makeConstraints() {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(degreeSlider.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        ySlider.snp.makeConstraints() {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(xSlider.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    @objc
    private func returnBtn() {
        boyImage.layer.transform = CATransform3DIdentity
        dividerSlider.value = 500
        degreeSlider.value = 0
    }
    
    @objc
    private func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            axisLabel.text = "💖x-axis 로 돌릴게요💖"
            x = 1
            y = 0
            z = 0
        case 1:
            axisLabel.text = "💖y-axis 로 돌릴게요💖"
            x = 0
            y = 1
            z = 0
        case 2:
            axisLabel.text = "💖z-axis 로 돌릴게요💖"
            x = 0
            y = 0
            z = 1
        default:
            break
        }
        
        boyImage.layer.transform = transform3D()
    }
    
    @objc
    private func dividerChanged(_ sender: UISlider) {
        divider = CGFloat(sender.value)
        boyImage.layer.transform = transform3D()
    }
    
    @objc
    private func degreeChanged(_ sender: UISlider) {
        degree = Double(sender.value)
        boyImage.layer.transform = transform3D()
    }
    
    @objc
    private func anchorXChanged(_ sender: UISlider) {
        anchorPointX = Double(sender.value)
        boyImage.layer.transform = transform3D()
    }
    
    @objc
    private func anchorYChanged(_ sender: UISlider) {
        anchorPointY = Double(sender.value)
        boyImage.layer.transform = transform3D()
    }
}

extension Transform3DChangeViewController {
    func transform3D() -> CATransform3D {
        boyImage.layer.anchorPoint = CGPoint(x: anchorPointX, y: anchorPointY)
        
        transform = CATransform3DIdentity
        transform.m34 = -1.0/divider
        
        let rotateAngle = CGFloat((degree * Double.pi) / 180.0)
        transform = CATransform3DRotate(transform, rotateAngle, x, y, z)
        
        print("divider : \(divider)")
        print("degree : \(degree)")
        print("axis : \(x), \(y), \(z)")
        
        return transform
    }
}
