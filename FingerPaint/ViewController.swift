//
//  ViewController.swift
//  FingerPaint
//
//  Created by darkgod on 14/10/31.
//  Copyright (c) 2014年 darkgod. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var canvasView : CanvasView!
    var clearButton: UIButton = UIButton()
    var clearButtonShadow: UIButton? {
        didSet {
            if clearButtonShadow != oldValue {
                oldValue?.layer.shadowRadius = 0
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // `self.view` is the root view loaded from the storyboard
        
        // Instantiate the canvas view. It should be the same size and position as the root view.
        let canvasView = CanvasView(frame: self.view.bounds)
        self.canvasView = canvasView
        //self.canvasView = CanvasView(frame: self.view.frame)
        self.canvasView.backgroundColor = UIColor.whiteColor()
        
        // Add the canvas view to the root view
        self.view.addSubview(canvasView)
        //UIButton button = [UIButton .buttonWithType(UIButtonType.Custom)]
        setupColorPickers()
        setupClearButton()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupColorPickers() {
        // Colors for the pickers.
        // Or you can choose a color scheme you like: https://kuler.adove.com/explore/most-popular/
        let colors : [UIColor] = [
            // 0x000000
            UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            // 0x17A3A5
            UIColor(red: 0x17/255.0, green: 0xA3/255.0, blue: 0xA5/255.0, alpha: 1),
            // 0x8DBF67
            UIColor(red: 0x8D/255.0, green: 0xBF/255.0, blue: 0x67/255.0, alpha: 1),
            // 0xFCCB5F
            UIColor(red: 0xFC/255.0, green: 0xCB/255.0, blue: 0x5F/255.0, alpha: 1),
            // 0xFC6E59
            UIColor(red: 0xFC/255.0, green: 0x6E/255.0, blue: 0x59/255.0, alpha: 1)
        ]
        
        // (x,y)
        let positions = [(33,43), (86,43), (138,43), (190,43), (242,43)]
        
        // size
        let size = (44,44)
        
        // TODO: Create UIButton and add them to the view hierarchy
        //
        // ...
        for (var i = 0; i < 5; i++) {
            //UIButton *button = [UIButton .buttonWithType(UIButtonType.Custom)]
            let button = UIButton(frame: CGRectMake(CGFloat(positions[i].0), CGFloat(positions[i].1), CGFloat(size.0), CGFloat(size.1)))
            button.backgroundColor = colors[i]
            button.addTarget(self, action: "colorPickerTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            if (i == 0) {
                button.layer.shadowColor = UIColor(white: 0.4, alpha: 1).CGColor
                button.layer.shadowOffset = CGSize(width: 0, height: 0)
                button.layer.shadowRadius = 3
                button.layer.shadowOpacity = 1
                clearButtonShadow = button
            }
            self.view.addSubview(button)
        }
    }
    
    func colorPickerTapped(button: UIButton) {
        button.layer.shadowColor = UIColor(white: 0.4, alpha: 1).CGColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 3
        button.layer.shadowOpacity = 1
        
        clearButtonShadow = button
        println("tapped: \(button.backgroundColor)")
        canvasView.currentColor = button.backgroundColor
    }
    
    func setupClearButton() {
        let button = UIButton.buttonWithType(UIButtonType.System) as UIButton
        self.clearButton = button
        button.frame = CGRect(x: 267, y: 518, width: 37, height: 30)
        button.setTitle("Clear", forState: UIControlState.Normal)

        // TODO: create a target-action to clear the canvas
        button.addTarget(self, action: "clearButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
    func clearButton(button: UIButton) {
        canvasView.paths.removeAll(keepCapacity: false)
        canvasView.setNeedsDisplay()
    }
}

