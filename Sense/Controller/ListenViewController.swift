//
//  ListenViewController.swift
//  Sense
//
//  Created by Bob Yuan on 2020/1/2.
//  Copyright © 2020 Bob Yuan. All rights reserved.
//

import UIKit
import Lottie

class ListenViewController: UIViewController {
    
    let animationView = AnimationView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hi")
        animationView.frame = CGRect(x: view.center.x, y: view.center.y, width: 100, height: 100)
        animationView.animation = Animation.named("Pulsating")
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        view.addSubview(animationView)
    }
    
}
