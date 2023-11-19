//
//  SecondFightingViewController.swift
//  AnimationStudy
//
//  Created by Minjoo Kim on 11/19/23.
//

import UIKit

class SecondFightingViewController: UIViewController {
    
    var score: Int = 0
    var timer: Timer? = nil
    var isPause: Bool = true
    
    private lazy var santa = UIImageView(image: UIImage(named: "santa"))
    private let topToast = UIImageView(image: UIImage(named: "bauble"))
    private let bottomToast = UIImageView(image: UIImage(named: "candy-stick"))
    private let leadingToast = UIImageView(image: UIImage(named: "gift"))
    private let trailingToast = UIImageView(image: UIImage(named: "gift"))
    private let scoreLabel = UILabel().then {
        $0.textAlignment = .center
        $0.text = "Hi"
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .brown
        $0.numberOfLines = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setLayout()
        setToast()
        startTimer()
        target()
    }
    
    private func target() {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(viewPan(_:)))
        santa.addGestureRecognizer(gesture)
        santa.isUserInteractionEnabled = true
    }
    
    @objc
    private func viewPan(_ sender: UIPanGestureRecognizer) {
        let transition = sender.translation(in: santa)
        let changedX = santa.center.x + transition.x
        let changedY = santa.center.y + transition.y
        
        self.santa.center = .init(x: changedX,
                                    y: changedY)
        sender.setTranslation(.zero, in: self.santa)
    }
    
    private func startTimer() {
        guard timer == nil else { return }
        self.timer = Timer.scheduledTimer(timeInterval: 0.5,
                                          target: self,
                                          selector: #selector(self.moveToast),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func setLayout() {
        self.view.addSubview(santa)
        self.view.addSubview(scoreLabel)
        santa.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        scoreLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
        }
    }
    
    private func setToast() {
        self.view.addSubview(topToast)
        self.view.addSubview(bottomToast)
        self.view.addSubview(leadingToast)
        self.view.addSubview(trailingToast)
        
        topToast.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        leadingToast.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        trailingToast.snp.makeConstraints {
            $0.trailing.centerY.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        bottomToast.snp.makeConstraints {
            $0.bottom.centerX.equalToSuperview()
            $0.width.height.equalTo(50)
        }
    }
    
    @objc
    private func moveToast() {
        var topToastY = self.topToast.frame.origin.y
        topToastY += 10
        self.topToast.frame = .init(origin: .init(x: self.topToast.frame.origin.x,
                                                  y: topToastY),
                                    size: self.topToast.frame.size)
        
        var bottomToastY = self.bottomToast.frame.origin.y
        bottomToastY -= 10
        self.bottomToast.frame = .init(origin: .init(x: self.bottomToast.frame.origin.x,
                                                     y: bottomToastY),
                                       size: self.bottomToast.frame.size)
        
        var leftToastX = self.leadingToast.frame.origin.x
        leftToastX += 10
        self.leadingToast.frame = .init(origin: .init(x: leftToastX,
                                                      y: self.leadingToast.frame.origin.y),
                                        size: self.leadingToast.frame.size)
        
        var rightToastX = self.trailingToast.frame.origin.x
        rightToastX -= 10
        self.trailingToast.frame = .init(origin: .init(x: rightToastX,
                                                       y: self.trailingToast.frame.origin.y),
                                         size: self.trailingToast.frame.size)
        self.calculatePositionReached()
    }
    
    private func calculatePositionReached() {
        if self.santa.frame.minX <= self.topToast.frame.minX &&
            self.santa.frame.maxX >= self.topToast.frame.maxX &&
            self.santa.frame.minY <= self.topToast.frame.minY &&
            self.santa.frame.maxY >= self.topToast.frame.maxY
        {
            self.scoreLabel.text = "ByeBye\nScore:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
        
        if self.santa.frame.minX <= self.leadingToast.frame.minX &&
            self.santa.frame.maxX >= self.leadingToast.frame.maxX &&
            self.santa.frame.minY <= self.leadingToast.frame.minY &&
            self.santa.frame.maxY >= self.leadingToast.frame.maxY
        {
            self.scoreLabel.text = "ByeBye\nScore:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
        
        if self.santa.frame.minX <= self.trailingToast.frame.minX &&
            self.santa.frame.maxX >= self.trailingToast.frame.maxX &&
            self.santa.frame.minY <= self.trailingToast.frame.minY &&
            self.santa.frame.maxY >= self.trailingToast.frame.maxY
        {
            self.scoreLabel.text = "ByeBye\nScore:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
        
        if self.santa.frame.minX <= self.bottomToast.frame.minX &&
            self.santa.frame.maxX >= self.bottomToast.frame.maxX &&
            self.santa.frame.minY <= self.bottomToast.frame.minY &&
            self.santa.frame.maxY >= self.bottomToast.frame.maxY
        {
            self.scoreLabel.text = "ByeBye\nScore:\(self.score)"
            self.stopTimer()
        } else {
            self.score += 10
        }
        let press = UILongPressGestureRecognizer(target: self, action: #selector(viewPress))
                press.minimumPressDuration = 3.0
                santa.addGestureRecognizer(press)
    }
    
    @objc
    private func viewPress(gesture : UILongPressGestureRecognizer) {
        if gesture.state == .ended {
            startTimer()
            scoreLabel.text = "Hi"
            score = 0
        }
    }
    
}
