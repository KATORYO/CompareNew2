//
//  ViewController1-2.swift
//  Compare
//
//  Created by 加藤諒 on 2017/09/17.
//  Copyright © 2017年 mirai. All rights reserved.
//

import UIKit
import FontAwesome_swift

class ViewController1_2: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
  
  
    var placeListFood:[String] = []
    var placeListConvenience:[String] = []
    var placeListShopAndGallery:[String] = []
    var placeListLivingOfCosts:[String] = []
    var placeListBigShopping:[String] = []
    var placeListElectricAppliances:[String] = []
    var placeListDwelling:[String] = []
    var placeListConstruction:[String] = []
  
    var dicB:NSDictionary = [:]
  
    //var dicC:NSDictionary = [:]
  
    var array:NSArray = []
  

    //var dicB:NSDictionary = data as! NSDictionary
  
    //選択されたエリア名を保存するプロパティ
    //ここで２番目の表示する画面を判断する
    var scSelectedIndex = -1
  
  
  
    //この画面から１−３への番号
    var scSelectedIndex1 = -1
  
    //配列に入れる！！次の番号遷移のため
    var arrayNext:[String] = ["scSelectedIndex"]
  
  
      var SelectedIndex3 = -1
  
      var placeList1:[String] = []
  
      var Image:UIImage = UIImage()
  
      @IBOutlet weak var myCollectionView1_2: UICollectionView!
  
  
        //お気に入りボタンフォントオーサム
      @IBOutlet weak var FavoriteBtn: UIButton!
        //お気に入りボタンaction
      @IBAction func FavoriteBtn(_ sender: UIButton) {
      var katoryo:String = "katoryo"
    
      let alert = UIAlertController(title: "お気に入り追加", message: "お気に入り画面に追加されます", preferredStyle: .alert)
    
      //handlerはokボタンが押されたときに行いたい処理を指定する場所(オッケーが押されたときに発動する)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    
      alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
    
      //アラート表示
      present(alert,animated: true,completion: nil)
    
    
      //関数に関数を入れる方法！！ask
      func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      //移動先の画面に渡したい情報をセットできる
      //移動先画面のオブジェクトを取得！
      let abc:ThirdViewController3_1 = segue.destination as! ThirdViewController3_1
      
      //abc.katoryoDesu = katoryo
    }

  }//favボタンの閉じたぐ
  
  
      //ページの読み込み時
      override func viewDidLoad() {
        super.viewDidLoad()
      
      
      //fontawsome適用！
      FavoriteBtn.titleLabel?.font = UIFont.fontAwesome(ofSize: 35)
      FavoriteBtn.setTitle(String.fontAwesomeIcon(name: .star), for: .normal)

      print(scSelectedIndex)
      
      myCollectionView1_2.delegate = self
      myCollectionView1_2.dataSource = self
      
      
    //プロパティリスト読み込み
      let filePathFastfood = Bundle.main.path(forResource: "Fastfood", ofType: "plist")
      
      let filePathConvinience = Bundle.main.path(forResource:"Convenience", ofType:"plist")
      
      let filePathShopAndGallery = Bundle.main.path(forResource: "ShopAndGallery", ofType: "plist")
      
      let filePathLivingOfCosts = Bundle.main.path(forResource: "LivingOfCosts", ofType: "plist")
      
      let filePathBigShopping = Bundle.main.path(forResource: "BigShopping", ofType: "plist")
      
      let filePathErectricAppliances = Bundle.main.path(forResource: "ElectricAppliances", ofType: "plist")
      
      let filePathConstruction = Bundle.main.path(forResource: "Construction", ofType: "plist")
      let filePathDwelling = Bundle.main.path(forResource: "Dwelling", ofType: "plist")
      
    //ファイルの内容を読み込んでarray型に格納
      switch scSelectedIndex{
      case 0:
        array = NSArray(contentsOfFile: (filePathFastfood)!)!
        print("０番です")
      case 1:
        array = NSArray(contentsOfFile:filePathConvinience!)!
        print("1番です")
      case 2:
        array = NSArray(contentsOfFile:filePathShopAndGallery!)!
      case 3:
        array = NSArray(contentsOfFile:filePathLivingOfCosts!)!
      case 4:
        array = NSArray(contentsOfFile:filePathBigShopping!)!
      case 5:
        array = NSArray(contentsOfFile:filePathErectricAppliances!)!
        
      case 6:
        array = NSArray(contentsOfFile: filePathDwelling!)!
      case 7:
        array = NSArray(contentsOfFile: filePathConstruction!)!
      default: break
  }
      
      for data in array{
        let dic = data as! NSDictionary
        
        //apendが何か？ Key配列の追加！
        placeListFood.append(dic["description"] as! String)
        
        placeListConvenience.append(dic["description"] as! String)
        placeListShopAndGallery.append(dic["description"] as! String)
        
        placeListLivingOfCosts.append(dic["description"] as! String)
        
        placeListBigShopping.append(dic["description"] as! String)
        
        placeListElectricAppliances.append(dic["description"] as! String)
        
        
        placeListDwelling.append(dic["description"] as! String)
        placeListConstruction.append(dic["description"] as! String)
        
      }
  }
  
  
  
  /*
   表示するセルの数！
   */
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return array.count
    
  }
  
  /*
   Cellに値を設定する
   */
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell:CustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1_2", for: indexPath) as! CustomCell
    
    //取り出す時は型の宣言しなければならない！ as!NS~~
    dicB = array[indexPath.row] as! NSDictionary
    //dicC = array[indexPath.row] as!NSDictionary
    
    //print(dicC["description"] as! String)
    print(dicB["image"] as! String)
    
    
    cell.myLabel1_2.text? = dicB["description"] as! String
    cell.myImage1_2.image = UIImage(named: dicB["image"] as! String)
    
    return cell
  }
  
  // セクションの数（今回は1つ）
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  
  
    /*
     Cellが押された時
    */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
      
      //ここが３番目の画面を左右する！
      scSelectedIndex1 = indexPath.row
      SelectedIndex3 = indexPath.row
      //セルの０番目が押されて、かつ２番目の画面のどの場所が押されたか？
      
            if scSelectedIndex1 == 0{
              var SelectedIndex3:[Int] = [scSelectedIndex1]
              print(SelectedIndex3)
      }else if scSelectedIndex1 == 1{
              var SelectedIndex3:[Int] = [scSelectedIndex1]
        print("かとんりょ\(SelectedIndex3)")
        
      }else if scSelectedIndex1 == 2{
        var SelectedIndex3:Int = scSelectedIndex1
        
      }else if scSelectedIndex1 == 3{
        var SelectedIndex3:Int = scSelectedIndex1
        
      }else if scSelectedIndex1 == 4{
        var SelectedIndex3:Int = scSelectedIndex1
        
      }else if scSelectedIndex1 == 5{
        var SelectedIndex3:Int = scSelectedIndex1
        
      }else if scSelectedIndex1 == 6{
        var SelectedIndex3:Int = scSelectedIndex1
        
      }else if scSelectedIndex1 == 7{
        var SelectedIndex3:Int = scSelectedIndex1
      }
      
      
      
      
      
      
      if scSelectedIndex == 0 && scSelectedIndex1 == 0{
        let SelectedIndex3 = scSelectedIndex1
      }else if scSelectedIndex == 0 && scSelectedIndex1 == 1{
        var SelectedIndex3:Int = scSelectedIndex1
        print("かとんりょ\(SelectedIndex3)")
      }else if scSelectedIndex == 0 && scSelectedIndex1 == 2{
        var SelectedIndex3:Int = scSelectedIndex1
      }else if scSelectedIndex == 0 && scSelectedIndex1 == 3{
        var SelectedIndex3:Int = scSelectedIndex1
      }else if scSelectedIndex == 0 && scSelectedIndex1 == 4{
        var SelectedIndex3:Int = scSelectedIndex1
      }else if scSelectedIndex == 0 && scSelectedIndex1 == 5{
        var SelectedIndex3:Int = scSelectedIndex1
      }else if scSelectedIndex == 0 && scSelectedIndex1 == 6{
        var SelectedIndex3:Int = scSelectedIndex1
      }else if scSelectedIndex == 0 && scSelectedIndex1 == 7{
        var SelectedIndex3:Int = scSelectedIndex1
      }
      
      
   

    //画面遷移
    performSegue(withIdentifier: "next2", sender: nil)
  }

  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    
    //移動先の画面に渡したい情報をセットできる
    //移動先画面のオブジェクトを取得！
    let abc: ViewController1_3 = segue.destination as! ViewController1_3
    
    //abc.scSelectedIndex4 = SelectedIndex3
    
  }
  
    //一つ前に戻るためのプログラム
    @IBAction func back1_2 (_ segue:UIStoryboardSegue){}
  

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
