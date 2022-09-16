//
//  ViewController.swift
//  Capture
//
//  Created by Consultant on 9/15/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var btnCapture: UIButton = {
        let btnCapture = UIButton(frame: .zero)
        btnCapture.translatesAutoresizingMaskIntoConstraints = false
        btnCapture.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnCapture.backgroundColor = .orange
        btnCapture.setTitle("Capture", for: .normal)
        btnCapture.setTitleColor(.white, for: .normal)
        btnCapture.layer.cornerRadius = 5
        btnCapture.addTarget(self, action: #selector(btnOpcCapture), for: .touchUpInside)
        
        return btnCapture
        
    }()
    
    lazy var btnViewCapture: UIButton = {
        let btnViewCapture = UIButton(frame: .zero)
        btnViewCapture.translatesAutoresizingMaskIntoConstraints = false
        btnViewCapture.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btnViewCapture.backgroundColor = .orange
        btnViewCapture.setTitle("View", for: .normal)
        btnViewCapture.setTitleColor(.white, for: .normal)
        btnViewCapture.layer.cornerRadius = 5
        btnViewCapture.addTarget(self, action: #selector(btnOpcViewCapture), for: .touchUpInside)
        
        return btnViewCapture
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
        vStackView.addArrangedSubview(self.btnCapture)
        vStackView.addArrangedSubview(self.btnViewCapture)
        vStackView.addArrangedSubview(BufferBottom)
        
        BufferTop.heightAnchor.constraint(equalTo: BufferBottom.heightAnchor).isActive = true
    
        self.btnCapture.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.btnCapture.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.view.addSubview(vStackView)
        
        vStackView.bindToSuperView(top: 8, left: 8, bottom: 8, right: 8)
      
    }
    
    @objc
    func btnOpcCapture(){
        let captureOpc = CaptureViewController()
        self.navigationController?.pushViewController(captureOpc, animated: true)
    }
    
    @objc
    func btnOpcViewCapture(){
        let viewCaptureOpc = ViewCaptureViewController()
        self.navigationController?.pushViewController(viewCaptureOpc, animated: true)
    }
    
}
