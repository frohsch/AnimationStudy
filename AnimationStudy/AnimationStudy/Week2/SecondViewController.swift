//
//  SecondViewController.swift
//  AnimationStudy
//
//  Created by Minjoo Kim on 11/13/23.
//

import UIKit

import SnapKit
import Then

class SecondViewController: UIViewController {
    var state = true
    
    let testView = UIView()
    let santaImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

extension SecondViewController {
    private func setUI() {
        view.backgroundColor = .white
        santaImageView.do {
            $0.image = UIImage(named: "yes")
        }
    }
    
    private func setLayout() {
        view.addSubviews(testView)
        testView.addSubview(santaImageView)
        
        testView.snp.makeConstraints {
            $0.size.equalTo(200)
            $0.center.equalToSuperview()
        }
        
        santaImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setTarget() {
        //UITapGestureRecognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tapGesture.numberOfTapsRequired = 5
        testView.addGestureRecognizer(tapGesture)
        
        //UIPinchGestureRecognizer
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(viewPinched))
        testView.addGestureRecognizer(pinchGesture)
        
        //UIRotationGestureRecognizer
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(viewRotation))
        testView.addGestureRecognizer(rotationGesture)
        
        //UISwipeGestureRecognizer
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipe))
        swipeRightGesture.direction = .right
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(viewSwipe))
        swipeRightGesture.direction = .left
        self.view.addGestureRecognizer(swipeRightGesture)
        self.view.addGestureRecognizer(swipeLeftGesture)
        
        //UILongPressGestureRecognizer
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(viewPress))
        //        longPressGesture.minimumPressDuration = 5.0
        //        longPressGesture.numberOfTouchesRequired = 2
        self.testView.addGestureRecognizer(longPressGesture)
        
        //UIPanGestureRecognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPan))
        self.testView.addGestureRecognizer(panGesture)
    }
}

extension SecondViewController {
    
    @objc func viewTapped(gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 1.0, animations: { [self] in
            testView.frame.origin.x += 50
        }, completion: { _ in
            UIView.animate(withDuration: 1.0, animations: { [self] in
                testView.frame.origin.x -= 50
            })
        })
    }
    
    @objc func viewPinched(gesture: UIPinchGestureRecognizer) {
        guard let view = gesture.view else { return }
        view.transform = view.transform.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1
    }
    
    @objc func viewRotation(gesture: UIRotationGestureRecognizer) {
        guard let view = gesture.view else { return }
        view.transform = view.transform.rotated(by: gesture.rotation)
        gesture.rotation = 0
    }
    
    @objc func viewSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            self.view.backgroundColor = .systemGreen
        } else if gesture.direction == .left {
            self.view.backgroundColor = .white
        }
    }
    
    @objc func viewPress(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            print("Start\n")
        case .changed:
            print("Change\n")
        case .ended:
            print("End\n")
        case .possible:
            print("Possibe")
        case .cancelled:
            print("Cancel")
        case .failed:
            print("Fail")
        @unknown default:
            print("어쩔")
        }
    }
    
    @objc func viewPan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        if let viewToMove = gesture.view {
            viewToMove.center = CGPoint(x: viewToMove.center.x + translation.x, y: viewToMove.center.y + translation.y)
        }
        
        gesture.setTranslation(.zero, in: view)
    }
}
