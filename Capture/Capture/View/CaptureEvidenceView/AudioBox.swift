//
//  AudioBox.swift
//  Capture
//
//  Created by Consultant on 9/24/22.
//

import UIKit
import AVFoundation
import FirebaseStorage

class AudioBox: UIViewController, ObservableObject{
    
    private var status: AudioStatus = .stopped
    private var hasMicroAccess = false
    private var displayNotification = false
    
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    
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
        view.backgroundColor = .white
        self.setUpUI()
        self.setupRecorder()
    }
    
     init(){
        super.init(nibName: nil, bundle: nil)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(handleRouteChange), name: AVAudioSession.routeChangeNotification, object: nil)
         notificationCenter.addObserver(self, selector: #selector(handleInterruption), name: AVAudioSession.interruptionNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    var url: URL{
        let fileManager = FileManager.default
        let tempDir = fileManager.temporaryDirectory
        let filePath = "TempFile.cap"
        return tempDir.appendingPathComponent(filePath)
    }
    
    func setupRecorder(){
        let recordSetting: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do{
            audioRecorder = try AVAudioRecorder(url: url, settings: recordSetting)
            audioRecorder?.delegate = self
            //audioRecorder?.prepareToRecord()
            
        }catch{
            print("Error creating audioRecorder")
        }
    }
    
    func record(){
        audioRecorder?.record()
        status = .recording
    }
    
    func stopRecording(){
        audioRecorder?.stop()
        status = .stopped
    }
    
    func play(){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        }catch{
            print(error.localizedDescription)
        }
        guard let audioPlayer = audioPlayer else {
            return
        }
        if audioPlayer.duration > 0.0 {
            audioPlayer.play()
            self.status = .playing
        }
    }
    
    func stopPlay(){
        audioPlayer?.stop()
        self.status = .stopped
    }
    
    func saveAudio(){
       
        
        
    }
    
    func alertAccess() {
           let alert = UIAlertController(title: "Requieres Microphone Access",
                                         message: "Go to Settings > Capture > Allow Capture to Access Microphone. \nSet switch to enabled.",
                                         preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Dismiss",
                                         style: .cancel, handler: nil))
           present(alert, animated: true)
       }
    
    private func requestMicrophoneAccess(){
        let session = AVAudioSession.sharedInstance()
        session.requestRecordPermission{granted in
            self.hasMicroAccess = granted
            if granted{
                self.record()
            }else{
                self.displayNotification = true
                self.alertAccess()
            }
        }
    }
    
    @objc
    func btnAudioRecorder(){
        if self.status == .stopped{
            if hasMicroAccess {
                self.record()
            }else{
                requestMicrophoneAccess()
            }
            btnCaptureAudioRecorder.setTitle("Stop", for: .normal)
            btnPlayerAudioRecorder.isEnabled = false
            
        }else{
            btnCaptureAudioRecorder.setTitle("Record", for: .normal)
            btnPlayerAudioRecorder.isEnabled = true
            stopRecording()
        }
    }
    
    @objc
    func btnPlayAudioRecorder(){
        if self.status == .playing{
            btnPlayerAudioRecorder.setTitle("Play", for: .normal)
            btnCaptureAudioRecorder.isEnabled = true
            self.stopPlay()
            
        }else{
            
            btnPlayerAudioRecorder.setTitle("Stop", for: .normal)
            btnCaptureAudioRecorder.isEnabled = false
            self.play()
        }
    }
    
    @objc
    func handleRouteChange(notification: Notification){
        if let info = notification.userInfo, let rawValue = info[AVAudioSessionRouteChangeReasonKey] as? UInt{
            let reason = AVAudioSession.RouteChangeReason(rawValue: rawValue)
            if reason == .oldDeviceUnavailable{
                guard let previousRoute = info[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription,
                      let previousOutput = previousRoute.outputs.first else{
                    return
                }
                if previousOutput.portType == .headphones{
                    if status == .playing{
                        self.stopPlay()
                    }else if self.status == .recording {
                        self.stopRecording()
                    }
                }
            }
        }
    }
    
    @objc
    func handleInterruption(notification: Notification){
        if let info = notification.userInfo,
        let rawValue = info[AVAudioSessionInterruptionTypeKey] as? UInt{
            let type = AVAudioSession.InterruptionType(rawValue: rawValue)
            if type == .began{
                if self.status == .playing{
                    self.stopPlay()
                }else if self.status == .recording{
                    self.stopRecording()
                }
            }else{
                if let rawValue = info[AVAudioSessionInterruptionTypeKey] as? UInt{
                    let options = AVAudioSession.InterruptionOptions(rawValue: rawValue)
                    if options == .shouldResume{
                        //restart audio or restart recording
                    }
                }
            }
        }
   
    }
}

extension AudioBox: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        status = .stopped
    }
}

extension AudioBox: AVAudioPlayerDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.status = .stopped
    }
}
