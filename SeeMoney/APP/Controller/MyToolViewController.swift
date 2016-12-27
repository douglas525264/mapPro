//
//  MyToolViewController.swift
//  SeeMoney
//
//  Created by douglas on 2016/12/26.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class MyToolViewController: UIViewController {
    var nav = DXNavgationBar.getNav("我的道具")
    lazy var collectionView = { () -> UICollectionView in
        let grid = UICollectionViewFlowLayout()
        grid.itemSize = CGSize(width: 93, height: 93)
        grid.sectionInset = UIEdgeInsets(top: 0, left: 20.0, bottom: 20.0, right: 0)
        
        let cV = UICollectionView(frame: CGRect(x: 0, y: 64, width: ScreenWidth!, height: ScreenHeight! - 64), collectionViewLayout: grid)
        return cV;
    
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        // Do any additional setup after loading the view.
    }
    func createUI(){
        view.backgroundColor = bgColor
        self.view .addSubview(nav)
        self.nav.addBackBtn(self, backSelector: #selector(AboutViewController.backClick(_:)))
        let me = UserManager.shareInstance.getMe()
        let tool = me.toolsInfo
        if tool != nil {
           
        }

    }
    func backClick(_ sender:UIButton?) {
        
        if self.navigationController?.popViewController(animated: true) != nil {
            
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
