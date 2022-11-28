//
//  ViewController.swift
//  iTime
//
//  Created by user on 13.11.2022.
//

import UIKit

class StopWatch: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
           
    
    @IBOutlet weak var timerOutput: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var startPauseButton: UIButton!
            
    @IBOutlet weak var lapResetButton: UIButton!
    
    var stopWatch = Timer()
    var playTimer: Bool = true
    var lapTimer: Bool = true
    var counter: Double = 0.0
    var lapList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
           }
   
    @IBAction func startPauseTimer(_ sender: UIButton) {
        if playTimer {
        stopWatch = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            changeStartPauseButton(by: sender, "pause.fill", text: "Pause")
            lapResetButton.isEnabled = true
        } else {
        stopWatch.invalidate()
        changeStartPauseButton (by: sender, "play.fill", text: "Play")
        lapTimer = false
            changeLapResetButton(by: lapResetButton, "clear.fill", text: "Reset")                }
    }
    @IBAction func lapResetTimer(_ sender: UIButton)        {
            if lapTimer {
                changeLapResetButton(by: sender, "plus.rectangle.fill", text: "Lap")
                lapList.append(timerOutput.text!)
                table.reloadData()
            } else {
                guard playTimer else { return }
                lapList.removeAll()
                table.reloadData()
                changeLapResetButton(by: sender, "plus.rectangle.fill", text: "Lap")
                sender.isEnabled = false
                timerOutput.text = "00:00"
                counter = 0.0
            }
    }
    
    @objc func updateTimer(){
        counter += 0.035
        var minutes = "\((Int)(counter / 60))"
        if (Int)(counter / 60) < 10 {
            minutes = "0\((Int) (counter / 60))"
        }
        var seconds: String = String(format: "%.2f", counter.truncatingRemainder(dividingBy: 60))
        if counter.truncatingRemainder(dividingBy: 60) < 10 {seconds = "0" + seconds
    }
    timerOutput.text = minutes + ":" + seconds
        }
    
        func changeStartPauseButton(by button: UIButton, _ image: String, text title: String) {
              playTimer = !playTimer
              button.setTitle(title, for: UIControl.State())
              button.setImage(UIImage(systemName: image), for: UIControl.State())
          }
          
          // Modify view for button lap and reset
          func changeLapResetButton(by button: UIButton, _ image: String, text title: String) {
              button.setTitle(title, for: UIControl.State())
              button.setImage(UIImage(systemName: image), for: UIControl.State())
          }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lapList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableRow", for: indexPath) as! TableCell
        cell.tableLabel.text = lapList[indexPath.row]
        return cell
   }
}

