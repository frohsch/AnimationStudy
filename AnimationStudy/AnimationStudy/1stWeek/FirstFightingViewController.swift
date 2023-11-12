//
//  FirstFightingViewController.swift
//  AnimationStudy
//
//  Created by 김민주 on 11/12/23.
//

import UIKit

import SnapKit
import Then

class FirstFightingViewController: UIViewController {
    var state = true
    
    let lynxButton = UIButton()
    let crocodileButton = UIButton()
    let lynxImageView = UIImageView()
    let crocodileImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        didMoveTap()
    }
}

extension FirstFightingViewController {
    private func setUI() {
        view.backgroundColor = .white
        
        lynxButton.do {
            $0.setTitle("토스트 메시지 띄우기!!", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 17)
            $0.titleLabel?.textColor = .brown
            $0.layer.backgroundColor = UIColor.black.cgColor
            $0.shakeButton()
            $0.addTarget(self, action:  #selector(tappedButton), for: .touchUpInside)
        }
        
        crocodileButton.do {
            $0.setTitle("벌크업하기ㅋㅋ", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 17)
            $0.titleLabel?.textColor = .brown
            $0.layer.backgroundColor = UIColor.black.cgColor
            $0.addTarget(self, action: #selector(tappedButton2), for: .touchUpInside)
        }
        
        lynxImageView.do {
            $0.image = UIImage(named: "lynx")
        }
        
        crocodileImageView.do {
            $0.image = UIImage(named: "crocodile")
            $0.isHidden = true
        }
    }
    
    private func setLayout() {
        view.addSubviews(lynxButton, crocodileButton, lynxImageView ,crocodileImageView)
        
        lynxButton.snp.makeConstraints{
            $0.top.equalToSuperview().inset(400)
            $0.horizontalEdges.equalToSuperview().inset(80)
            $0.height.equalTo(50)
        }
        crocodileButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(470)
            $0.horizontalEdges.equalToSuperview().inset(80)
            $0.height.equalTo(50)
        }
        
        lynxImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(0)
            $0.size.equalTo(100)
        }
        
        crocodileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(600)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
    }
    
    private func didMoveTap() {
        //animate 기본
        UIView.animate(withDuration: 1.0, animations: { [self] in
            lynxImageView.frame.origin.x += 100
        })
        
        
        //CGAffineTransform
        UIView.animate(withDuration: 1.0) { [self] in
            lynxImageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        }
        UIView.animate(withDuration: 1.0) { [self] in
            lynxImageView.transform = CGAffineTransform(rotationAngle: .pi)
        }
        UIView.animate(withDuration: 1.0) { [self] in
            lynxImageView.transform = CGAffineTransform(translationX: 100, y: 100)
        }
        
        
        //animate Combine
        UIView.animate(withDuration: 2.0) { [self] in
            let scale =  CGAffineTransform(scaleX: 2.0, y: 2.0)
            let rotate = CGAffineTransform(rotationAngle: .pi)
            let translation = CGAffineTransform(translationX: 100, y: 200)
            
            let concatenate = scale.concatenating(rotate).concatenating(translation)
            lynxImageView.transform = concatenate
        }
        
        //animate 순차처리 - 1
        UIView.animate(withDuration: 2.0) { [self] in
            lynxImageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        } completion: { _ in
            UIView.animate(withDuration: 2.0) { [self] in
                lynxImageView.transform = CGAffineTransform(rotationAngle: .pi)
            } completion: { _ in
                UIView.animate(withDuration: 2.0) { [self] in
                    lynxImageView.transform = CGAffineTransform(translationX: 200, y: 200)
                }
            }
        }
        
        //animate 순차처리 - 2
        UIView.animateKeyframes(withDuration: 3.0, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3) { [self] in
                lynxImageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            }
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) { [self] in
                lynxImageView.transform = CGAffineTransform(rotationAngle: .pi)
            }
            UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) { [self] in
                lynxImageView.transform = CGAffineTransform(translationX: 50, y: 200)
            }
        }
        
        //modifyAnimations
        UIView.animate(withDuration: 1.0) { [self] in
            UIView.modifyAnimations(withRepeatCount: 3.0, autoreverses: true) {
                lynxImageView.frame.origin.x += 50
            }
        }
        
        //springDuration
        UIView.animate(springDuration: 2.0, bounce: 0.5) {
            lynxImageView.center.y += 100
        }
    }
    
    @objc private func tappedButton() {
        view.showToast(message: "안뇽???????")
    }
    
    @objc private func tappedButton2() {
        crocodileImageView.isHidden = false
        crocodileImageView.shakeImageView()
        UIView.animate(withDuration: 1.0) { [self] in
            crocodileImageView.transform = CGAffineTransform(scaleX: state ? 2.0 : 1.0, y: state ? 1.2 : 1.0)
        }
        
        UIView.transition(with: crocodileImageView, duration: 0.6, options: .transitionFlipFromLeft, animations: nil)
        state.toggle()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.crocodileButton.setTitle(self.state ? "벌크업 하기" : "다이어트 하기", for: .normal)
        }
    }
}
