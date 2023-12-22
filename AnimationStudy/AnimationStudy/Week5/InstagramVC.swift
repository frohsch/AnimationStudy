//
//  InstagramVC.swift
//  AnimationStudy
//
//  Created by Minjoo Kim on 12/21/23.
//

import UIKit

import RxSwift
import RxCocoa
import RxRelay
import SnapKit
import Then

class InstagramVC: UIViewController {
    
    private let instagramView = InstagramView()
    private let disposeBag = DisposeBag()
    
    var time: Float = 0.0
    var timer: Timer?
    
    override func loadView() {
        self.view = instagramView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTimer()
        bind()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension InstagramVC {
    private func bind() {
        instagramView.inLove.rx.tap
            .bind {
                self.addEmojiLayer()
                print("tap")
            }
            .disposed(by: disposeBag)
    }
    
    private func setTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.03, target: self, selector: #selector(setProgress), userInfo: nil, repeats: true)
    }
    
    @objc func setProgress() {
        time += 0.005
        instagramView.progressView.setProgress(time, animated: true)
        if time >= 1.0 {
            self.time = 0.0
            instagramView.progressView.setProgress(time, animated: false)
            self.setTimer()
        }
    }
    
    func addEmojiLayer() {
        let cell = CAEmitterCell()
        let emoji = "😍"

        cell.contents = {
            let font = UIFont.systemFont(ofSize: 40)
            let size = emoji.size(withAttributes: [.font: font])
            let renderer = UIGraphicsImageRenderer(size: size)
            let image = renderer.image { context in
                emoji.draw(at: .zero, withAttributes: [.font: font])
            }
            return image.cgImage
        }()
        
        cell.birthRate = 3
        cell.lifetime = 8.0
        cell.scale = 0.46
        cell.yAcceleration = 70
        cell.alphaSpeed = -0.3
        cell.emissionLongitude = .pi * 0.0
        cell.speed = 2.0

        
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = .line
        emitterLayer.emitterSize = CGSize(width: view.frame.width, height: view.frame.height / 2)
        emitterLayer.emitterPosition = CGPoint(x: view.center.x, y: view.center.y)
        emitterLayer.emitterCells = [cell]
        
        view.layer.addSublayer(emitterLayer)
    }
}

extension InstagramVC {
    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            instagramView.updateLayout(keyboardHeight: keyboardHeight)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        //        if self.view.frame.origin.y != 0 {
        self.instagramView.heartImageView.frame.origin.y = 0
        //            }
    }
    
    func tapBackgroundView(_ sender: Any) {
        view.endEditing(true)
    }
}

extension InstagramVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

