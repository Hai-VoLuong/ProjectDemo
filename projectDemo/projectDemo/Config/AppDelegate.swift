//
//  AppDelegate.swift
//  projectDemo
//
//  Created by Hai Vo L. on 12/12/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        window?.rootViewController = CatController(collectionViewLayout: layout)
        return true
    }
}

struct Person {
    let firstName: String
    let lastName: String
}

class CatCell: GenericCollectionCell<Person> {
    
    let textLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .red
        addSubview(textLabel)
        textLabel.fillSuperview()
    }
    
    override var item: Person! {
        didSet {
            textLabel.text = item.firstName
        }
    }
}

class CatController: GenericCollecitonView<CatCell, Person>, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items = [Person(firstName: "Bill", lastName: "Clinton"),
                 Person(firstName: "Barack", lastName: "Obama")]
        collectionView.backgroundColor = .white
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}
