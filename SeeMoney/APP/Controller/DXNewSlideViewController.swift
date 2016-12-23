//
//  DXNewSlideViewController.swift
//  SeeMoney
//
//  Created by douglas on 2016/12/20.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class DXNewSlideViewController: UIViewController {
    lazy var slideView : UIView  = UIView(frame: CGRect(x: 0, y: -ScreenHeight!, width: ScreenWidth!, height: ScreenHeight!))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        self.view.addSubview(slideView)
        // Do any additional setup after loading the view.
    }
    func show(inView view:UIView) {
        
        view.addSubview(self.view)
        fixPosition(true) {
            
        }
    }
    func fixPosition(_ isShow:Bool,finishedBlock:@escaping ()->Void){
        if isShow {
            UIView.animate(withDuration: 0.3, animations: {
                self.slideView.frame = CGRect(x: 0, y: 0, width: self.slideView.frame.size.width, height: self.slideView.frame.size.height)
            }, completion: { (isOK : Bool) in
                finishedBlock()
            })
            
        } else {
            
            UIView.animate(withDuration: 0.3, animations: {
                self.slideView.frame = CGRect(x: 0, y:-self.slideView.frame.size.height, width: self.slideView.frame.size.width, height: self.slideView.frame.size.height)
            }, completion: { (isOK : Bool) in
                finishedBlock()
            })
        }
    }
    func dismiss(){
        fixPosition(false) {
            self.view.removeFromSuperview()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
