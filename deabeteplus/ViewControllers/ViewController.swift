//
//  ViewController.swift
//  deabeteplus
//
//  Created by Ji Ra on 1/12/2562 BE.
//  Copyright © 2562 Ji Ra. All rights reserved.
//

import UIKit

// camera
import AVKit

// ML
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCamera()
        // Do any additional setup after loading the view.
    }


}


/// MARK : Camera
extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    private func setCamera() {
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        /// Set Input Image
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        /// Set Camera to BG
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraView.layer.addSublayer(previewLayer)
        previewLayer.frame = cameraView.frame
        
        /// Set Output image
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    
    }
    
    /// MARK : output image
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        // 1
        /// convert CMSampleBuffer to CVPixelBuffer
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
                        
        // 2
        guard let model = try? VNCoreMLModel(for: Food101().model) else { return }
        
        // 3
        let request = VNCoreMLRequest(model: model) { [weak self] (finishedReq, err) in
            // 5
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
                            
            guard let firstObservation = results.first else { return }
                            
            guard firstObservation.confidence > 0.8 else {
                DispatchQueue.main.async {
                    self?.textLabel.isHidden = true
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.textLabel.isHidden = false
                self?.textLabel.text = "\(firstObservation.identifier) : \(firstObservation.confidence)"
            }
        }
        
        // 4
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        
    }
}
