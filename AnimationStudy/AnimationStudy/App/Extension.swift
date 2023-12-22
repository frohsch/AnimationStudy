//
//  File.swift
//  AnimationStudy
//
//  Created by 김민주 on 11/12/23.
//

import UIKit

extension UIView {
    func addSubviews (_ views: UIView...){
        views.forEach { self.addSubview($0) }
    }
}

extension UIView {
    func showToast(message: String) {
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        let toastWidth = toastLabel.intrinsicContentSize.width + 20
        let toastHeight = toastLabel.intrinsicContentSize.height + 10
        toastLabel.frame = CGRect(x: self.frame.size.width/2 - toastWidth/2,
                                  y: self.frame.size.height - toastHeight - 30,
                                  width: toastWidth,
                                  height: toastHeight)
        self.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1.0, delay: 2, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

extension UIButton {
    func shakeButton() {
        self.transform = CGAffineTransform(translationX: 0, y: 20)
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 1,
                       options: [.curveEaseInOut]) {
            self.transform = .identity
        }
    }
}

extension UIImageView {
    func shakeImageView() {
        self.transform = CGAffineTransform(translationX: 0, y: 50)
        UIView.animate(withDuration: 2,
                       delay: 0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1,
                       options: [.curveEaseInOut]) {
            self.transform = .identity
        }
    }
}

extension UIView {
    
    func makeCornerRound (radius : CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func makeBorder (width : CGFloat ,color : UIColor ) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
}

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
