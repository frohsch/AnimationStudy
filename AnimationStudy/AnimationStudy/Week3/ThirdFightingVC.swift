//
//  ThirdFightingVC.swift
//  AnimationStudy
//
//  Created by Minjoo Kim on 11/27/23.
//

import UIKit

import SnapKit
import Then

import UIKit

class ThirdFightingVC: UIViewController {
    var gradientCircularProgressBar = GradientCircularProgressBar()

    var progressSlider = UISlider()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubviews(gradientCircularProgressBar)
        
        gradientCircularProgressBar.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(100)
        }
    }
}
