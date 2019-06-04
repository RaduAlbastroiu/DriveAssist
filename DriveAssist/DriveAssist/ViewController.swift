//
//  ViewController.swift
//  DriveAssist
//
//  Created by Radu Albastroiu on 04/06/2019.
//  Copyright © 2019 Radu Albastroiu. All rights reserved.
//

import UIKit
import MapKit
import VideoToolbox
import AVFoundation
import Vision

class ViewController: UIViewController {
    @IBOutlet weak var previewLayer: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    var videoCapture: VideoCapture!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCamera()
    }
 
    func setUpCamera() {
        videoCapture = VideoCapture()
        videoCapture.delegate = nil
        videoCapture.fps = 50
        videoCapture.setUp(sessionPreset: AVCaptureSession.Preset.vga640x480, videoPreview: previewLayer)
    }

}

