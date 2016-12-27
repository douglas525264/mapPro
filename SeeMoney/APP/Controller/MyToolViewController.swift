//
//  MyToolViewController.swift
//  SeeMoney
//
//  Created by douglas on 2016/12/26.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class MyToolViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var nav = DXNavgationBar.getNav("我的道具")
    var me = UserManager.shareInstance.getMe()
    lazy var collectionView = { () -> UICollectionView in
        let grid = UICollectionViewFlowLayout()
        grid.itemSize = CGSize(width: 93, height: 93)
        grid.sectionInset = UIEdgeInsets(top: 0, left: 20.0, bottom: 20.0, right: 0)
        
        let cV = UICollectionView(frame: CGRect(x: 0, y: 64, width: ScreenWidth!, height: ScreenHeight! - 64), collectionViewLayout: grid)
        cV.backgroundColor = UIColor.clear
        cV.alwaysBounceVertical = true
        
        cV.register(UINib(nibName: "MyToolOneCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "MyToolOneCollectionViewCell")
        return cV;
    
    }()
    var toolList:Array<Any>?
    override func viewDidLoad() {
        super.viewDidLoad()
        toolList = me.toolsInfo
        createUI()
        // Do any additional setup after loading the view.
    }
    func createUI(){
        view.backgroundColor = bgColor
        self.view .addSubview(nav)
        self.nav.addBackBtn(self, backSelector: #selector(MyToolViewController.backClick(_:)))
        let rightBtn = UIButton(type: .custom)
        rightBtn.addTarget(self, action: #selector(MyToolViewController.rightBtnClick(_:)), for: .touchUpInside)
        rightBtn.setTitle("购买", for: .normal)
        //rightBtn.backgroundColor = UIColor.red
        rightBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        rightBtn.setTitleColor(UIColor.black, for: .normal)
        rightBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.nav.rightItems = [UIBarButtonItem(customView : rightBtn)]
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        view.addSubview(collectionView)
        self.view.backgroundColor = bgColor

    }
    func rightBtnClick(_ sender:UIButton?) {
        self.navigationController?.pushViewController(ToolListViewController(), animated: true)

    }
    func backClick(_ sender:UIButton?) {
        
        if self.navigationController?.popViewController(animated: true) != nil {
            
        }
    }
    //MARK - UICollection
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if toolList != nil {
        
            return (toolList?.count)!
        }
        return 0;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : MyToolOneCollectionViewCell   = collectionView.dequeueReusableCell(withReuseIdentifier: "MyToolOneCollectionViewCell", for: indexPath) as! MyToolOneCollectionViewCell
        let toolInfo = toolList?[indexPath.row] as! Dictionary<String,AnyObject>;
        let model = ToolModel()
        model.config(Json : toolInfo)
        
        cell.toolAvatarImageView.setImageWith(URL(string: model.iconUrl!)!, placeholderImage: UIImage(named: "redbg2"))
        cell.desLable.text = model.des
        cell.CountLable.text = "个数:\(model.count)"

        return cell
        
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
