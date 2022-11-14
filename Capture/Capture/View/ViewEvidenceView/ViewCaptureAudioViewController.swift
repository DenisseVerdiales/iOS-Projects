//
//  ViewCaptureAudioViewController.swift
//  Capture
//
//  Created by Consultant on 9/18/22.
//

import UIKit
import AVFoundation
import SwiftUI

class ViewCaptureAudioViewController: UIViewController, AVAudioPlayerDelegate {

    let mainVM = captureControllerViewModel()
    let imgBackward = UIImage(systemName: "gobackward.10")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    let imgForward = UIImage(systemName: "goforward.10")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    let imgPlay = UIImage(systemName: "play.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    let imgPause = UIImage(systemName: "pause.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)

    lazy var imgPod: UIImageView = {
       let imgPod = UIImageView()
        imgPod.contentMode = .scaleAspectFit
        imgPod.image = UIImage(named: "artwork")
        
        return imgPod
    }()
    
    lazy var progAudio: UIProgressView = {
        let progAudio = UIProgressView(frame: .zero)
        progAudio.translatesAutoresizingMaskIntoConstraints = false
        progAudio.backgroundColor = UIColor.black.withAlphaComponent(0.08)
        progAudio.progressTintColor = .systemGreen
        progAudio.progress = 0.5
        progAudio.layer.cornerRadius = 5
        progAudio.progressViewStyle = .bar
        progAudio.clipsToBounds = true
        progAudio.heightAnchor.constraint(equalToConstant: 5).isActive = true
        progAudio.layer.sublayers?[1].cornerRadius = 5
        return progAudio
    }()
    
    lazy var lblPlayerTimeStart: UILabel = {
        let lblPlayerTimeStart = UILabel(frame: .zero)
        lblPlayerTimeStart.translatesAutoresizingMaskIntoConstraints = false
        lblPlayerTimeStart.numberOfLines = 0
        lblPlayerTimeStart.textAlignment = NSTextAlignment.justified
        lblPlayerTimeStart.font = lblPlayerTimeStart.font.withSize(12)
        lblPlayerTimeStart.text = "start Time"
        return lblPlayerTimeStart
    }()
    
    lazy var lblPlayerTimeEnd: UILabel = {
        let lblPlayerTimeEnd = UILabel(frame: .zero)
        lblPlayerTimeEnd.translatesAutoresizingMaskIntoConstraints = false
        lblPlayerTimeEnd.numberOfLines = 0
        lblPlayerTimeEnd.textAlignment = NSTextAlignment.justified
        lblPlayerTimeEnd.font = lblPlayerTimeEnd.font.withSize(12)
        lblPlayerTimeEnd.text = "end Time"
        lblPlayerTimeEnd.textAlignment = .right
        return lblPlayerTimeEnd
    }()
    
