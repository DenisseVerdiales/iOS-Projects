//
//  CaptureAVAudioEngineViewController.swift
//  Capture
//
//  Created by Consultant on 9/19/22.
//

import UIKit
import AVFoundation


enum RecordingState{
    case recording, paused, stopped, playing
}

class CaptureAVAudioEngineViewController: UIViewController {

    lazy var btnCaptureAudioRecorder : UIButton = {
        let btnCaptureAudioRecorder = UIButton(frame: .zero)
        btnCaptureAudioRecorder.translatesAutoresizingMaskIntoConstraints = false
        btnCaptureAudioRecorder.setTitle("Record", for: .normal)
        btnCaptureAudioRecorder.setTitleColor(.white, for: .normal)
        btnCaptureAudioRecorder.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnCaptureAudioRecorder.backgroundColor = .black
        btnCaptureAudioRecorder.layer.cornerRadius = 5
        btnCaptureAudioRecorder.addTarget(self, action: #selector(btnAudioRecorder), for: .touchUpInside)
        
        return btnCaptureAudioRecorder
    }()
    
    lazy var btnPlayerAudioRecorder: UIButton = {
        let btnPlayerAudioRecorder = UIButton(frame: .zero)
        btnPlayerAudioRecorder.translatesAutoresizingMaskIntoConstraints = false
        btnPlayerAudioRecorder.setTitle("Play", for: .normal)
        btnPlayerAudioRecorder.setTitleColor(.white, for: .normal)
        btnPlayerAudioRecorder.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnPlayerAudioRecorder.backgroundColor = .black
        btnPlayerAudioRecorder.layer.cornerRadius = 5
        btnPlayerAudioRecorder.addTarget(self, action: #selector(btnPlayAudioRecorder), for: .touchUpInside)
        
        return btnPlayerAudioRecorder
    }()
    
    var engine = AVAudioEngine()
    var file: AVAudioFile?
    var player = AVAudioPlayerNode() // if you need play record later
    var urlFile = getDocumentDirector()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setUpUI()
        
        file = try? AVAudioFile(forWriting: urlFile.appendingPathComponent("my_file.caf"), settings: engine.inputNode.inputFormat(forBus: 0).settings)
        engine.attach(player)
        engine.connect(player, to: engine.mainMixerNode, format: engine.mainMixerNode.outputFormat(forBus: 0)) //configure graph
        
    }
    
    func setUpUI(){
        let vStackView = UIStackView(frame: .zero)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 8
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        
        let bufferTop = UIView.createBufferView()
        let bufferBottom = UIView.createBufferView()
        
        vStackView.addArrangedSubview(bufferTop)
        vStackView.addArrangedSubview(self.btnCaptureAudioRecorder)
        vStackView.addArrangedSubview(self.btnPlayerAudioRecorder)
        vStackView.addArrangedSubview(bufferBottom)
        
        bufferTop.heightAnchor.constraint(equalTo: bufferBottom.heightAnchor).isActive = true
        self.btnCaptureAudioRecorder.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.btnPlayerAudioRecorder.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.view.addSubview(vStackView)
        
        vStackView.bindToSuperView(top: 8, left: 8, bottom: 8, right: 8)
        
    }
    
    func record() {
        engine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: engine.mainMixerNode.outputFormat(forBus: 0)) { (buffer, time) -> Void in
            try! self.file?.write(from: buffer)
            return
        }
    }
       
   
    
    @objc
    func btnAudioRecorder(){
        if btnCaptureAudioRecorder.titleLabel?.text == "Record"{
            try? engine.start()
            btnCaptureAudioRecorder.setTitle("Stop", for: .normal)
            btnPlayerAudioRecorder.isEnabled = false
        }else{
            engine.stop()
            btnCaptureAudioRecorder.setTitle("Record", for: .normal)
            btnPlayerAudioRecorder.isEnabled = true
        }
    }
    
    @objc
    func btnPlayAudioRecorder(){
       
        if btnPlayerAudioRecorder.titleLabel?.text == "Play"{
            btnPlayerAudioRecorder.setTitle("Stop", for: .normal)
            btnCaptureAudioRecorder.isEnabled = false
            if !engine.isRunning{
                player.play()
            }
            
            
        }else{
          
            btnPlayerAudioRecorder.setTitle("Play", for: .normal)
            btnCaptureAudioRecorder.isEnabled = true
            player.stop()
        }
    }
   
}
