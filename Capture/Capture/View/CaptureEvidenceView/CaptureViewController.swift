//
//  CaptureViewController.swift
//  Capture
//
//  Created by Consultant on 9/15/22.
//

import UIKit

class CaptureViewController: UIViewController {
    
    lazy var btnCaptureImage: UIButton = {
        let btnCaptureImage = UIButton(frame: .zero)
        btnCaptureImage.translatesAutoresizingMaskIntoConstraints = false
        btnCaptureImage.setTitle("Photo", for: .normal)
        btnCaptureImage.setTitleColor(.white, for: .normal)
        btnCaptureImage.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnCaptureImage.backgroundColor = .black
        btnCaptureImage.layer.cornerRadius = 5
        btnCaptureImage.addTarget(self, action: #selector(showCaptureImage), for: .touchUpInside)
        
        return btnCaptureImage
        
    }()
    
    lazy var bntCaptureVideo: UIButton = {
        let bntCaptureImage = UIButton(frame: .zero)
        bntCaptureImage.translatesAutoresizingMaskIntoConstraints = false
        bntCaptureImage.setTitle("Video", for: .normal)
        bntCaptureImage.setTitleColor(.white, for: .normal)
        bntCaptureImage.heightAnchor.constraint(equalToConstant: 44).isActive = true
        bntCaptureImage.backgroundColor = .black
        bntCaptureImage.layer.cornerRadius = 5
        bntCaptureImage.addTarget(self, action: #selector(showCaptureVideo), for: .touchUpInside)
        
        return bntCaptureImage
    }()
    
    lazy var btnCaptureAudio: UIButton = {
        let btnCaptureAudio = UIButton(frame: .zero)
        btnCaptureAudio.translatesAutoresizingMaskIntoConstraints = false
        btnCaptureAudio.setTitle("Audio", for: .normal)
        btnCaptureAudio.setTitleColor(.white, for: .normal)
        btnCaptureAudio.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnCaptureAudio.backgroundColor = .black
        btnCaptureAudio.layer.cornerRadius = 5
        btnCaptureAudio.addTarget(self, action: #selector(showCaptureAudio), for: .touchUpInside)
        
        return btnCaptureAudio
    }()
    
    lazy var btnCaptureImport: UIButton = {
        let btnCaptureImport = UIButton(frame: .zero)
        btnCaptureImport.translatesAutoresizingMaskIntoConstraints = false
        btnCaptureImport.setTitle("Import", for: .normal)
        btnCaptureImport.setTitleColor(.white, for: .normal)
        btnCaptureImport.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnCaptureImport.backgroundColor = .black
        btnCaptureImport.layer.cornerRadius = 5
        btnCaptureImport.addTarget(self, action: #selector(showCaptureImport), for: .touchUpInside)
        
        return btnCaptureImport
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setUpUI()
    }
    
    func setUpUI(){
        let vStackView = UIStackView(frame: .zero)
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.spacing = 8
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        
        let BufferTop = UIView.createBufferView()
        let BufferBottom = UIView.createBufferView()
        
        vStackView.addArrangedSubview(BufferTop)
        vStackView.addArrangedSubview(self.btnCaptureImage)
        vStackView.addArrangedSubview(self.bntCaptureVideo)
        vStackView.addArrangedSubview(self.btnCaptureAudio)
        vStackView.addArrangedSubview(self.btnCaptureImport)
        vStackView.addArrangedSubview(BufferBottom)
        
        BufferTop.heightAnchor.constraint(equalTo: BufferBottom.heightAnchor).isActive = true
    
        self.btnCaptureImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.bntCaptureVideo.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.btnCaptureAudio.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.btnCaptureImport.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.view.addSubview(vStackView)
        
        vStackView.bindToSuperView(top: 8, left: 8, bottom: 8, right: 8)
      
    }

    @objc
    func showCaptureImage(){
        
    }
    
    @objc
    func showCaptureVideo(){
        
    }
    
    @objc
    func showCaptureAudio(){
        let viewCaptureAudio = AudioBox()
        self.navigationController?.pushViewController(viewCaptureAudio, animated: true)
    }
    
    @objc
    func showCaptureImport(){
        
    }
}
