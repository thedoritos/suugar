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
                $0.alignCenter()
                $0.size(width: 200)

                $0.text = "Hello, World!"
                $0.textAlignment = .center
            }
        }
    }
}
