//
//  ViewCaptureViewController.swift
//  Capture
//
//  Created by Consultant on 9/16/22.
//

import UIKit

class ViewCaptureViewController: UIViewController {

    lazy var btnPlayAudioRecordered: UIButton = {
        let btnPlayAudioRecordered = UIButton(frame: .zero)
        btnPlayAudioRecordered.translatesAutoresizingMaskIntoConstraints = false
        btnPlayAudioRecordered.setTitle("Play Audio", for: .normal)
        btnPlayAudioRecordered.setTitleColor(.white, for: .normal)
        btnPlayAudioRecordered.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnPlayAudioRecordered.backgroundColor = .black
        btnPlayAudioRecordered.layer.cornerRadius = 5
        btnPlayAudioRecordered.addTarget(self, action: #selector(btnPlayAudio), for: .touchUpInside)
        
        return btnPlayAudioRecordered
    }()
    
    lazy var btnPlayVideoRecordered: UIButton = {
        let btnPlayVideoRecordered = UIButton(frame: .zero)
        btnPlayVideoRecordered.translatesAutoresizingMaskIntoConstraints = false
        btnPlayVideoRecordered.setTitle("Play Video", for: .normal)
        btnPlayVideoRecordered.setTitleColor(.white, for: .normal)
        btnPlayVideoRecordered.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnPlayVideoRecordered.backgroundColor = .black
        btnPlayVideoRecordered.layer.cornerRadius = 5
        btnPlayVideoRecordered.addTarget(self, action: #selector(btnPlayVideo), for: .touchUpInside)
        
        return btnPlayVideoRecordered
    }()
    
    lazy var btnShowPhotos: UIButton = {
        let btnShowPhotos = UIButton(frame: .zero)
        btnShowPhotos.translatesAutoresizingMaskIntoConstraints = false
        btnShowPhotos.setTitle("Show Photos", for: .normal)
        btnShowPhotos.setTitleColor(.white, for: .normal)
        btnShowPhotos.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnShowPhotos.backgroundColor = .black
        btnShowPhotos.layer.cornerRadius = 5
        btnShowPhotos.addTarget(self, action:#selector(btnShowPictures), for: .touchUpInside)
        
        return btnShowPhotos
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpUI()
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
        vStackView.addArrangedSubview(self.btnPlayAudioRecordered)
        vStackView.addArrangedSubview(self.btnPlayVideoRecordered)
        vStackView.addArrangedSubview(self.btnShowPhotos)
        vStackView.addArrangedSubview(bufferBottom)
        
        bufferTop.heightAnchor.constraint(equalTo: bufferBottom.heightAnchor).isActive = true
        
        self.btnPlayAudioRecordered.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.btnPlayVideoRecordered.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.btnShowPhotos.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.view.addSubview(vStackView)
        
        vStackView.bindToSuperView(top: 8, left: 8, bottom: 8, right: 8)
    }

    @objc
    func btnPlayAudio(){
        let viewPlayAudio = ViewCaptureAudioViewController()
        self.navigationController?.pushViewController(viewPlayAudio, animated: true)
    }
    
    @objc
    func btnPlayVideo(){
        
    }
    
    @objc
    func btnShowPictures(){
        
    }

}
