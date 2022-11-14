//
//  ZoomTabBarController.swift
//  SetUpCameraProgrammatic
//
//  Created by Consultant on 11/13/22.
//

import UIKit

class ZoomTabBarController: UIViewController {
    
    private var zoomTabBarView = UIView(frame: .zero)
    private var zoomUltraWideButton = UIButton(frame: .zero)
    private var zoomWideButton = UIButton(frame: .zero)
    private var zoomTelephotoButton = UIButton(frame: .zero)
    private var vZoomStackView = UIStackView(frame: .zero)
    
    private var zoomUltraWideSelected = [NSLayoutConstraint]()
    private var zoomWideSelected = [NSLayoutConstraint]()
    private var zoomTelephotoSelected = [NSLayoutConstraint]()
    private var zoomTabBarPortrait = [NSLayoutConstraint]()
    private var zoomTabBarLandscape = [NSLayoutConstraint]()
    private var zoomTabBarWithoutUltra = NSLayoutConstraint()
    private var zoomTabBarWithUltra = NSLayoutConstraint()
    private var zoomTelephotoButtonConstraint = NSLayoutConstraint()
    private var zoomUltraButtonConstraint = NSLayoutConstraint()
    private var zoomTabBarWithoutUltraAndTelephoto = NSLayoutConstraint()
    private var zoomWideButtonConstraint = NSLayoutConstraint()
    
