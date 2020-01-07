//
//  ViewController.swift
//  naviapp
//
//  Created by MacStudent on 2020-01-07.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet weak var scrubber: UISlider!
  @IBOutlet weak var volumerslider: UISlider!
    var player = AVAudioPlayer()
    let path = Bundle.main.path(forResource: "bach", ofType: "mp3")
 var timer = Timer()
   
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
        player =  try AVAudioPlayer(contentsOf : URL(fileURLWithPath: path!))
            scrubber.maximumValue = Float(player.duration)
        } catch {
            print(error)
        }
    }

    @IBAction func stopsong(_ sender: UIButton) {
        player.stop()
        timer.invalidate()
        player.currentTime = 0
      
    }
    
    @IBAction func pausesong(_ sender: UIBarButtonItem) {
        player.pause()
              timer.invalidate()
    }
    
    @IBAction func playsong(_ sender: UIBarButtonItem) {
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateScrubber), userInfo: nil, repeats: true)
    }
  @objc  func updateScrubber(){
        scrubber.value = Float(player.currentTime)
    }
    
    @IBAction func volumerChanged(_ sender: UISlider) {
        player.volume = volumerslider.value
    }
    
    @IBAction func scrubberchange(_ sender: UISlider) {
        player.currentTime = TimeInterval(scrubber.value)
        player.play()
    }
}