    lazy var btnBackward: UIButton = {
        let btnBackward = UIButton(frame: .zero)
        btnBackward.translatesAutoresizingMaskIntoConstraints = false
        btnBackward.setBackgroundImage(self.imgBackward, for: UIControl.State.normal)
        btnBackward.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnBackward.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnBackward.addTarget(self, action: #selector(btnBackwardOpc), for: .touchUpInside)
        return btnBackward
    }()
    
    lazy var btnPlayPause: UIButton = {
        let btnPlay = UIButton(frame: .zero)
        btnPlay.translatesAutoresizingMaskIntoConstraints = false
        btnPlay.setBackgroundImage(self.mainVM.isPlaying ? self.imgPause : self.imgPlay, for: UIControl.State.normal)
        btnPlay.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnPlay.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnPlay.addTarget(self, action: #selector(btnPlayOrPauseOpc), for: .touchUpInside)
        return btnPlay
    }()
    
//    lazy var btnPause: UIButton = {
//        let btnPause = UIButton(frame: .zero)
//        btnPause.translatesAutoresizingMaskIntoConstraints = false
//        btnPause.setBackgroundImage(self.imgPause, for: UIControl.State.normal)
//        btnPause.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        btnPause.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        btnPause.addTarget(self, action: #selector(btnPauseOpc), for: .touchUpInside)
//        return btnPause
//    }()
    
    lazy var btnForward: UIButton = {
        let btnForward = UIButton(frame: .zero)
        btnForward.translatesAutoresizingMaskIntoConstraints = false
        btnForward.setBackgroundImage(self.imgForward, for: UIControl.State.normal)
        btnForward.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnForward.heightAnchor.constraint(equalToConstant: 30).isActive = true
        btnForward.addTarget(self, action: #selector(btnForwardOpc), for: .touchUpInside)
        return btnForward
    }()
    
    lazy var adjControlView: UIView = {
        let adjControlView = UIView(frame: .zero)
        adjControlView.translatesAutoresizingMaskIntoConstraints = false
        return adjControlView
    }()
    
    lazy var segControlSpeed: UISegmentedControl = {
        let segControlSpeed = UISegmentedControl(items: ["0.5x","1x","1.25x","2x"])
        segControlSpeed.translatesAutoresizingMaskIntoConstraints = false
        return segControlSpeed
    }()
    
    lazy var segControlPitchAdjustment: UISegmentedControl = {
        let segControlPitchAdjustment = UISegmentedControl(items: ["-1/2","0", "+1/2"])
        segControlPitchAdjustment.translatesAutoresizingMaskIntoConstraints = false
        return segControlPitchAdjustment
    }()
    
    lazy var btnConnectExtDevice: UIButton = {
        let btnConnectExtDevice = UIButton(frame: .zero)
        btnConnectExtDevice.translatesAutoresizingMaskIntoConstraints = false
        btnConnectExtDevice.setTitle("Connect to External Device ", for: .normal)
        btnConnectExtDevice.setTitleColor(.white, for: .normal)
        btnConnectExtDevice.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnConnectExtDevice.backgroundColor = .black
        btnConnectExtDevice.layer.cornerRadius = 5
        btnConnectExtDevice.addTarget(self, action: #selector(btnConnectExtDev), for: .touchUpInside)
        
        return btnConnectExtDevice
    }()
    
    var audioPlayer: AVAudioPlayer! // change for ?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setUpUI()
        self.setUpPlayer()
        
    }
    
    func configSegControlSeed(){
        self.segControlSpeed.selectedSegmentIndex = self.mainVM.playbackRateIndex
        
//        for elem in 0..<self.mainVM.allPlaybackRates.count{
//            //self.segControlSpeed
//        }
//        ForEach(0 ..<self.mainVM.allPlaybackRates.count) {
//
//        }
    }
    
    func setUpUI(){
        let bufferTop = UIView.createBufferView()
        let bufferBottom = UIView.createBufferView()
        
        let vStackView = UIStackView(frame: .zero)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 8
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        
        let vImgStackView = UIStackView(frame: .zero)
           vImgStackView.translatesAutoresizingMaskIntoConstraints = false
           vImgStackView.spacing = 8
            vImgStackView.axis = .vertical
     

        vImgStackView.addArrangedSubview(self.imgPod)
        
        let hStackViewProgTime = UIStackView(frame: .zero)
        hStackViewProgTime.translatesAutoresizingMaskIntoConstraints = false
        hStackViewProgTime.spacing = 8
        hStackViewProgTime.axis = .horizontal
        hStackViewProgTime.distribution = .fill
        
        hStackViewProgTime.addArrangedSubview(self.lblPlayerTimeStart)
        hStackViewProgTime.addArrangedSubview(self.lblPlayerTimeEnd)
        
        let hStackViewBtnsControl = UIStackView(frame: .zero)
        hStackViewBtnsControl.translatesAutoresizingMaskIntoConstraints = false
        hStackViewBtnsControl.spacing = 8
        hStackViewBtnsControl.axis = .horizontal
        hStackViewBtnsControl.distribution = .equalCentering
        
       // hStackViewBtnsControl.addArrangedSubview(bufferTop)
        hStackViewBtnsControl.addArrangedSubview(self.btnBackward)
        hStackViewBtnsControl.addArrangedSubview(self.btnPlayPause)
       // hStackViewBtnsControl.addArrangedSubview(self.btnPause)
        hStackViewBtnsControl.addArrangedSubview(self.btnForward)
       // hStackViewBtnsControl.addArrangedSubview(bufferBottom)
        
        
        let vBtnStackView = UIStackView(frame: .zero)
        vBtnStackView.translatesAutoresizingMaskIntoConstraints = false
        vBtnStackView.spacing = 8
        vBtnStackView.axis = .vertical
        
        vBtnStackView.addArrangedSubview(hStackViewBtnsControl)
        
        vStackView.addArrangedSubview(bufferTop)
        vStackView.addArrangedSubview(vImgStackView)
        vStackView.addArrangedSubview(self.progAudio)
        vStackView.addArrangedSubview(hStackViewProgTime)
        vStackView.addArrangedSubview(vBtnStackView)
       // vStackView.addArrangedSubview(hStackViewBtnsControl)
        vStackView.addArrangedSubview(self.segControlSpeed)
        vStackView.addArrangedSubview(self.segControlPitchAdjustment)
        vStackView.addArrangedSubview(self.btnConnectExtDevice)
        vStackView.addArrangedSubview(bufferBottom)
        
        bufferTop.heightAnchor.constraint(equalTo: bufferBottom.heightAnchor).isActive = true
        self.imgPod.widthAnchor.constraint(equalToConstant: 300).isActive = true
        self.imgPod.heightAnchor.constraint(equalToConstant: 300).isActive = true
        self.btnConnectExtDevice.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.view.addSubview(vStackView)
        
        vStackView.bindToSuperView(top: 8, left: 8, bottom: 8, right: 8)
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

    @objc func btnBackwardOpc(){
        self.mainVM.skip(forwards: false)
    }
    
    @objc func btnPlayOrPauseOpc(){
        self.mainVM.playOrPause()
    }
    
//    @objc func btnPauseOpc(){
//
//    }
    
    @objc func btnForwardOpc(){
        self.mainVM.skip(forwards: true)
    }
    
    @objc func btnConnectExtDev(){
        let viewConnectExtDev = ConnectToExternalDevViewController()
        self.navigationController?.pushViewController(viewConnectExtDev, animated: true)
    }
}
