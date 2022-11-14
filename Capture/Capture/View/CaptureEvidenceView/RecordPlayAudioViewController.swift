//
//  RecordPlayAudioViewController.swift
//  Capture
//
//  Created by Consultant on 9/24/22.
//

import UIKit
import AVFoundation

class RecordPlayAudioViewController: UIViewController {
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        self.setUpUI()

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
    
    @objc
    func btnAudioRecorder(){
        if btnCaptureAudioRecorder.titleLabel?.text == "Record"{
            btnCaptureAudioRecorder.setTitle("Stop", for: .normal)
            btnPlayerAudioRecorder.isEnabled = false
        }else{
            btnCaptureAudioRecorder.setTitle("Record", for: .normal)
            btnPlayerAudioRecorder.isEnabled = false
        }
    }
    
    @objc
    func btnPlayAudioRecorder(){
        if btnPlayerAudioRecorder.titleLabel?.text == "Play"{
            btnPlayerAudioRecorder.setTitle("Stop", for: .normal)
            btnCaptureAudioRecorder.isEnabled = false
        }else{
            btnPlayerAudioRecorder.setTitle("Play", for: .normal)
            btnCaptureAudioRecorder.isEnabled = false
        }
    }

}
