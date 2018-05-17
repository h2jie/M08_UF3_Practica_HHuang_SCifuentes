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
        self.gameView.backgroundColor = UIColor.black
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
        
        //Preserve game state when app enter in background
        let myApp:UIApplication = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterInBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: myApp)
        
        //Set up game
        self.setUpGame()

    }

    @objc private func applicationDidEnterInBackground(){
//        save current game
        if let filePath = Game.fileNamePath(){
            let encoder = PropertyListEncoder()
            let data = try? encoder.encode(self.currentGame!)
            NSKeyedArchiver.archiveRootObject(data, toFile: filePath)
        }
        if let nc: UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "navigationController") as? UINavigationController{
            self.present(nc, animated: true, completion: nil)
        }
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
        let IMAGEVIEW_BORDER = CGFloat(4)
        let IMAGEVIEW_WIDTH = (self.gameView.frame.width - CGFloat(self.currentGame!.colsCount+1)*IMAGEVIEW_BORDER)/CGFloat(self.currentGame!.colsCount)
        let IMAGEVIEW_HEIGHT = (self.gameView.frame.height - CGFloat(self.currentGame!.rowsCount+1)*IMAGEVIEW_BORDER)/CGFloat(self.currentGame!.rowsCount)
        
        
        for r in 0..<self.currentGame!.rowsCount{
            for c in 0..<self.currentGame!.colsCount{
                //create UIIMAGEVIEW
                var imageView = UIImageView(frame: CGRect(x: CGFloat(c)*(IMAGEVIEW_WIDTH+IMAGEVIEW_BORDER), y: CGFloat(r)*(IMAGEVIEW_HEIGHT+IMAGEVIEW_BORDER), width: IMAGEVIEW_WIDTH, height: IMAGEVIEW_HEIGHT))
                print(self.currentGame!.items[r*self.currentGame!.rowsCount+c])
//                imageView.image = UIImage(named: self.currentGame!.items[r*self.currentGame!.rowsCount+c])
//                imageView.alpha = 0
                imageView.backgroundColor=UIColor.white
                imageView.isUserInteractionEnabled=true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
                imageView.addGestureRecognizer(tapGesture)
                self.gameView.addSubview(imageView)
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
                        simpleAnimationShowImage(index: index)
                        break;
                    }else{
                        self.currentGame?.decreasingTurns()
                        if gesture.view==self.imageViewsArray[firstSelectedImageViewPosition!]{//reselect same imageView
                            self.imageViewsArray[index].image = nil
                            
                        }else{//select another
                            self.secondSelectedImageViewPosition=index
                            animationShowImage(index: index)
                            self.isUserInteractionEnabled=false
                            self.checkCouple()
                        }
                    }
                }
            }
        }
    }
    
    private func checkCouple(){
        if self.currentGame!.items[self.firstSelectedImageViewPosition!]==self.currentGame!.items[self.secondSelectedImageViewPosition!] {
            self.currentGame!.increasingScore()
            self.currentGame!.addMatch()
        }else{
            self.currentGame!.decreasingScore()
        }
        
        self.scoreLabel.text="Score: \(self.currentGame!.score)"
        self.remainingTurnsLabel.text="Turns: \(self.currentGame!.remainingTurns)"
        
        if self.currentGame!.remainingTurns==0 || !self.currentGame!.matches() {
            //Game over
            let label = UILabel(frame: CGRect(x: CGFloat(10), y: self.view.frame.height/2, width: self.view.frame.width-2*CGFloat(10), height: 50))
            label.text="GAME OVER"
            label.textAlignment=NSTextAlignment.center
            label.backgroundColor=UIColor.black
            label.textColor=UIColor.white
            label.alpha=0
            self.view.addSubview(label)
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                label.alpha=1
            }, completion: {finished in
                if let rv = self.storyboard?.instantiateViewController(withIdentifier: "rankingController") as? RankingViewController{
//                    self.currentGame=nil
                    rv.newScore=Score(value: self.currentGame!.score, date: Date())
                    
                    if self.navigationItem.title == "Couples Game"{
                        self.navigationController?.pushViewController(rv, animated: true)
                    } else{
                        self.present(rv, animated: true, completion: nil)
                    }
                }
            })
        }
    }
    
    private func animationShowImage(index: Int){
        self.imageViewsArray[index].alpha = 0
        let insertImageAnimation = UIViewPropertyAnimator(
            duration: 3,
            curve: UIViewAnimationCurve.linear,
            animations: {self.isUserInteractionEnabled=false
                self.imageViewsArray[index].image = UIImage(named: self.currentGame!.items[index])
                self.imageViewsArray[index].alpha = 1
        })
        insertImageAnimation.addCompletion({finished in if self.currentGame!.items[self.firstSelectedImageViewPosition!]==self.currentGame!.items[self.secondSelectedImageViewPosition!]{self.imageViewsArray[index].image = UIImage(named: self.currentGame!.items[index])
        }else{
            self.imageViewsArray[index].image = nil
            self.imageViewsArray[self.firstSelectedImageViewPosition!].image=nil
            }
            self.firstSelectedImageViewPosition=nil
            self.secondSelectedImageViewPosition=nil
            self.isUserInteractionEnabled=true
        })
        insertImageAnimation.startAnimation()
    }
    
    private func simpleAnimationShowImage(index: Int){
        self.imageViewsArray[index].alpha = 0
        let insertImageAnimation = UIViewPropertyAnimator(
            duration: 3,
            curve: UIViewAnimationCurve.linear,
            animations: {
                self.imageViewsArray[index].image = UIImage(named: self.currentGame!.items[index])
                self.imageViewsArray[index].alpha = 1
        })
        insertImageAnimation.startAnimation()
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
