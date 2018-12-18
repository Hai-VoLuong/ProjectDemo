//
//  File.swift
//  projectDemo
//
//  Created by MAC on 12/18/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

final class LayoutStackViewController: UIViewController {
 
    let redView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    let blueView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        return v
    }()
    
    let greenView: UIView = {
        let v = UIView()
        v.backgroundColor = .green
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lay out Stack View"
        view.backgroundColor = .white
        
        [greenView, redView, blueView].forEach{
            view.addSubview($0)
        }
        
        greenView.anchor(top: redView.topAnchor, leading: view.leadingAnchor, bottom: blueView.bottomAnchor, trailing: redView.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        
        redView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 12), size: CGSize(width: 150, height: 0))
        redView.heightAnchor.constraint(equalTo: redView.widthAnchor).isActive = true
        
        blueView.anchor(top: redView.bottomAnchor, leading: nil, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 12))
        blueView.anchorSize(to: redView)
    }
}

extension UIView {
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}
