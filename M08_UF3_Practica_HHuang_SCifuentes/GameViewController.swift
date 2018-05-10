//
//  GameViewController.swift
//  M08_UF3_Practica_HHuang_SCifuentes
//
//  Created by Hangjie Huang on 2018/5/3.
//  Copyright © 2018年 Hangjie Huang. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    var currentGame:Game?
    
    //GUI properties
    private let gameView = UIView()
    private let scoreLabel = UILabel()
    private let remainingTurnsLabel = UILabel()
    private var imageViewsArray=[UIImageView]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title="Couples Game"
        
        
        //Define the play area
        let GAME_VIEW_BORDER = CGFloat(10.0)
        let gameViewSize = self.view.frame.width-2*GAME_VIEW_BORDER
        self.gameView.frame = CGRect(x: 0, y: 0, width: gameViewSize, height: gameViewSize)
        self.gameView.center = self.view.center
        self.gameView.backgroundColor = UIColor.white
        self.view.addSubview(self.gameView)
        
        //Define labels
        self.remainingTurnsLabel.frame = CGRect(x: GAME_VIEW_BORDER, y: self.gameView.frame.origin.y-40, width: self.view.frame.width-GAME_VIEW_BORDER, height: 40)
        self.remainingTurnsLabel.text="Turns: "
        self.remainingTurnsLabel.textColor = UIColor.white
        self.view.addSubview(self.remainingTurnsLabel)
        
        self.scoreLabel.frame = CGRect(x: GAME_VIEW_BORDER, y: self.remainingTurnsLabel.frame.origin.y-40, width: self.view.frame.width-GAME_VIEW_BORDER, height: 40)
        self.scoreLabel.text="Score: "
        self.scoreLabel.textColor=UIColor.white
        self.view.addSubview(self.scoreLabel)
        
        
        //Set up game
        setUpGame()
        
        
        
    }
    
    private func setUpGame(){
        if currentGame==nil{
            self.currentGame = Game(rows: 6, cols: 6)
        }
        
        createAndLayoutImages()
    }

    private func createAndLayoutImages(){
        let IMAGEVIEW_WIDTH = self.gameView.frame.width/CGFloat(self.currentGame!.colsCount)
        let IMAGEVIEW_HEIGHT = self.gameView.frame.height/CGFloat(self.currentGame!.rowsCount)
        
        for r in 0..<self.currentGame!.rowsCount{
            for c in 0..<self.currentGame!.colsCount{
                //create UIIMAGEVIEW
                var imageView = UIImageView(frame: CGRect(x: CGFloat(c)*IMAGEVIEW_WIDTH, y: CGFloat(r)*IMAGEVIEW_HEIGHT, width: IMAGEVIEW_WIDTH, height: IMAGEVIEW_HEIGHT))
                
                switch(self.currentGame!.items[r*self.currentGame!.rowsCount+c]){
                    
//                case Game.couples[0]:
//                    break
                default:
                    break
                }
            }
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
