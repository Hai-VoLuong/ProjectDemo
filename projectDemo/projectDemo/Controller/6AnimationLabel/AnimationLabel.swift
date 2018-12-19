//
//  AnimationLabel.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/19/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class AnimationLabelController: UIViewController {

    let countingLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 18)
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation Label CADisplayLink"
        view.backgroundColor = .white

        view.addSubview(countingLabel)
        countingLabel.frame = view.frame
    }
}
