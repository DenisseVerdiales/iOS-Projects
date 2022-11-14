//
//  CaptureAudioViewController.swift
//  Capture
//
//  Created by Consultant on 9/18/22.
//

import UIKit
import AVFoundation

class CaptureAudioViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

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
    
    var audioRecorder: AVAudioRecorder!  //change for ?
    var audioPlayer: AVAudioPlayer! // change for ?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUI()
        setUpRecorder()
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

    func setUpRecorder(){
        let fileName = getAudioFileName()
        let audioFilename = getDocumentDirector().appendingPathComponent(fileName)
        let recorSetting = [AVFormatIDKey: kAudioFormatAppleLossless,
                            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
                            AVEncoderBitRateKey: 320000,
                            AVNumberOfChannelsKey: 2,
                            AVSampleRateKey: 44100.2] as [String: Any]
        
        do{
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: recorSetting)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        }catch{
            print(error)
        }
    }
    
    func setUpPlayer(){
        let fileName = getAudioFileName()
        let audioFileName = getDocumentDirector().appendingPathComponent(fileName)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileName)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.volume = 1.0
        }catch{
            print(error)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        //btnCaptureAudioRecorder.isEnabled = true
        btnPlayerAudioRecorder.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        //btnPlayerAudioRecorder.isEnabled = true
        btnCaptureAudioRecorder.isEnabled = true
        btnPlayerAudioRecorder.setTitle("Play", for: .normal)
    }
    
    @objc
    func btnAudioRecorder(){
        if btnCaptureAudioRecorder.titleLabel?.text == "Record"{
            audioRecorder.record()
            btnCaptureAudioRecorder.setTitle("Stop", for: .normal)
            btnPlayerAudioRecorder.isEnabled = false
        }else{
            audioRecorder.stop()
            btnCaptureAudioRecorder.setTitle("Record", for: .normal)
            btnPlayerAudioRecorder.isEnabled = false
        }
    }
    
    @objc
    func btnPlayAudioRecorder(){
        if btnPlayerAudioRecorder.titleLabel?.text == "Play"{
            btnPlayerAudioRecorder.setTitle("Stop", for: .normal)
            btnCaptureAudioRecorder.isEnabled = false
            setUpPlayer()
            audioPlayer.play()
        }else{
            audioPlayer.stop()
            btnPlayerAudioRecorder.setTitle("Play", for: .normal)
            btnCaptureAudioRecorder.isEnabled = false
        }
    }

}
