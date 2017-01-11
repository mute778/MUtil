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
    
    // =============================================================================
    // MARK: - value
    // =============================================================================
    
    // =============================================================================
    // MARK: - Outlet
    // =============================================================================
    @IBOutlet weak var testLabel: UILabel!
    
    
    // =============================================================================
    // MARK: - LifeCycle
    // =============================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLabel.text = "あいうえおあいうえおあいうえおあいうえおあいうえお"
        
        let height = MUtil.getLabelHeight(label: testLabel)
        print(height)
        
        let settings = UIUserNotificationSettings(types: .badge, categories: nil)
        UIApplication.shared.registerUserNotificationSettings(settings)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // =============================================================================
    // MARK: - Action
    // =============================================================================
    @IBAction func testAction(_ sender: UIButton) {
//        testLabel.text = testLabel.text! + "あいうえお"
//        let height = MUtil.getLabelHeight(label: testLabel)
//        print(height)
    }
}