    private var zoomAvailable: ZoomLenses = ZoomLenses.wide

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setupZoomTabBar(parentView: UIView) {
        parentView.addSubview(zoomTabBarView)
        vZoomStackView.addSubview(zoomUltraWideButton)
        vZoomStackView.addSubview(zoomWideButton)
        vZoomStackView.addSubview(zoomTelephotoButton)
        zoomTabBarView.addSubview(vZoomStackView)
        
        zoomTabBarView.layer.cornerRadius = 18
        zoomTabBarView.backgroundColor = UIColor(hex: "#C7C7C7")?.withAlphaComponent(0.25)
        
        zoomTabBarView.translatesAutoresizingMaskIntoConstraints = false
        zoomTabBarView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        zoomTabBarView.bounds.size.width = parentView.frame.width
        zoomTabBarView.center = parentView.center
        zoomTabBarWithUltra = zoomTabBarView.widthAnchor.constraint(equalToConstant: 112)
        zoomTabBarWithoutUltra = zoomTabBarView.widthAnchor.constraint(equalToConstant: 80)
        zoomTabBarWithoutUltraAndTelephoto = zoomTabBarView.widthAnchor.constraint(equalToConstant: 45)
        
        let previewHeight = (view.bounds.width + view.safeAreaInsets.left + view.safeAreaInsets.right) * (4/3)
        let remainingHeight = view.bounds.height - previewHeight
        let topBarHeight = (remainingHeight / 100) * 20
        
        zoomTabBarPortrait = [
            zoomTabBarView.centerXAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.centerXAnchor),
            zoomTabBarView.bottomAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: (topBarHeight + previewHeight) - 7)
        ]
        
        NSLayoutConstraint.activate(zoomTabBarPortrait)
        zoomTabBarWithUltra.isActive = true
        setupZoomBtns()
    }
    
    func setupZoomBtns() {
        vZoomStackView.spacing = 10
        vZoomStackView.axis = .vertical
        vZoomStackView.distribution = .equalSpacing
        vZoomStackView.translatesAutoresizingMaskIntoConstraints = false
        vZoomStackView.topAnchor.constraint(equalTo: zoomTabBarView.topAnchor, constant: 6).isActive = true
        vZoomStackView.bottomAnchor.constraint(equalTo: zoomTabBarView.bottomAnchor, constant: -6).isActive = true
        vZoomStackView.leadingAnchor.constraint(equalTo: zoomTabBarView.leadingAnchor, constant: 6).isActive = true
        vZoomStackView.trailingAnchor.constraint(equalTo: zoomTabBarView.trailingAnchor, constant: -6).isActive = true
        
        zoomUltraWideButton.tag = 0
        zoomUltraWideButton.backgroundColor = UIColor(hex: "#323232")?.withAlphaComponent(0.75)
        zoomUltraWideButton.titleLabel?.layer.opacity = 1
        zoomUltraWideButton.translatesAutoresizingMaskIntoConstraints = false
        zoomUltraWideButton.addTarget(self, action: #selector(didTouchZoomButton), for: .touchUpInside)
        zoomUltraButtonConstraint = zoomUltraWideButton.leadingAnchor.constraint(equalTo: zoomTabBarView.leadingAnchor, constant: 8)
        
        zoomWideButton.tag = 1
        zoomWideButton.backgroundColor = UIColor(hex: "#323232")?.withAlphaComponent(0.75)
        zoomWideButton.titleLabel?.layer.opacity = 1
        zoomWideButton.translatesAutoresizingMaskIntoConstraints = false
        zoomWideButton.addTarget(self, action: #selector(didTouchZoomButton), for: .touchUpInside)
        zoomWideButtonConstraint = zoomWideButton.leadingAnchor.constraint(equalTo: zoomUltraWideButton.leadingAnchor, constant: 8)
        
        zoomTelephotoButton.tag = 2
        zoomTelephotoButton.backgroundColor = UIColor(hex: "#323232")?.withAlphaComponent(0.75)
        zoomTelephotoButton.titleLabel?.layer.opacity = 1
        zoomTelephotoButton.translatesAutoresizingMaskIntoConstraints = false
        zoomTelephotoButton.addTarget(self, action: #selector(didTouchZoomButton), for: .touchUpInside)
        zoomTelephotoButtonConstraint = zoomTelephotoButton.leadingAnchor.constraint(equalTo: zoomWideButton.leadingAnchor, constant: 8)
        zoomTelephotoButton.trailingAnchor.constraint(equalTo: zoomTabBarView.trailingAnchor, constant: -8).isActive = true
        
        //setConstraintZoom()
        NSLayoutConstraint.activate(zoomWideSelected)
        zoomTelephotoButtonConstraint.isActive = true
        zoomUltraButtonConstraint.isActive = true
        zoomWideButtonConstraint.isActive = true
        //setUpZoomBtnsWideSelected()
    }
    
    func setUpZoomBtnsUltraWideSelected(pinching: Bool = false, value: String = "") {
        if pinching {
            zoomUltraWideButton.setTitle("\(value)x", for: .normal)
        } else {
            setupZoomBtnsWideUltraWide()
            zoomUltraWideButton.setTitle("0.5x", for: .normal)
           // guard let zoomFactor = viewModel.captureDevice?.videoZoomFactor else {return}
            //viewModel.updateLastZoom(currentValue: zoomFactor)
            //viewModel.setCaptureDeviceZoom(zoomFactor: zoomFactor)
            //viewModel.currentZoomSelected(currentZoom: ZoomState.ultraWide)
        }
        
        zoomUltraWideButton.layer.cornerRadius = 16
        zoomUltraWideButton.titleLabel?.font = .systemFont(ofSize: 12)
        zoomUltraWideButton.setTitleColor(UIColor(hex: "#FFD700"), for: .normal)
        
        zoomWideButton.setTitle("1", for: .normal)
        zoomWideButton.layer.cornerRadius = 12
        zoomWideButton.titleLabel?.font = .systemFont(ofSize: 10)
        zoomWideButton.setTitleColor(UIColor(hex: "#FFF"), for: .normal)
        
        zoomTelephotoButton.setTitle("3", for: .normal)
        zoomTelephotoButton.layer.cornerRadius = 12
        zoomTelephotoButton.titleLabel?.font = .systemFont(ofSize: 10)
        zoomTelephotoButton.setTitleColor(UIColor(hex: "#FFF"), for: .normal)
    }
    
    func setupZoomBtnsWideUltraWide() {
        self.zoomAvailable = getZoomAvailable()
        
        if self.zoomAvailable == ZoomLenses.wideTelephoto {
            zoomTelephotoButton.isHidden = false
            zoomUltraWideButton.isHidden = true
            zoomTabBarWithUltra.isActive = false
            zoomTabBarWithoutUltra.isActive = true
            zoomTelephotoButtonConstraint.isActive = true
            zoomUltraButtonConstraint.isActive = false
        } else if self.zoomAvailable == ZoomLenses.wide {
            zoomTelephotoButton.isHidden = true
            zoomUltraWideButton.isHidden = true
            zoomTabBarWithUltra.isActive = false
            zoomTabBarWithoutUltra.isActive = true
            zoomTelephotoButtonConstraint.isActive = false
            zoomUltraButtonConstraint.isActive = false
            zoomTabBarWithoutUltraAndTelephoto.isActive = true
            zoomWideButtonConstraint.isActive = false
        } else if self.zoomAvailable == ZoomLenses.wideUltraWide {
            zoomTelephotoButton.isHidden = true
            zoomUltraWideButton.isHidden = false
            zoomTabBarWithUltra.isActive = false
            zoomTabBarWithoutUltra.isActive = true
            zoomTelephotoButtonConstraint.isActive = false
            zoomUltraButtonConstraint.isActive = false
            zoomWideButtonConstraint.isActive = false
        } else if self.zoomAvailable == ZoomLenses.noShown {
            zoomTabBarView.isHidden = true
        }
    }
    
    func setupZoomBtnsWideSelected(pinching: Bool = false, value: String = "") {
        
        if pinching {
            zoomWideButton.setTitle("\(value)x", for: .normal)
        } else {
            setupZoomBtnsWideUltraWide()
            zoomWideButton.setTitle("1x", for: .normal)
           // guard let zoomFactor = viewModel.captureDevice?.videoZoomFactor else {return}
            //viewModel.updateLastZoom(currentValue: zoomFactor)
            //viewModel.setCaptureDeviceZoom(zoomFactor: zoomFactor)
            //viewModel.currentZoomSelected(currentZoom: ZoomState.wide)
        }
        
        zoomUltraWideButton.setTitle("0.5", for: .normal)
        zoomUltraWideButton.layer.cornerRadius = 12
        zoomUltraWideButton.titleLabel?.font = .systemFont(ofSize: 10)
        zoomUltraWideButton.setTitleColor(UIColor(hex: "#FFF"), for: .normal)
        
        zoomWideButton.layer.cornerRadius = 16
        zoomWideButton.titleLabel?.font = .systemFont(ofSize: 12)
        zoomWideButton.setTitleColor(UIColor(hex: "#FFD700"), for: .normal)
        
        zoomTelephotoButton.setTitle("3", for: .normal)
        zoomTelephotoButton.layer.cornerRadius = 12
        zoomTelephotoButton.titleLabel?.font = .systemFont(ofSize: 10)
        zoomTelephotoButton.setTitleColor(UIColor(hex: "#FFF"), for: .normal)
    }
    
    func updateTitleAndZoomFromPinch(pinching: Bool, scaleFactor scaleFactorValue: String) {
        
        if pinching {
            zoomTelephotoButton.setTitle("\(scaleFactorValue)x", for: .normal)
            return
        }
        
        setUpZoomBtnsTelephoto()
        zoomTelephotoButton.setTitle("3x", for: .normal)
        //viewModel.updateLastZoom(currentValue: viewModel.minimunZoom)
        //viewModel.setCaptureDeviceZoom(zoomFactor: viewModel.minimunZoom)
        //viewModel.currentZoomSelected(currentZoom: ZoomState.wide)
    }
    
    func setUpZoomBtnsTelephotoSelected(pinching: Bool = false, value: String = "") {
        updateTitleAndZoomFromPinch(pinching: pinching, scaleFactor: value)
        
        zoomUltraWideButton.setTitle("0.5", for: .normal)
        zoomUltraWideButton.layer.cornerRadius = 12
        zoomUltraWideButton.titleLabel?.font = .systemFont(ofSize: 10)
        zoomUltraWideButton.setTitleColor(UIColor(hex: "#FFF"), for: .normal)
        
        zoomWideButton.setTitle("3", for: .normal)
        zoomWideButton.layer.cornerRadius = 12
        zoomWideButton.titleLabel?.font = .systemFont(ofSize: 10)
        zoomWideButton.setTitleColor(UIColor(hex: "#FFF"), for: .normal)
        
        zoomTelephotoButton.layer.cornerRadius = 16
        zoomTelephotoButton.titleLabel?.font = .systemFont(ofSize: 12)
        zoomTelephotoButton.setTitleColor(UIColor(hex: "#FFD700"), for: .normal)
    }
    
    func setUpZoomBtnsTelephoto() {
        self.zoomAvailable = getZoomAvailable()
        switch self.zoomAvailable {
        case ZoomLenses.wideTelephoto:
            zoomTelephotoButton.isHidden = false
            zoomUltraWideButton.isHidden = true
            zoomTabBarWithUltra.isActive = false
            zoomTabBarWithoutUltra.isActive = true
            zoomTelephotoButtonConstraint.isActive = true
            zoomUltraButtonConstraint.isActive = false
        case ZoomLenses.wide:
            zoomTelephotoButton.isHidden = true
            zoomUltraWideButton.isHidden = true
            zoomTabBarWithUltra.isActive = false
            zoomTabBarWithoutUltra.isActive = true
            zoomTelephotoButtonConstraint.isActive = false
            zoomUltraButtonConstraint.isActive = false
            zoomTabBarWithoutUltraAndTelephoto.isActive = true
            zoomWideButtonConstraint.isActive = false
        case ZoomLenses.wideUltraWide:
            zoomTelephotoButton.isHidden = true
            zoomUltraWideButton.isHidden = false
            zoomTabBarWithUltra.isActive = false
            zoomTabBarWithoutUltra.isActive = true
            zoomTelephotoButtonConstraint.isActive = false
            zoomUltraButtonConstraint.isActive = false
            zoomWideButtonConstraint.isActive = false
        case ZoomLenses.noShown:
            zoomTabBarView.isHidden = true
        default:
            zoomTelephotoButton.isHidden = false
            zoomTabBarWithUltra.isActive = true
            zoomTabBarWithoutUltra.isActive = false
            zoomTelephotoButtonConstraint.isActive = true
        }
    }
    
    func setConstraintsZoom() {
        zoomUltraWideSelected = [
            zoomUltraWideButton.bottomAnchor.constraint(equalTo: zoomTabBarView.bottomAnchor, constant: -2),
            zoomUltraWideButton.topAnchor.constraint(equalTo: zoomTabBarView.topAnchor, constant: 2),
            zoomWideButton.bottomAnchor.constraint(equalTo: zoomTabBarView.bottomAnchor, constant: -6),
            zoomWideButton.topAnchor.constraint(equalTo: zoomTabBarView.topAnchor, constant: 6),
            zoomTelephotoButton.bottomAnchor.constraint(equalTo: zoomTabBarView.bottomAnchor, constant: -6),
            zoomTelephotoButton.topAnchor.constraint(equalTo: zoomTabBarView.topAnchor, constant: 6),
            zoomUltraWideButton.widthAnchor.constraint(equalToConstant: 32),
            zoomUltraWideButton.heightAnchor.constraint(equalToConstant: 32),
            zoomWideButton.widthAnchor.constraint(equalToConstant: 24),
            zoomWideButton.heightAnchor.constraint(equalToConstant: 24),
            zoomTelephotoButton.widthAnchor.constraint(equalToConstant: 24),
            zoomTelephotoButton.heightAnchor.constraint(equalToConstant: 24)
        ]
        zoomWideSelected = [
            zoomUltraWideButton.bottomAnchor.constraint(equalTo: zoomTabBarView.bottomAnchor, constant: -6),
            zoomUltraWideButton.topAnchor.constraint(equalTo: zoomTabBarView.topAnchor, constant: 6),
            zoomWideButton.bottomAnchor.constraint(equalTo: zoomTabBarView.bottomAnchor, constant: -2),
            zoomWideButton.topAnchor.constraint(equalTo: zoomTabBarView.topAnchor, constant: 2),
            zoomTelephotoButton.bottomAnchor.constraint(equalTo: zoomTabBarView.bottomAnchor, constant: -6),
            zoomTelephotoButton.topAnchor.constraint(equalTo: zoomTabBarView.topAnchor, constant: 6),
            zoomUltraWideButton.widthAnchor.constraint(equalToConstant: 24),
            zoomUltraWideButton.heightAnchor.constraint(equalToConstant: 24),
            zoomWideButton.widthAnchor.constraint(equalToConstant: 32),
            zoomWideButton.heightAnchor.constraint(equalToConstant: 32),
            zoomTelephotoButton.widthAnchor.constraint(equalToConstant: 24),
            zoomTelephotoButton.heightAnchor.constraint(equalToConstant: 24)
        ]
        zoomTelephotoSelected = [
            zoomUltraWideButton.bottomAnchor.constraint(equalTo: zoomTabBarView.bottomAnchor, constant: -6),
            zoomUltraWideButton.topAnchor.constraint(equalTo: zoomTabBarView.topAnchor, constant: 6),
            zoomWideButton.bottomAnchor.constraint(equalTo: zoomTabBarView.bottomAnchor, constant: -6),
            zoomWideButton.topAnchor.constraint(equalTo: zoomTabBarView.topAnchor, constant: 6),
            zoomTelephotoButton.bottomAnchor.constraint(equalTo: zoomTabBarView.bottomAnchor, constant: -2),
            zoomTelephotoButton.topAnchor.constraint(equalTo: zoomTabBarView.topAnchor, constant: 2),
            zoomUltraWideButton.widthAnchor.constraint(equalToConstant: 24),
            zoomUltraWideButton.heightAnchor.constraint(equalToConstant: 24),
            zoomWideButton.widthAnchor.constraint(equalToConstant: 24),
            zoomWideButton.heightAnchor.constraint(equalToConstant: 24),
            zoomTelephotoButton.widthAnchor.constraint(equalToConstant: 32),
            zoomTelephotoButton.heightAnchor.constraint(equalToConstant: 32)
        ]
    }
    
    func setZoomTabBarOrientation(_ orientation: UIDeviceOrientation) {
        var rotation: Double = 0.0
        var centerY: Double = 0.0
        var centerX: Double = 0.0
        
        let previewHeight = (view.bounds.width + view.safeAreaInsets.left + view.safeAreaInsets.right) * (4/3)
        let remainingHeight = view.bounds.height - previewHeight
        let topBarHeight = (remainingHeight / 100) * 20
        
        switch orientation {
        case .portrait:
            rotation = 0.0
            centerY = (topBarHeight + previewHeight) - 25
            centerX = self.view.center.x
        case .portraitUpsideDown:
            rotation = .pi
            centerY = (topBarHeight + previewHeight) - 25
            centerX = self.view.center.x
        case .landscapeLeft:
            rotation = .pi / 2
            centerY = self.view.bounds.minY + topBarHeight + (previewHeight / 2)
            centerX = self.view.bounds.minX + 25
        case .landscapeRight:
            rotation = -.pi / 2
            centerY = self.view.bounds.minY + topBarHeight + (previewHeight / 2)
            centerX = self.view.bounds.minX - 25
        default:
            return
        }
        
        let transform = CGAffineTransform(rotationAngle: rotation)
        
        UIView.animate(withDuration: 0.5) {
            self.zoomTabBarView.transform = transform
            self.zoomTabBarView.center.x = centerX
            self.zoomTabBarView.center.y = centerY
        }
    }
    
    func setLabelsZoomValueUltraWide(zoom: CGFloat) {
        let stringValue = String(format: "%.1f", CGFloat(zoom / 2.0))
        
        if stringValue < "1.0" {
            setUpZoomBtnsUltraWideSelected(pinching: true, value: stringValue)
            NSLayoutConstraint.deactivate(zoomWideSelected)
            NSLayoutConstraint.deactivate(zoomTelephotoSelected)
            NSLayoutConstraint.activate(zoomUltraWideSelected)
        } else {
            //viewModel.updateLastZoom(currentValue: viewModel.minimunZoom)
            //viewModel.currentZoomSelected(currentZoom: ZoomState.wide)
            //viewModel.countZoom = 0
        }
    }
    
    func setLabelsZoomValueWide(zoom: CGFloat) {
        let stringValue = String(format: "%.1f", CGFloat(zoom))
        
        if self.zoomAvailable == ZoomLenses.dual || self.zoomAvailable == ZoomLenses.wideTelephoto {
            if stringValue < "3.0" {
                setupZoomBtnsWideSelected(pinching: true, value: stringValue)
                NSLayoutConstraint.deactivate(zoomUltraWideSelected)
                NSLayoutConstraint.deactivate(zoomTelephotoSelected)
                NSLayoutConstraint.activate(zoomWideSelected)
            } else {
                setUpZoomBtnsTelephotoSelected(pinching: true, value: stringValue)
                NSLayoutConstraint.deactivate(zoomUltraWideSelected)
                NSLayoutConstraint.deactivate(zoomWideSelected)
                NSLayoutConstraint.activate(zoomTelephotoSelected)
            }
        } else {
            setupZoomBtnsWideSelected(pinching: true, value: stringValue)
            NSLayoutConstraint.deactivate(zoomUltraWideSelected)
            NSLayoutConstraint.deactivate(zoomTelephotoSelected)
            NSLayoutConstraint.activate(zoomWideSelected)
        }
    }
    
    func setLabelsZoomValueTelephoto(zoom: CGFloat) {
        let stringValue = String(format: "%.1f", CGFloat(zoom + 2.0))
        
        if stringValue > "3.0" {
            setUpZoomBtnsTelephotoSelected(pinching: true, value: stringValue)
            NSLayoutConstraint.deactivate(zoomUltraWideSelected)
            NSLayoutConstraint.deactivate(zoomWideSelected)
            NSLayoutConstraint.activate(zoomTelephotoSelected)
        } else {
           // viewModel.currentZoomSelected(currentZoom: ZoomState.wide)
            //viewModel.updateLastZoom(currentValue: viewModel.minimun + 1.9)
        }
    }

    func setLabelsZoomValue(zoom: CGFloat) {
       // let transition = String(format: "%.1f", CGFloat(viewModel.transitionZoom))
        let zoomValue = String(format: "%.1f", CGFloat(zoom))
        if self.zoomAvailable == ZoomLenses.dual || self.zoomAvailable == ZoomLenses.wideUltraWide {
//            if transition == "0.9" && viewModel.countZoom == 0 && viewModel.currentZoomSelected == ZoomState.wide && zoomValue == "1.0" {
//               // self.viewModel.updateLastZoom(currentValue: self.viewModel.minimunZoom + 0.8)
               // self.viewModel.currentZoomSelected(currentZoom: ZoomState.ultraWide)
               // self.viewModel.countZoom = 1
            //}
        }
        
//        switch viewModel.currentZoomSelected {
//        case .ultraWide:
//            setLabelsZoomValueUltraWide(zoom: zoom)
//        case .wide:
//            setLabelsZoomValueWide(zoom: zoom)
//        case .telePhoto:
//            setLabelsZoomValueTelephoto(zoom: zoom)
//        }
    }
    
    func getDefaultZoomAvailable() -> ZoomLenses {
        if #available(iOS 16, *) {
            return ZoomLenses.wide
        }
        return ZoomLenses.noShown
    }
    
    func getZoomAvailable() -> ZoomLenses {
        guard let device = UIDevice.getDeviceModel() else {
            return getDefaultZoomAvailable()
        }
        
        switch device {
        case .iPhone13Pro, .iPhone12ProMax, .iPhone14Pro, .iPhone14ProMax:
            return ZoomLenses.dual
        case .iPhoneXSMax, .iPhoneXS, .iPhoneX, .iPhone7Plus:
            return ZoomLenses.wideTelephoto
        case .iPhone13, .iPhone13mini, .iPhone12, .iPhone12mini:
            return ZoomLenses.wideUltraWide
        default:
            return getDefaultZoomAvailable()
        }
    }
    
    @objc func didTouchZoomButton(sender: UIButton) {
        switch sender.tag {
        case ZoomState.ultraWide.rawValue:
            setUpZoomBtnsUltraWideSelected()
            NSLayoutConstraint.deactivate(zoomTelephotoSelected)
            NSLayoutConstraint.deactivate(zoomWideSelected)
            NSLayoutConstraint.activate(zoomUltraWideSelected)
        case ZoomState.wide.rawValue:
            setupZoomBtnsWideSelected()
            NSLayoutConstraint.deactivate(zoomTelephotoSelected)
            NSLayoutConstraint.deactivate(zoomUltraWideSelected)
            NSLayoutConstraint.activate(zoomWideSelected)
        case ZoomState.telePhoto.rawValue:
            setUpZoomBtnsTelephotoSelected()
            NSLayoutConstraint.deactivate(zoomWideSelected)
            NSLayoutConstraint.deactivate(zoomUltraWideSelected)
            NSLayoutConstraint.activate(zoomTelephotoSelected)
        default:
            break
        }
    }
}
