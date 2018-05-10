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
    
    //User  Input
    var isUserInteractionEnabled=false
    var firstSelectedImageViewPosition:Int?
    var secondSelectedImageViewPosition:Int?
    
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
        
        self.scoreLabel.text="Score: \(self.currentGame!.score)"
        self.remainingTurnsLabel.text="Turns: \(self.currentGame!.remainingTurns)"
        
        self.isUserInteractionEnabled=true
    }

    private func createAndLayoutImages(){
        let IMAGEVIEW_WIDTH = self.gameView.frame.width/CGFloat(self.currentGame!.colsCount)
        let IMAGEVIEW_HEIGHT = self.gameView.frame.height/CGFloat(self.currentGame!.rowsCount)
        
        for r in 0..<self.currentGame!.rowsCount{
            for c in 0..<self.currentGame!.colsCount{
                //create UIIMAGEVIEW
                var imageView = UIImageView(frame: CGRect(x: CGFloat(c)*IMAGEVIEW_WIDTH, y: CGFloat(r)*IMAGEVIEW_HEIGHT, width: IMAGEVIEW_WIDTH, height: IMAGEVIEW_HEIGHT))
                print(self.currentGame!.items[r*self.currentGame!.rowsCount+c])
                imageView.image = UIImage(named: self.currentGame!.items[r*self.currentGame!.rowsCount+c])

                imageView.layer.borderWidth=2
                imageView.layer.borderColor=UIColor.black.cgColor
//                imageView.image=nil para mostrar y esconder la imagen
                imageView.isUserInteractionEnabled=true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
                imageView.addGestureRecognizer(tapGesture)
                self.view.addSubview(imageView)
                self.imageViewsArray.append(imageView)
            }
        }

    }
    
    @objc func tap(gesture:UITapGestureRecognizer){
        if self.currentGame!.remainingTurns>0 && self.isUserInteractionEnabled{
            for index in 0..<self.imageViewsArray.count{
                if self.imageViewsArray[index] == gesture.view{
                    if self.firstSelectedImageViewPosition==nil{
                        firstSelectedImageViewPosition=index
                        //animación en alfa para mostrar la imagen seleccionada
                        //sobre self.imageViewsArray[index]
                        break;
                    }else{
                        self.currentGame?.decreasingTurns()
                        if gesture.view==self.imageViewsArray[firstSelectedImageViewPosition!]{//reselect same imageView
                            self.firstSelectedImageViewPosition=nil
                            //animación en alfa para esconder la imagen seleccionada
                            //sobre self.imageViewsArray[index]
                        }else{//select another
                            self.secondSelectedImageViewPosition=index
                            //animación en alfa para mostrar la imagen seleccionada
                            //sobre self.imageViewsArray[index]
                            self.isUserInteractionEnabled=false
                            self.checkCouple()
                        }
                    }
                }
            }
        }
    }
    
    private func checkCouple(){
        self.firstSelectedImageViewPosition=nil
        self.secondSelectedImageViewPosition=nil
        
        if self.currentGame!.items[self.firstSelectedImageViewPosition]==self.currentGame!.items[self.secondSelectedImageViewPosition] {
            self.currentGame!.increasingScore()
        }else{
            self.currentGame!.decreasingScore()
        }
        
        self.scoreLabel.text="Score: \(self.currentGame!.score)"
        self.remainingTurnsLabel.text="Turns: \(self.currentGame!.remainingTurns)"
        
        if self.currentGame!.remainingTurns==0{
            //Game over
        }else{
            self.isUserInteractionEnabled=true
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
