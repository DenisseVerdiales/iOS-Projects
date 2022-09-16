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
    
    lazy var bntCaptureImage: UIButton = {
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
    }

    @objc
    func showCaptureImage(){
        
    }
    
    @objc
    func showCaptureVideo(){
        
    }
    
    @objc
    func showCaptureAudio(){
        
    }
    
    @objc
    func showCaptureImport(){
        
    }
}
