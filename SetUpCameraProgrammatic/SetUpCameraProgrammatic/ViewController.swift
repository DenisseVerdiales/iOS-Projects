//
//  ViewController.swift
//  SetUpCameraProgrammatic
//
//  Created by Consultant on 10/14/22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice!
    var frontCamera: AVCaptureDevice!
    var backInput: AVCaptureInput!
    var frontInput: AVCaptureInput!
    var captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
    var previewLayer = AVCaptureVideoPreviewLayer()
    var videoOutput = AVCaptureVideoDataOutput()
    var takePicture = false
    var backCameraOn = true

    
    lazy var cameraUIView: UIView = {
        let cameraUIView = UIView(frame: view.frame)
        cameraUIView.translatesAutoresizingMaskIntoConstraints = false
        //cameraUIView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        //cameraUIView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return cameraUIView
    }()
    
    lazy var tolbarShutterBtnUIView: UIView = {
        let tolbarShutterBtnUIView = UIView(frame: view.frame)
        tolbarShutterBtnUIView.translatesAutoresizingMaskIntoConstraints = false
        //cameraUIView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        //cameraUIView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return tolbarShutterBtnUIView
    }()
    
    lazy var switchCameraButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "switchcamera")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var captureImageButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .white
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var zoomViewControl: UIView = {
        let zoomViewControl = UIView()
        zoomViewControl.translatesAutoresizingMaskIntoConstraints = false
        zoomViewControl.backgroundColor = .gray
        zoomViewControl.layer.opacity = 0.5
        zoomViewControl.layer.cornerRadius = 15
        return zoomViewControl
    }()
    
    lazy var ultraWideBtn: UIButton = {
        let ultraWideBtn = UIButton()
        ultraWideBtn.translatesAutoresizingMaskIntoConstraints = false
        ultraWideBtn.layer.cornerRadius = 12
        ultraWideBtn.backgroundColor = .darkGray
        ultraWideBtn.tintColor = .darkGray
        ultraWideBtn.setTitle(".5", for: .normal)
        ultraWideBtn.setTitleColor(UIColor.white, for: .normal)
        ultraWideBtn.titleLabel?.font = .systemFont(ofSize: 12)
      //  ultraWideBtn.titleLabel?.font = UIFont(name: ".5x", size: 12)
        return ultraWideBtn
    }()
    
    lazy var WideBtn: UIButton = {
        let WideBtn = UIButton()
        WideBtn.translatesAutoresizingMaskIntoConstraints = false
        WideBtn.layer.cornerRadius = 12
        WideBtn.setTitle("1", for: .normal)
        WideBtn.backgroundColor = .darkGray
        WideBtn.tintColor = .darkGray
        WideBtn.titleLabel?.font = .systemFont(ofSize: 12)
        return WideBtn
    }()
    
    lazy var telephotoBtn: UIButton = {
        let telephotoBtn = UIButton()
        telephotoBtn.translatesAutoresizingMaskIntoConstraints = false
        telephotoBtn.layer.cornerRadius = 12
        telephotoBtn.setTitle("3", for: .normal)
        telephotoBtn.backgroundColor = .darkGray
        telephotoBtn.tintColor = .darkGray
        telephotoBtn.titleLabel?.font = .systemFont(ofSize: 12)
        return telephotoBtn
    }()
    
    lazy var exposureControl: UISlider = {
       let exposureControl = UISlider()
        exposureControl.translatesAutoresizingMaskIntoConstraints = false
        exposureControl.tintColor = UIColor.yellow
        exposureControl.maximumTrackTintColor = UIColor.yellow
        exposureControl.minimumTrackTintColor = UIColor.yellow
//        exposureControl.value = self.captureDevice?.iso ?? 0.5
//        exposureControl.minimumValue = self.captureDevice?.activeFormat.minISO ?? 0.0
//        exposureControl.maximumValue = self.captureDevice?.activeFormat.maxISO ?? 0.0
        exposureControl.clipsToBounds = true
        exposureControl.setThumbImage(UIImage(systemName: "sun.max.fill"), for: .normal)
        exposureControl.transform = CGAffineTransform(rotationAngle: -Double.pi / 2)
       // exposureControl.setMaximumTrackImage(UIImage(systemName: "line.vertical"), for: .normal)
        exposureControl.isContinuous = true
        exposureControl.addTarget(self, action: #selector(changeISOValueExposure), for: .touchUpInside)
        return exposureControl
    }()

    
    let capturedImageView = CapturedImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.checkPermissions()
        self.setupAndStartCaptureSession()
        
      
    }

    
    //camera setup
    func setupAndStartCaptureSession(){
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            //start configuration
            self.captureSession.beginConfiguration()
            
            //session specific configuration
            if self.captureSession.canSetSessionPreset(.photo)  {
                self.captureSession.sessionPreset = .photo
            }
            self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
            
            //setup inputs
            self.setupInputs()
            
            DispatchQueue.main.async {
                //setup preview layer
                self.setupPreviewLayer()
            }
            
            //setup output
            self.setupOutput()
            
            //commit configuration
            self.captureSession.commitConfiguration()
            //start running it
            self.captureSession.startRunning()
            
//            DispatchQueue.main.async {
//                self.configExposure()
//            }
        }
    }
    
    func setupInputs(){
        
        //get back camera
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back){
            self.backCamera = device
        }else{
            //handle this appropriately for production purposes
            fatalError("No back camera")
        }
        
        //fet front camera
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            self.frontCamera = device
        }else{
            fatalError("No front camera")
        }
        
        //now we need to create an input objects from our devices  // CHECK IT
        guard let bInput = try? AVCaptureDeviceInput(device: self.backCamera) else { fatalError("Could not create input device from back camera")}
        self.backInput = bInput
        
        if !captureSession.canAddInput(self.backInput){
            fatalError("Could not add back camera input to capture session")
        }
        
        guard let fInput = try? AVCaptureDeviceInput(device: self.frontCamera) else{
            fatalError("Could not create input device front camera")
        }
        self.frontInput = fInput
        
        if !self.captureSession.canAddInput(self.frontInput){
            fatalError("Could not add front camera input to capture session")
        }
        
        //connect back camera input to session
        captureSession.addInput(self.backInput)
        
    }
    
    func setupPreviewLayer(){
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
////        view.layer.insertSublayer(previewLayer, below: switchCameraButton.layer)
////        previewLayer.frame = self.view.layer.frame
////
//        cameraUIView.backgroundColor = .red
//        view.addSubview(cameraUIView)
//        cameraUIView.layer.insertSublayer(previewLayer, above: switchCameraButton.layer)
//        cameraUIView.layer.addSublayer(previewLayer)
//        previewLayer.frame = cameraUIView.layer.frame
        
      
    }
    
    func setupOutput(){
        let videoQueue = DispatchQueue(label: "videoQueue", qos: .userInteractive)
        self.videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        
        if self.captureSession.canAddOutput(self.videoOutput){
            self.captureSession.addOutput(self.videoOutput)
        }else{
            fatalError("Could not add video output")
        }
        
        self.videoOutput.connections.first?.videoOrientation = .portrait
    }
    
    func switchCameraInput(){
 
        self.captureSession.beginConfiguration()
        let currentInput = self.captureSession.inputs.first as? AVCaptureDeviceInput
        if let input = currentInput {
            self.captureSession.removeInput(input)
            let newCameraDevice = currentInput?.device.position == .back ? getCamera(with: .front) : getCamera(with: .back)
            if let device = newCameraDevice {
                let newVideInput = try? AVCaptureDeviceInput(device: device)
                self.captureDevice = newCameraDevice
                if let newInput = newVideInput { self.captureSession.addInput(newInput)}
            }
          
            self.captureSession.commitConfiguration()
        }
        
    }
    
    func getCamera(with position: AVCaptureDevice.Position) -> AVCaptureDevice?{
        AVCaptureDevice.default(.builtInWideAngleCamera, for: AVMediaType.video, position: position)
    }
    
    func configExposure(){
        print( self.captureDevice?.activeFormat.minISO)
        print( self.captureDevice?.activeFormat.maxISO )
        print( self.captureDevice?.iso )
        self.exposureControl.minimumValue = self.captureDevice?.activeFormat.minISO ?? 0
        self.exposureControl.maximumValue = self.captureDevice?.activeFormat.maxISO ?? 1
        self.exposureControl.value = Float(self.captureDevice?.iso ?? 0.5 )
        self.exposureControl.isEnabled = false
    }
    
    @objc func captureImage(){
        self.takePicture = true
    }
    
    @objc func switchCamera(){
        self.switchCameraInput()
    }
    
    @objc func changeISOValueExposure(){
       // ISOValueExposure()
    }
    @objc func didSwipeDown(){
        
        let yTraslationMin = self.captureDevice?.activeFormat.minISO ?? 0.0
        let yTraslationMax = self.captureDevice?.activeFormat.maxISO ?? 0.0

        let tolerance: Float = 5
        print("Down: \(self.captureDevice?.iso)")

        if self.exposureControl.value > abs(yTraslationMin){
                let newValue = self.exposureControl.value - Float(yTraslationMax) / Float(tolerance)
           // let newValue = self.exposureControl.value - Float(tolerance)
                self.exposureControl.setValue(newValue, animated: true)
            
            print("Down NEW VALUE: \(newValue)")
            print("Down  VALUE: \( self.exposureControl.value)")
            
        }else{
            self.exposureControl.setValue(yTraslationMin, animated: true)
        }
        

        ISOValueExposure()
      
    }
    
    @objc func didSwipeUp(){
        
        let yTraslation = self.captureDevice?.activeFormat.maxISO ?? 0.0

        let tolerance: Float = 5
        print("Up: \(self.captureDevice?.iso)")

        if self.exposureControl.value < abs(yTraslation){
            let newValue = self.exposureControl.value + Float(yTraslation) / Float(tolerance)
            //let newValue = self.exposureControl.value + Float(tolerance)
                self.exposureControl.setValue(newValue, animated: true)
            
            print("Up NEW VALUE: \(newValue)")
          
        }else{
            self.exposureControl.setValue(yTraslation, animated: true)
        }
       
        ISOValueExposure()
      
    }

    func ISOValueExposure(){
    
        do {
            try self.captureDevice?.lockForConfiguration()
            self.captureDevice?.setExposureModeCustom(duration: AVCaptureDevice.currentExposureDuration, iso: self.exposureControl.value)
        
            self.captureDevice?.unlockForConfiguration()
        }catch let error {
            NSLog("Could not lock device for configuration: \(error)")
        }
    }
    
    func addGestureExposure(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer{
        var swipeGesture = UISwipeGestureRecognizer()
        switch direction{
        case .up:
             swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUp))
        case .down:
            swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDown))
        default:
            break
        }
        
       
        swipeGesture.direction = direction
        return swipeGesture
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        if UIDevice.current.orientation.isLandscape{
          //  hStackViewContent.axis = .horizontal
          //  vStackViewCaptureBar.axis = .horizontal
//            NSLayoutConstraint.activate([
//            cameraUIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
//            cameraUIView.trailingAnchor.constraint(equalTo: captureImageButton.leadingAnchor,constant: 8),
//            ])
        }else{
           // hStackViewContent.axis = .horizontal
           // vStackViewCaptureBar.axis = .vertical
        }
    }
    
    func setupView(){
    //        let pan = UIPanGestureRecognizer(target: self, action: #selector(didSwipe))
    //        view.addGestureRecognizer(pan)
            
            let vStackViewContent = UIStackView(frame: .zero)
            vStackViewContent.translatesAutoresizingMaskIntoConstraints = false
            vStackViewContent.spacing = 10
            vStackViewContent.axis = .vertical
            vStackViewContent.distribution = .equalCentering
            
        let vStackViewCaptureBar = UIStackView(frame: .zero)
            vStackViewCaptureBar.translatesAutoresizingMaskIntoConstraints = false
            vStackViewCaptureBar.spacing = 10
            vStackViewCaptureBar.axis = .vertical
            vStackViewCaptureBar.distribution = .equalCentering
            
        let hStackViewContent = UIStackView(frame: .zero)
            hStackViewContent.translatesAutoresizingMaskIntoConstraints = false
            hStackViewContent.spacing = 8
            hStackViewContent.axis = .horizontal
            hStackViewContent.distribution = .fill
            hStackViewContent.backgroundColor = .blue
            view.backgroundColor = .black
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            view.layer.insertSublayer(previewLayer, below: switchCameraButton.layer)
            previewLayer.frame = self.view.layer.frame

            
            //view.addSubview(cameraUIView)
          //  cameraUIView.backgroundColor = .red
          //  cameraUIView.layer.insertSublayer(previewLayer, above: switchCameraButton.layer)
          //  cameraUIView.layer.addSublayer(previewLayer)
           // previewLayer.frame = cameraUIView.layer.frame
    //        previewLayer.frame = CGRect(x: 0, y: 0, width: cameraUIView.layer.frame.width, height: cameraUIView.layer.frame.width * (4/3))
    //        previewLayer.videoGravity = .resizeAspectFill
            
            vStackViewCaptureBar.addSubview(switchCameraButton)
            vStackViewCaptureBar.addSubview(captureImageButton)
            vStackViewCaptureBar.addSubview(capturedImageView)
         //   view.addSubview(exposureControl)
          //  view.addSubview(zoomViewControl)
           // view.addSubview(ultraWideBtn)
            vStackViewContent.addSubview(ultraWideBtn)
            vStackViewContent.addSubview(WideBtn)
            vStackViewContent.addSubview(telephotoBtn)
            
            zoomViewControl.addSubview(vStackViewContent)
            //view.addSubview(vStackViewCaptureBar)
    //        hStackViewContent.addSubview(cameraUIView)
            hStackViewContent.addSubview(zoomViewControl)
            hStackViewContent.addArrangedSubview(vStackViewCaptureBar)
            
            view.addSubview(hStackViewContent)
            
            let Supported = self.captureDevice?.isExposureModeSupported(.custom) ?? false
            
            if Supported {
                view.addGestureRecognizer(addGestureExposure(for: .up))
                view.addGestureRecognizer(addGestureExposure(for: .down))
            }
            
           NSLayoutConstraint.activate([
               switchCameraButton.widthAnchor.constraint(equalToConstant: 30),
               switchCameraButton.heightAnchor.constraint(equalToConstant: 30),
               switchCameraButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
               switchCameraButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),

               captureImageButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
               captureImageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
               captureImageButton.widthAnchor.constraint(equalToConstant: 50),
               captureImageButton.heightAnchor.constraint(equalToConstant: 50),

               capturedImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -22),
               capturedImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
               capturedImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.05, constant: 4),
               capturedImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.1, constant: 4),
    //
    //        cameraUIView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
    //           cameraUIView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120),
    //        cameraUIView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 8),
    //        cameraUIView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -8),
               
               //           exposureControl.widthAnchor.constraint(equalToConstant: 80),
               //           exposureControl.heightAnchor.constraint(equalToConstant: 20),
               //           exposureControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
               //           exposureControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
               zoomViewControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            zoomViewControl.bottomAnchor.constraint(equalTo: captureImageButton.bottomAnchor, constant: -80),
               zoomViewControl.widthAnchor.constraint(equalToConstant: 120),
               zoomViewControl.heightAnchor.constraint(equalToConstant: 35),
    
               ultraWideBtn.leadingAnchor.constraint(equalTo: zoomViewControl.leadingAnchor, constant: 10),
    //           ultraWideBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
               ultraWideBtn.topAnchor.constraint(equalTo: zoomViewControl.topAnchor, constant: 5),
               ultraWideBtn.bottomAnchor.constraint(equalTo: zoomViewControl.bottomAnchor, constant: -5),
               ultraWideBtn.widthAnchor.constraint(equalToConstant: 25),
               ultraWideBtn.heightAnchor.constraint(equalToConstant: 25),
    ////
               WideBtn.topAnchor.constraint(equalTo: zoomViewControl.topAnchor, constant: 5),
               WideBtn.bottomAnchor.constraint(equalTo: zoomViewControl.bottomAnchor, constant: -5),
               WideBtn.leadingAnchor.constraint(equalTo: ultraWideBtn.trailingAnchor, constant: 10),
             //  WideBtn.trailingAnchor.constraint(equalTo: telephotoBtn.trailingAnchor, constant: 10),
               WideBtn.widthAnchor.constraint(equalToConstant: 25),
               WideBtn.heightAnchor.constraint(equalToConstant: 25),
    
               telephotoBtn.topAnchor.constraint(equalTo: zoomViewControl.topAnchor, constant: 5),
               telephotoBtn.bottomAnchor.constraint(equalTo: zoomViewControl.bottomAnchor, constant: -5),
               telephotoBtn.leadingAnchor.constraint(equalTo: WideBtn.trailingAnchor, constant: 10),
               telephotoBtn.trailingAnchor.constraint(equalTo: zoomViewControl.trailingAnchor, constant: -10),
               telephotoBtn.widthAnchor.constraint(equalToConstant: 25),
               telephotoBtn.heightAnchor.constraint(equalToConstant: 25),
               
               hStackViewContent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
               hStackViewContent.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
               hStackViewContent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 5),
               hStackViewContent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
           ])
           
           switchCameraButton.addTarget(self, action: #selector(switchCamera), for: .touchUpInside)
           captureImageButton.addTarget(self, action: #selector(captureImage), for: .touchUpInside)
            guard let defaultValue = self.captureDevice?.activeFormat.maxISO else {return}
            self.exposureControl.minimumValue = self.captureDevice?.activeFormat.minISO ?? 0
            self.exposureControl.maximumValue = self.captureDevice?.activeFormat.maxISO ?? 1
            self.exposureControl.value = Float(defaultValue / 2 )
            //self.exposureControl.isEnabled = false
            print(self.exposureControl.value)
        }
    
    // Permissions
    func checkPermissions() {
        let cameraAuthStatus =  AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
        switch cameraAuthStatus {
          case .authorized:
            return
          case .denied:
            abort()
          case .notDetermined:
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler:
            { (authorized) in
              if(!authorized){
                abort()
              }
            })
          case .restricted:
            abort()
          @unknown default:
            fatalError()
        }
    }

}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate{
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection){
        
        if !self.takePicture{
            return
        }
        
        //try and get a CVImageBuffer out of the sample buffer
        guard let cvBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else{return}
        print(cvBuffer)
        
        //get a CIImage out of the CVImageBuffer
        let ciImage = CIImage(cvImageBuffer: cvBuffer)
        
        //get a CIImage out of CIImage
        let uiImage = UIImage(ciImage: ciImage)
        
        DispatchQueue.main.async {
            self.capturedImageView.image = uiImage
            self.takePicture = false
        }
    }
}
