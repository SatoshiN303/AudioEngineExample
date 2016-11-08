//
//  ViewController.swift
//  AudioEngineExample
//
//  Created by 佐藤 慎 on 2016/11/07.
//  Copyright © 2016年 i-studio development team. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func record(sender: AnyObject) {
         AudioEngineService.sharedInstance.isRecording = true
    }
    
    @IBAction func stop(sender: AnyObject) {
        AudioEngineService.sharedInstance.isRecording = false
    }


}
