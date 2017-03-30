//
//  ViewController.swift
//  RBHUD
//
//  Created by Robert Bojor on 09/25/2015.
//  Copyright (c) 2015 Robert Bojor. All rights reserved.
//

import UIKit
import RBHUD

class ViewController: UIViewController {
    
    var hud = RBHUD.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the HUD
        // Any of the configuration variables can be skipped and they'll default to the values used below
        
        // The opacity of the background
        self.hud.backdropOpacity = 0.8
        
        // Option for the background if it should use a blur effect or not
        self.hud.backdropUsesBlur = true
        // The blur style, if it's using a blue effect
        self.hud.backdropBlurStyle = UIBlurEffectStyle.dark
        // The background color of the overlay, if not using a blur effect
        self.hud.backdropColor = UIColor(red:0.23, green:0.26, blue:0.29, alpha:1)
        
        // The progress indicator line width
        self.hud.progressViewLineWidth = 1.0
        // The progress indicator's size on the screen
        self.hud.progressViewSize = 64.0
        // The top and bottom padding between the progress indicator and any other elements on the screen
        self.hud.progressViewPadding = 10.0
        // The color of the progress view stroke line
        self.hud.progressViewStrokeColor = UIColor.white
        // The fill color of the progress view
        self.hud.progressViewFillColor = UIColor.clear
        
        // The line width for the success mark
        self.hud.successViewLineWidth = 1.0
        // The line color for the success mark
        self.hud.successViewStrokeColor = UIColor.green
        
        // The line width for the error mark
        self.hud.errorViewLineWidth = 1.0
        // The line color for the error mark
        self.hud.errorViewStrokeColor = UIColor.red
        
        // The distance the text labels have to travel when appearing
        self.hud.labelAnimationDistance = 50.0
        // The font name for the text labels
        self.hud.labelFontName = "HelveticaNeue-Light"
        // The font size for the title label
        self.hud.labelTitleFontSize = 20.0
        // The text color of the title label
        self.hud.labelTitleTextColor = UIColor.white
        
        // The font size for the subtitle label
        self.hud.labelSubtitleFontSize = 13.0
        // The text color for the subtitle label
        self.hud.labelSubtitleTextColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startLoader(_ sender: AnyObject) {
        selector_0()
    }
    
    @IBAction func showSuccessHUD(_ sender: AnyObject) {
        self.hud.showWithSuccess(self.view, withTitle: "Success", withSubTitle: "The task ended up successfully!")
    }
    @IBAction func showErrorHUD(_ sender: AnyObject) {
        self.hud.showWithError(self.view, withTitle: "Oops!", withSubTitle: "A sample error occured!")
    }
    func selector_0()
    {
        // HUD with only a title
        self.hud.showLoader(self.view, withTitle: "Just a title", withSubtitle: nil, withProgress: false)
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ViewController.selector_1), userInfo: nil, repeats: false)
    }
    func selector_1()
    {
        // HUD with a title and subtitle
        self.hud.showLoader(self.view, withTitle: "Another title, but also", withSubtitle: "a subtitle, \non multiple rows", withProgress: false)
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ViewController.selector_2), userInfo: nil, repeats: false)
    }
    
    func selector_2()
    {
        // HUD with a title, subtitle and a progress view
        self.hud.showLoader(self.view, withTitle: "Now I have a title and \na progress view!", withSubtitle: "But also a subtitle... Magic innit?", withProgress: true)
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ViewController.selector_3), userInfo: nil, repeats: false)
    }
    
    func selector_3()
    {
        // HUD with just a progress view
        self.hud.showLoader(self.view, withTitle: nil, withSubtitle: nil, withProgress: true)
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ViewController.selector_4), userInfo: nil, repeats: false)
    }
    
    func selector_4()
    {
        // HUD with a title and a progress view
        self.hud.showLoader(self.view, withTitle: "That was just a progress view.\nNothing's broken...", withSubtitle: nil, withProgress: true)
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ViewController.selector_5), userInfo: nil, repeats: false)
    }
    func selector_5()
    {
        // HUD with a title, subtitle and a progress view
        self.hud.showLoader(self.view, withTitle: "That was just a progress view.\nNothing's broken...", withSubtitle: "Next I'll dissapear...\nBye bye!", withProgress: true)
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ViewController.selector_6), userInfo: nil, repeats: false)
    }
    
    func selector_6()
    {
        self.hud.hideLoader()
    }
}

