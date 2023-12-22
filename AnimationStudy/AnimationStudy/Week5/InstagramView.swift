//
//  InstagramView.swift
//  AnimationStudy
//
//  Created by Minjoo Kim on 12/23/23.
//

import UIKit

import SnapKit
import Then

final class InstagramView: UIView {
    private let storyImageView = UIImageView()
    let progressView = UIProgressView()
    private let profileImageView = UIImageView()
    private let idLabel = UILabel()
    private let timeLabel = UILabel()
    private let ellipsisImageView = UIImageView()
    private let closeButton = UIImageView()
    let messageTextField = UITextField()
    let heartImageView = UIImageView()
    
    private let menuSwitch = UISwitch()
    private let joyFace = UIButton()
    private let openMouth = UIButton()
    let inLove = UIButton()
    private let cryingFace = UIButton()
    private let clap = UIButton()
    private let fire = UIButton()
    
    private let blackView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyles()
        setLayout()
        setEmojiView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InstagramView {
    private func setStyles() {
        storyImageView.do {
            $0.image = UIImage(named: "story")
            $0.makeCornerRound(radius: 5)
        }
        
        progressView.do {
            $0.trackTintColor = .lightGray
            $0.progressTintColor = .white
            $0.progress = 0.0
        }
        
        profileImageView.do {
            $0.image = UIImage(named: "Boy")
            $0.makeCornerRound(radius: 16)
        }
        
        idLabel.do {
            $0.text = "wwiinn_7"
            $0.font = .systemFont(ofSize: 11, weight: .semibold)
            $0.textColor = .white
        }
        
        timeLabel.do {
            $0.text = "33m"
            $0.font = .systemFont(ofSize: 11, weight: .regular)
            $0.textColor = .white
        }
        
        ellipsisImageView.do {
            $0.image = UIImage(systemName: "ellipsis")
            $0.tintColor = .white
        }
        
        closeButton.do {
            $0.image = UIImage(systemName: "xmark")
            $0.tintColor = .white
        }
        
        messageTextField.do {
            $0.attributedPlaceholder = NSAttributedString(string: "Send message",
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
            )
            $0.makeBorder(width: 0.5, color: .gray)
            $0.makeCornerRound(radius: 20)
            $0.addLeftPadding()
        }
        
        heartImageView.do {
            $0.image = UIImage(systemName: "heart")
            $0.tintColor = .white
        }
        
        joyFace.do {
            $0.setTitle("😂", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 40)
        }
        
        openMouth.do {
            $0.setTitle("😮", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 40)
        }
        
        inLove.do {
            $0.setTitle("😍", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 40)
        }
        
        cryingFace.do {
            $0.setTitle("😢", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 40)
        }
        clap.do {
            $0.setTitle("👏", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 40)
        }
        
        fire.do {
            $0.setTitle("🔥", for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 40)
        }
        
        blackView.do {
            $0.backgroundColor = .black.withAlphaComponent(0.5)
        }
    }
    
    private func setLayout() {
        self.addSubviews(storyImageView, progressView, profileImageView, idLabel, timeLabel, ellipsisImageView, closeButton, messageTextField, heartImageView)
        
        storyImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(100)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(58)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.equalTo(2)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(storyImageView.snp.top).offset(18)
            $0.leading.equalToSuperview().inset(13)
            $0.size.equalTo(32)
        }
        
        idLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView.snp.centerY)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(5)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView.snp.centerY)
            $0.leading.equalTo(idLabel.snp.trailing).offset(5)
        }
        
        ellipsisImageView.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView.snp.centerY)
            $0.trailing.equalTo(closeButton.snp.leading).offset(-10)
            $0.width.equalTo(20)
        }
        
        closeButton.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(10)
            $0.size.equalTo(25)
        }
        
        messageTextField.snp.makeConstraints {
            $0.centerY.equalTo(heartImageView.snp.centerY)
            $0.leading.equalToSuperview().inset(18)
            $0.trailing.equalTo(heartImageView.snp.leading).offset(-15)
            $0.height.equalTo(44)
        }
        
        heartImageView.snp.makeConstraints {
            $0.top.equalTo(storyImageView.snp.bottom).offset(24)
            $0.trailing.equalToSuperview().inset(14)
            $0.width.equalTo(28)
            $0.height.equalTo(25)
        }
    }
}

extension InstagramView {
    func setEmojiView() {
        self.addSubview(blackView)
        self.addSubviews(joyFace, openMouth, inLove, cryingFace, clap, fire)
        self.bringSubviewToFront(messageTextField)
        self.bringSubviewToFront(heartImageView)
        
        blackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        joyFace.snp.makeConstraints {
            $0.centerY.equalTo(openMouth.snp.centerY)
            $0.trailing.equalTo(openMouth.snp.leading).offset(-40)
            $0.size.equalTo(45)
        }
        
        openMouth.snp.makeConstraints {
            $0.top.equalToSuperview().inset(220)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(45)
        }
        
        inLove.snp.makeConstraints {
            $0.centerY.equalTo(openMouth.snp.centerY)
            $0.leading.equalTo(openMouth.snp.trailing).offset(40)
            $0.size.equalTo(45)
        }
        
        cryingFace.snp.makeConstraints {
            $0.centerX.equalTo(joyFace.snp.centerX)
            $0.centerY.equalTo(clap.snp.centerY)
            $0.size.equalTo(45)
        }
        
        clap.snp.makeConstraints {
            $0.top.equalTo(openMouth.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(45)
        }
        
        fire.snp.makeConstraints {
            $0.centerX.equalTo(inLove.snp.centerX)
            $0.centerY.equalTo(clap.snp.centerY)
            $0.size.equalTo(45)
        }
    }
    
    func updateLayout(keyboardHeight: CGFloat) {
        heartImageView.snp.updateConstraints {
            $0.top.equalTo(storyImageView.snp.bottom).offset(24 - keyboardHeight)
        }
    }
}
