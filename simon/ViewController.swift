//
//  ViewController.swift
//  simon
//
//  Created by Andrew James Kinsey on 8/24/17.
//  Copyright © 2017 The Cabinents. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet var colorDisplays: [UIView]!
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func flashColor(number: Int)
    {
        UIView.transition(with: colorDisplays[number], duration: 0.5, options: .transitionCrossDissolve, animations: {self.colorDisplays[number].alpha = 1.0}) { (true) in
            UIView.transition(with: self.colorDisplays[number], duration: 0.5, options: .transitionCrossDissolve, animations: {self.colorDisplays[number].alpha = 0.5}, completion: nil)
        }
    }

    
    @IBAction func onStartButtonPressed(_ sender: Any)
    {
        flashColor(number: 0)
    }
    

}

