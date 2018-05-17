//
//  MenuUIViewController.swift
//  M08_UF3_Practica_HHuang_SCifuentes
//
//  Created by Hangjie Huang on 2018/5/3.
//  Copyright © 2018年 Hangjie Huang. All rights reserved.
//

import UIKit

class MenuUIViewController: UIViewController {

    @IBOutlet weak var continueGameButton: UIButton!
    
    var previousGame:Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let filePath = Game.fileNamePath(){
            
            if let data = NSKeyedUnarchiver.unarchiveObject(withFile:filePath) as? Data{
                let decoder = PropertyListDecoder()
                self.previousGame = try? decoder.decode(Game.self, from: data)
                
                let fileManager = FileManager()

                do{
                    try fileManager.removeItem(atPath: filePath)
                }catch let error as NSError {
                    print("Ooops! Something went wrong: \(error)")
                }
                
            }
        }
        
        continueGameButton.addTarget(self, action: #selector(continueGamePressed(_:)), for: UIControlEvents.allTouchEvents)
        
        if previousGame==nil {
            continueGameButton.isHidden=true
        }else{
            continueGameButton.isHidden = false
        }
    }
    
    @objc func continueGamePressed(_ sender: UIButton) {
        if let gc = self.storyboard?.instantiateViewController(withIdentifier: "gameController")as? GameViewController{
            
            if  let game = previousGame{
                gc.currentGame = game
                self.previousGame = nil
               // self.present(gc, animated: true, completion: nil)
                self.navigationController?.pushViewController(gc, animated: true)
            }
            
            /*else {
                self.navigationController?.pushViewController(gc, animated: true)
            } */
            
            
            
            
            
        }
    }
    
    @IBAction func startGamePressed(_ sender: UIButton) {
        if let gc = self.storyboard?.instantiateViewController(withIdentifier: "gameController")as? GameViewController{
            
            self.navigationController?.pushViewController(gc, animated: true)
            

            
        }
    }
    
    @IBAction func rankingPressed(_ sender: UIButton) {
        if let rc = self.storyboard?.instantiateViewController(withIdentifier: "rankingController") as? RankingViewController{
            self.navigationController?.pushViewController(rc, animated: true)
        }
    }
    
    @IBAction func aboutPressed(_ sender: UIButton) {
        if let ac = self.storyboard?.instantiateViewController(withIdentifier: "aboutController") as? AboutViewController{
            self.navigationController?.pushViewController(ac, animated: true)
        }
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
