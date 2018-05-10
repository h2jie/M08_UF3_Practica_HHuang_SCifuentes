//
//  LoadUIViewController.swift
//  M08_UF3_Practica_HHuang_SCifuentes
//
//  Created by Hangjie Huang on 2018/5/3.
//  Copyright © 2018年 Hangjie Huang. All rights reserved.
//

import UIKit

class LoadUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadRedources()
        
        if let nc :UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "navigationController") as? UINavigationController{
            self.present(nc, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadRedources(){
        Thread.sleep(forTimeInterval: 3)
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
