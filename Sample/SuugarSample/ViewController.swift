//
//  ViewController.swift
//  SuugarSample
//
//  Created by thedoritos on 2019/03/24.
//

import UIKit
import Suugar

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        ui {
            $0.label {
                $0.frame = CGRect(x: 0, y: 320, width: 375, height: 30)
                $0.text = "Hello, World!"
                $0.textAlignment = .center
            }
        }
    }
}
