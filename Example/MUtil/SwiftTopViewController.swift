//
//  SwiftTopViewController.swift
//  MUtil
//
//  Created by 宮田　寿康 on 2017/01/05.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import MUtil

class SwiftTopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func testAction(_ sender: UIButton) {
        let version = MUtil.getAppVersion()
        print(version)
    }
}
