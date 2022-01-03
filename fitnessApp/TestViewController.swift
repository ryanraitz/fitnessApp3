//
//  TestViewController.swift
//  fitnessApp
//
//  Created by Ryan Raitz on 11/9/19.
//  Copyright © 2019 Ryan Raitz. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import WebKit

class TestViewController : UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var myTextLabel: UILabel!
    
    @IBOutlet weak var mindMuscleConnectionTextLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var watchDemoLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var selectedLocation : LocationModel?
    
    var webView: WKWebView!
    
    @IBAction func watchDemo(_ sender: Any) {
        
        // guard let path = Bundle.main.path(forResource: selectedLocation?.videoURL,
        //   ofType: "mp4") else { return }
        let url = selectedLocation?.videoURL
        guard let videoLink = URL(string: url!) else { return }
        //print(url!)
        //let player = AVPlayer(url: videoLink)
        //let playerViewController = AVPlayerViewController()
        //playerViewController.player = player
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        //self.present(playerViewController, animated: true) {
        //playerViewController.player?.play()
        //UIApplication.shared.open(videoLink)
        //UIApplication.shared.open(videoLink)
        webView.load(URLRequest(url: videoLink))
        
    }
    
    override func viewDidLoad()
    {
       
        if selectedLocation?.videoURL != "pyramid"
        {
        let url = selectedLocation?.videoURL
        guard let videoLink = URL(string: url!) else { return }
        //print(url!)
        //let player = AVPlayer(url: videoLink)
        //let playerViewController = AVPlayerViewController()
        //playerViewController.player = player
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        //self.present(playerViewController, animated: true) {
        //playerViewController.player?.play()
        //UIApplication.shared.open(videoLink)
        //UIApplication.shared.open(videoLink)
        webView.load(URLRequest(url: videoLink))
        }
        else
        {
            super.viewDidLoad()
            
            //Navigation bar styling
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.view.backgroundColor = .clear
            
            //Adding shadow to title label
            myLabel.layer.shadowColor = UIColor.black.cgColor
            myLabel.layer.shadowOffset = CGSize(width: 10, height: 10)
            myLabel.layer.shadowRadius = 10
            myLabel.layer.shadowOpacity = 1.0
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if selectedLocation?.videoURL != "pyramid"
        {
        let url = selectedLocation?.videoURL
        guard let videoLink = URL(string: url!) else { return }
        //print(url!)
        //let player = AVPlayer(url: videoLink)
        //let playerViewController = AVPlayerViewController()
        //playerViewController.player = player
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        //self.present(playerViewController, animated: true) {
        //playerViewController.player?.play()
        //UIApplication.shared.open(videoLink)
        //UIApplication.shared.open(videoLink)
        webView.load(URLRequest(url: videoLink))
        }
        else
        {
         // Initialize cell text labels to desired info
        myTextLabel.text = selectedLocation?.exerciseDescription
        
        //Dynamically size overview text field based on content
        myTextLabel.sizeToFit()
        myLabel.text = selectedLocation?.exerciseName
        
        //Dynamically size mind muscle connection text field based on content
        mindMuscleConnectionTextLabel.text = selectedLocation?.mmC
        mindMuscleConnectionTextLabel.sizeToFit()
        }
        
    }
    
}
