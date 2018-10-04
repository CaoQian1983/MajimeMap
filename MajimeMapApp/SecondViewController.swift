//
//  SecondViewController.swift
//  MajimeMapApp
//
//  Created by CaoQian on 2018/09/22.
//  Copyright © 2018 CaoQian. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     let margin:CGFloat = 3.0
    
    //問題ある？？cellをタップしてuserdefaultsに保存するコード
  let userDefaults = UserDefaults.standard
    
    var photos:[String]!
    
    //問題ある？？cellをタップしてuserdefaultsに保存するコード
 var cell = UIImage()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        //let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        cell.image.image = UIImage(named:photos[indexPath.row])

        return cell
        
    }
    //セルのサイズを指定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width //画面の横幅
        let cellNum: CGFloat = 2//横に並べるセルの数
        let cellSize = (width - margin * (cellNum + 2)) / cellNum //一個あたりのサイズk
        return CGSize(width: cellSize, height: cellSize)
    }
    //セル同士の縦の間隔
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    //セル同士の横の間隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    //問題ある？？cellをタップしてuserdefaultsに保存するコード
    func readData() -> String {

        let str: String = userDefaults.object(forKey: "DataStore") as! String

        return str
    }

    @IBOutlet weak var collectionView: UICollectionView!

    
    override func viewDidLoad() {
    super.viewDidLoad()
        
    userDefaults.register(defaults: ["DataStore": "default"])
    collectionView.delegate = self
    collectionView.dataSource = self
    //カスタムセルでxibふファイルを使用
    self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        

        
       
        
        
        photos = ["1x.jpg","2x.jpg","3x.png","4x.jpg","5x.png","6x.png","7x.jpg","8x"]
 }
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //問題ある？？cellをタップしてuserdefaultsに保存するコード
        userDefaults.set(indexPath.row, forKey: "DataStore3")
        
        //問題ある？？cellをタップしてuserdefaultsに保存するコード
        let str3 = userDefaults.object(forKey: "DataStore3") as! Int
        NSLog("userdefault: %@", String(str3))
        
        //ThirdViewController へ遷移するために Segue を呼び出す
        performSegue(withIdentifier: "toThirdViewController",sender: nil)
    }
    
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "toThirdViewController") {
            let subVC: ThirdViewController = (segue.destination as? ThirdViewController)!
        }
    }
}
