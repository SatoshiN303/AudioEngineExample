//
//  File.swift
//  AudioEngineExample
//
//  Created by 佐藤 慎 on 2016/11/08.
//  Copyright © 2016年 i-studio development team. All rights reserved.
//

import Foundation
import AVFoundation

class AudioEngineService {

    static let sharedInstance = AudioEngineService()
    
    var isRecording: Bool = false
    
    private var engine = AVAudioEngine()
    private var file: AVAudioFile?
    private var audioPlayer: AVAudioPlayer?
    
    private var recFileURL: NSURL {
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as String
        let pathArray = [dirPath, "rec.caf"]
        guard let filePath = NSURL.fileURLWithPathComponents(pathArray) else {
            fatalError()
        }
        return filePath
    }
    
    required init() {
        setup()
    }
    
    func setup() {
        guard let input = engine.inputNode else {
            fatalError()
        }
        let mixer = engine.mainMixerNode
        engine.connect(input, to: mixer, format: input.inputFormatForBus(0))
        try! engine.start()
        
        file = try? AVAudioFile(forWriting: recFileURL, settings: input.inputFormatForBus(0).settings)
    }
    
    func requestMicrophone() {
        guard let input = self.engine.inputNode else {
            fatalError()
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            
            let size: AVAudioFrameCount = 4096
            let format = input.inputFormatForBus(0)
            let bus = 0
            
            input.installTapOnBus(bus, bufferSize: size, format: nil) { [weak self]
                (buffer, when) in
                
                // 録音
                self?.updateInputSignal(buffer, when: when)
                
                // NOTE: これやるとエコーがかった感じになる。
                buffer.frameLength = size
            }
            
            self.engine.connect(input, to: self.engine.mainMixerNode, format: format)
        }
        
    }
    
    func updateInputSignal(buffer: AVAudioPCMBuffer, when: AVAudioTime) {
        
        if !isRecording {
            return
        }
        
        guard let file = file else {
            return
        }
        
        do {
            try file.writeFromBuffer(buffer)
        } catch {
            NSLog("ERROR: recording to audio file failed")
            print(error)
        }
        
    }

}