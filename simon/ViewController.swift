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
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet var colorDisplays: [UIView]!
    @IBOutlet weak var colorsFrame: UIView!
    var timer = Timer()
    var index = 0
    var pattern = [Int]()
    var playerTurn = false
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        messageLabel.text = ""
        

    }
    func addToPattern()
    {
        pattern.append(Int(arc4random_uniform(4)))
    }
    func flashColor(number: Int)
    {
        UIView.transition(with: colorDisplays[number], duration: 0.5, options: .transitionCrossDissolve, animations: {self.colorDisplays[number].alpha = 1.0}) { (true) in
            UIView.transition(with: self.colorDisplays[number], duration: 0.5, options: .transitionCrossDissolve, animations: {self.colorDisplays[number].alpha = 0.5}, completion: nil)
        }
    }
    
    func restartGame()
    {
        startButton.alpha = 1.0
        pattern.removeAll()
        index = 0
        playerTurn = false
    }

    func displayPattern()
    {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: (#selector(ViewController.nextColor)), userInfo: nil, repeats: true)
    }
    
    @objc func nextColor()
    {
        if index < pattern.count
        {
            flashColor(number: pattern[index])
            index += 1
        }
        else
        {
            timer.invalidate()
            index = 0
            playerTurn = true
            messageLabel.text = "Player Turn"
        }
    }
    
    
    @IBAction func onStartButtonPressed(_ sender: Any)
    {
        addToPattern()
        displayPattern()
        startButton.alpha = 0.0
        messageLabel.text = ""
    }
    
    @IBAction func onColorTapped(_ sender: UITapGestureRecognizer)
    {
        if playerTurn == true
        {
        for number in 0..<colorDisplays.count
        {
            if colorDisplays[number].frame.contains(sender.location(in: colorsFrame))
            {
               if pattern[index] == number
                    {
                        flashColor(number: number)
                        index += 1
                        if index == pattern.count
                        {
                            index = 0
                            playerTurn = false
                            messageLabel.text = ""
                            addToPattern()
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5)
                            {
                                self.displayPattern()
                            }
                        }
                    }
                else
                    {
                        messageLabel.text = "You're Bad"
                        restartGame()
                        
                    }
                
            }
        }
        }
    
    }
    
}

