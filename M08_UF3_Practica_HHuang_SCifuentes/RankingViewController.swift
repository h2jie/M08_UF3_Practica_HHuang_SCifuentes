//
//  RankingViewController.swift
//  M08_UF3_Practica_HHuang_SCifuentes
//
//  Created by Hangjie Huang on 2018/5/8.
//  Copyright © 2018年 Hangjie Huang. All rights reserved.
//

import UIKit

class RankingViewController: UIViewController {

    var highScore: HighScores?
    var labelsArray = [UILabel]()

    var newScore: Score?


    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.navigationItem.title = "Ranking"

        if !(newScore == nil) {
            //Show left UIBarBottonItem
            self.navigationItem.leftBarButtonItem=UIBarButtonItem(title: "Continue", style: UIKit.UIBarButtonItemStyle.plain, target: self, action: #selector(continueBarButtonPressed(sender:)))
        }
        
        self.setUpRanking()
        self.layoutScoreLabels()
        
    }

    @objc func continueBarButtonPressed(sender: UIBarButtonItem){
        if let mc = self.storyboard?.instantiateViewController(withIdentifier: "menuController")as? MenuUIViewController {
//            mc.previousGame=nil
            self.navigationController?.pushViewController(mc, animated: true)
        }
        self.setUpRanking()
        self.layoutScoreLabels()
    }
    
    private func layoutScoreLabels(){
        //Clear UI
        if !self.labelsArray.isEmpty{
            for label in labelsArray{
                label.removeFromSuperview()
            }
            labelsArray=[UILabel]()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat="dd-MM-yyyy HH:mm"
        
        //Setup UI with labels
        let HORIZONTAL_SPACE = CGFloat(20.0)
        let VERTICAL_SPACE=CGFloat(100.0)
        let LABEL_WIDTH = self.view.frame.width-2*HORIZONTAL_SPACE
        let LABEL_HEIGHT = (self.view.frame.height-50-11*VERTICAL_SPACE)/10
        
        for index in 0..<self.highScore!.theScores.count{
            let label = UILabel(frame: CGRect(x: HORIZONTAL_SPACE, y: CGFloat(index+1)*VERTICAL_SPACE, width: LABEL_WIDTH, height: LABEL_HEIGHT))
            label.backgroundColor=UIColor.white
            label.alpha=0.5
            label.textAlignment = NSTextAlignment.center
            label.text="\(self.highScore!.theScores[index].value) .... \(dateFormatter.string(from: self.highScore!.theScores[index].date))"
            
            
            if !(newScore==nil){
                label.textColor=UIColor.blue
                newScore=nil
            }
            
            self.labelsArray.append(label)
            self.view.addSubview(label)
        }
        
        
    }
    
    
    private func setUpRanking(){
        self.highScore=HighScores()
        //unarchive datafrom NSUserDefaults
        if let data = UserDefaults.standard.object(forKey: "HIGHSCORES_KEY") as? Data{
            let decoder = PropertyListDecoder()
            self.highScore = try? decoder.decode(HighScores.self, from: data)
        }
        
        if let score=newScore{
            self.highScore?.addScore(newScore: score)
            
        }
        if !self.highScore!.theScores.isEmpty{
            self.saveRanking()
        }
    }

    
    private func saveRanking(){
        let encoder = PropertyListEncoder()
        let data = try? encoder.encode(self.highScore!)
        UserDefaults.standard.set(data, forKey: "HIGHSCORES_KEY")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
