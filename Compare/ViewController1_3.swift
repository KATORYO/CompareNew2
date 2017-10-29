//
//  ViewController1_3.swift
//  Compare
//
//  Created by 加藤諒 on 2017/09/17.
//  Copyright © 2017年 mirai. All rights reserved.
//

import UIKit
import CoreData
import FontAwesome_swift
import Foundation

class ViewController1_3: UIViewController,UITableViewDelegate,UITableViewDataSource {

  @IBAction func myFavorite(_ sender: UIBarButtonItem) {
  }
  
  var dicB:NSDictionary = [:]
  
  var placeList:[String] = []
  
  var array:NSArray = []
  
  @IBOutlet weak var titleLabel: UILabel!
  
  
  
  //ここにPlistから受け取った情報を格納
  var amountPhpArray:[Int] = []
  
  
  //前の画面からゲット
  //（配列）
  var myImageList:String = ""
  var myArrayList:String = ""
  
  var myArrayListFrom3_1:String = ""

  //firstViewからの値
  var scSelectedIndex:Int = -1
  
  
  var scNumFin:Int = -1
  
  
  
  var amountPHP:Double = 0
  var ratePhp:Int = 0
  
  
  let userDefault = UserDefaults.standard
  
  var arrayDesu:[String] = []
  
  
  //coredateここから
  let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
  
  
  var contentFavorite:[String] = []
  var contentFavoriteImage:[String] = []
  var contentFavoriteInt:[String] = []
  
  var fetchedArray: [NSManagedObject] = []
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
    do {
      fetchedArray = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }


  
  
  @IBOutlet weak var myNavigation1_3: UINavigationBar!
  
  

  @IBOutlet weak var myTableView1_3: UITableView!
  
  // ボタンを用意
  private var addBtn: UIBarButtonItem!
  let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 30)] as [String: Any]
  

  
    override func viewDidLoad() {
        super.viewDidLoad()
      
   
     
      
//      もしmyArrayListがからの場合、myArrayList3_1が発動！
//      タイトル設定（重要）
      titleLabel.adjustsFontSizeToFitWidth = true
      titleLabel.minimumScaleFactor = 0.7
      
      if myArrayList == ""{
        titleLabel.text? = "\(myArrayListFrom3_1)を比較！"
      }else if myArrayListFrom3_1 == ""{
       titleLabel.text? = "\(myArrayList)を比較！"
      }
      
      
    
      if UserDefaults.standard.object(forKey: "integerKeyName") == nil  {
        amountPHP = 0.45
      }else{
      amountPHP = UserDefaults.standard.object(forKey: "integerKeyName") as! Double
      }
      //userDefaultに格納されたものを表示
      print("中身確認\(amountPHP)")
      
      

      // 罫線を青色に設定.
      myTableView1_3.separatorColor = UIColor.lightGray
      
      //3-1から送られている番号
      //0~30は表示しない
      if 0...30 ~= scNumFin{
        print("表示しない")
      }else{
      //addBtnの作成　plainが文字だけのもの、titleは""
      addBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: "onClick")
      
      //fontawsome適用
        self.addBtn.setTitleTextAttributes(attributes, for: .normal)
      self.addBtn.title = String.fontAwesomeIcon(name: .star)
      //viewに表示！
      self.navigationItem.rightBarButtonItem = addBtn
      }
      // Keyを指定して読み込み
//      UserDefaults.standard.integer(forKey: "DataStore")
//      
//      print(value(forKey: "DataStore"))
//
//      
//      print(scSelectedIndex)
  
      //tableViewを使えるようにする！
      self.myTableView1_3.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    
      
      
      //読み込み処理（READ）
      func read(){
        
        //AppDelegate用意
        let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //エンティティを操作するためのオブジェクトを使用
        let viewContext = appD.persistentContainer.viewContext
        
        //どのエンティティからデータを取得してくるかc設定
        let query:NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do{
          //保存されてるデータをすべて取得
          let fetchResults = try viewContext.fetch(query)
          
          //一件ずつ表示
          for result:AnyObject in fetchResults{
            let favorite:String? = result.value(forKey:"favorite") as? String
            let favoriteImage:String? = result.value(forKey:"favoriteImage") as? String
            let favoriteNo:String = result.value(forKey: "favoriteNo") as! String
            
            
            if favorite == nil {
              print("0です")
            }else{
              contentFavorite.append(favorite!)
              contentFavoriteImage.append(favoriteImage!)
              contentFavoriteInt.append(favoriteNo)
            }
            
          }
        }catch{
      }
    }
      
      
      
      //プロパティリストの読み込み
      let filePathMc = Bundle.main.path(forResource: "McPrice", ofType: "plist")
      
      let filePathStb = Bundle.main.path(forResource: "PriceStarbucks", ofType: "plist")
      
      let filePathConvenience = Bundle.main.path(forResource: "PriceConvenience", ofType: "plist")
      
      let filePathYoshinoya = Bundle.main.path(forResource: "PriceYoshinoya", ofType: "plist")
      
      let filePathMarukame = Bundle.main.path(forResource: "PriceMarukame", ofType: "plist")
      
      let filePathKfc = Bundle.main.path(forResource: "PriceKfc", ofType: "plist")
      
      let filePathKHomeErectric = Bundle.main.path(forResource: "PriceHomeElectricAppliance", ofType: "plist")
      
      let filePathSuperFoods = Bundle.main.path(forResource: "PriceSupermarketFoods", ofType: "plist")
      
      let filePathCarBike = Bundle.main.path(forResource: "PriceCarBike", ofType: "plist")
      
      let filePathBedClothes = Bundle.main.path(forResource: "PriceFurniture", ofType: "plist")
      
      let filePathStationery = Bundle.main.path(forResource: "PriceStationery", ofType: "plist")
      
      let filePathSuperDrink = Bundle.main.path(forResource: "PriceSuperMarketDrink", ofType: "plist")
      
      let filePathFashion = Bundle.main.path(forResource: "PriceFashion", ofType: "plist")
      
       let filePathDvd = Bundle.main.path(forResource: "PriceDvdMusic", ofType: "plist")
      
       let filePathCookWare = Bundle.main.path(forResource: "PriceCookWare", ofType: "plist")
      
       let filePathSports = Bundle.main.path(forResource: "PriceSports", ofType: "plist")
      
       let filePathOther = Bundle.main.path(forResource: "PriceOthers", ofType: "plist")
      
      let filePathInternet = Bundle.main.path(forResource: "PriceInternet", ofType: "plist")
      
      let filePathBook = Bundle.main.path(forResource: "PriceBook", ofType: "plist")
      
      let filePathPublicTranspotation = Bundle.main.path(forResource: "PricePublicTranspotation", ofType: "plist")
      
      let filePathToy = Bundle.main.path(forResource: "PriceToy", ofType: "plist")
      
      let filePathConstruction = Bundle.main.path(forResource: "PriceConstruction", ofType: "plist")
      
      let filePathRepair = Bundle.main.path(forResource: "PriceRepair", ofType: "plist")
      
      let filePathGame = Bundle.main.path(forResource: "PriceGame", ofType: "plist")
      
      let filePathDwelling = Bundle.main.path(forResource: "PriceDwelling", ofType: "plist")
      
      
  
      //出来上がったら配列で記入してみる
//      let filePathaa:[String] = [Bundle.main.path(forResource: "McPrice", ofType: "plist")!]
      
      
      //簡単に書く
      switch scSelectedIndex{
      case 0:
        array = NSArray(contentsOfFile: (filePathMc)!)!
      case 1:
        array = NSArray(contentsOfFile:filePathStb!)!
      case 2:
        array = NSArray(contentsOfFile: filePathKfc!)!
      case 3:
        array = NSArray(contentsOfFile: filePathMarukame!)!
      case 4:
        array = NSArray(contentsOfFile: filePathYoshinoya!)!
      case 5:
        array = NSArray(contentsOfFile: filePathConvenience!)!
      case 6:
        array = NSArray(contentsOfFile: filePathCookWare!)!
      case 7:
        array = NSArray(contentsOfFile: filePathGame!)!
      case 8:
        array = NSArray(contentsOfFile: filePathToy!)!
      case 9:
        array = NSArray(contentsOfFile: filePathSuperFoods!)!
      case 10:
        array = NSArray(contentsOfFile: filePathSuperDrink!)!
      case 11:
        array = NSArray(contentsOfFile: filePathBedClothes!)!
      case 12:
        array = NSArray(contentsOfFile: filePathCarBike!)!
      case 13:
        array = NSArray(contentsOfFile: filePathKHomeErectric!)!
      case 14:
        array = NSArray(contentsOfFile: filePathDvd!)!
      case 15:
        array = NSArray(contentsOfFile: filePathInternet!)!
      case 16:
        array = NSArray(contentsOfFile: filePathDwelling!)!
      case 17:
        array = NSArray(contentsOfFile: filePathFashion!)!
      case 18:
        array = NSArray(contentsOfFile: filePathSports!)!
      case 19:
        array = NSArray(contentsOfFile: filePathBook!)!
      case 20:
        array = NSArray(contentsOfFile: filePathStationery!)!
      case 21:
        array = NSArray(contentsOfFile: filePathPublicTranspotation!)!
      case 22:
        array = NSArray(contentsOfFile: filePathConstruction!)!
      case 23:
        array = NSArray(contentsOfFile: filePathRepair!)!
      case 24:
        array = NSArray(contentsOfFile: filePathOther!)!
      default:
        break
      //ファイルパスの読み込み

      //array = NSArray(contentsOfFile: (filePathMc)!)!

         for data in array{
        let dic = data as! NSDictionary
        
        //Key配列の追加！
        placeList.append(dic["camera"] as! String)
        placeList.append(dic["item"] as! String)
        placeList.append(dic["pricePeso"] as! String)
        placeList.append(dic["priceYen"] as! String)
      }
    }
  }
  
  
  
  

  
  
  // addBtnをタップしたときのアクション
  func onClick() {
    let alert = UIAlertController(title: "お気に入り追加", message: "お気に入り画面に追加されます", preferredStyle: .alert)
    //handlerはokボタンが押されたときに行いたい処理を指定する場所(オッケーが押されたときに発動する)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{
      (actiton: UIAlertAction)->Void in
      //ここでアラートがオッケーだった場合の処理を記述
      print("aa")
        
        
        self.contentFavorite = []
        
        //お気に入りの保存したい番号をここでセットする
        let IntDesu:Int = self.scSelectedIndex
        
        //(ここにスタバなんかを保存)
        let ListArray = self.myArrayList
        let ImageArray = self.myImageList
      
        
        
        
        let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appD.persistentContainer.viewContext
            
            //ToDoエンティティオブジェクトを作成
            let favorite = NSEntityDescription.entity(forEntityName: "Favorite", in: viewContext)
            
            //ToDoエンティティにレコード（行）を挿入するためのオブジェクトを作成
            let newRecord = NSManagedObject(entity: favorite!, insertInto: viewContext)
        
        
            //値のセット(アトリビュート毎に指定) forKeyはモデルで指定したアトリビュート名
            //型変更Int->String
        var ChangeNo:String = self.scSelectedIndex.description
        
        print(ChangeNo)
        
            newRecord.setValue(ListArray, forKey: "favorite")
        
            newRecord.setValue(ImageArray, forKey: "favoriteImage")
        
           //newRecord.setValue(self.scSelectedIndex, forKey: "favoriteNo") as! String
        
            newRecord.setValue(ChangeNo, forKey: "favoriteNo")
        
        
        
            newRecord.setValue(Date(), forKey: "saveDate")
            
            //レコード（行）の即時保存
            do{
              try viewContext.save()
            }catch {
              
        }
        //self.read()
            
            print("viewWillDisappear")
        
        
    }))
    
    
    //アラートがキャンセルの場合
      alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel))
    
    //アラート表示
    present(alert,animated: true,completion: nil)
    
  }//addBtn(お気に入り)ボタンを押した時の閉じタグ
  
  
  //Mark: ヘッダーに設定するViewを設定する
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
    
//    //ヘッダーにするビューを生成
//    let view = UIView()
//    view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
//    view.backgroundColor = #colorLiteral(red: 1, green: 0.9970277546, blue: 0.8703434157, alpha: 1)
    
    //ヘッダーにするビューを生成
    let view = UIView()
    view.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
    view.backgroundColor = #colorLiteral(red: 1, green: 0.9970277546, blue: 0.8703434157, alpha: 1)
    
    
    //ヘッダーに追加するラベルを生成
    let headerLabel = UILabel()
    
     headerLabel.frame =  CGRect(x: 0, y: -5, width: 75, height: 38)
    headerLabel.text = "イメージ"
    headerLabel.textColor = UIColor.blue
    headerLabel.textAlignment = NSTextAlignment.left
     headerLabel.font = UIFont.boldSystemFont(ofSize: 19)
    headerLabel.adjustsFontSizeToFitWidth = true
    headerLabel.minimumScaleFactor = 0.5
    view.addSubview(headerLabel)
    

    
    
    let headerLabel2 = UILabel()
    headerLabel2.frame =  CGRect(x: 104, y: -5, width: 80, height: 38)
    headerLabel2.text = "アイテム"
    headerLabel2.textColor = UIColor.blue
    headerLabel2.textAlignment = NSTextAlignment.left
    headerLabel2.font = UIFont.boldSystemFont(ofSize: 19)
    view.addSubview(headerLabel2)
    
    
    let headerLabel3 = UILabel()
    headerLabel3.frame =  CGRect(x: self.view.frame.size.width - 180, y: -5, width: 91, height: 38)
    headerLabel3.text = "フィリピン"
    headerLabel3.textColor = UIColor.blue
    headerLabel3.textAlignment = NSTextAlignment.center
     headerLabel3.font = UIFont.boldSystemFont(ofSize: 19)
    headerLabel3.adjustsFontSizeToFitWidth = true
    headerLabel3.minimumScaleFactor = 0.5
    
    view.addSubview(headerLabel3)
    
    
    
    let headerLabel4 = UILabel()
    headerLabel4.frame =  CGRect(x: self.view.frame.size.width - 85, y: -5, width: 80, height: 38)
    headerLabel4.text = "ジャパン"
    headerLabel4.textColor = UIColor.blue
    headerLabel4.textAlignment = NSTextAlignment.center
     headerLabel4.font = UIFont.boldSystemFont(ofSize: 19)
    view.addSubview(headerLabel4)
    
    
    
    //ラベルを最前面に移動
    //self.view.bringSubview(toFront: headerLabel2)
    
    return view
  }
  
  
  
  //セクションの数
  func numberOfSections(in tableView: UITableView) -> Int {
    
    return 1
    
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  
  var Change:Int = 1

  @IBAction func mySwitch(_ sender: UISwitch) {
    
    if (sender.isOn){
      Change = 1
      }else{
      Change = 2
      }
    myTableView1_3.reloadData()
  }

  //ここで画面を表示 cellに値を設定！
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
    
    //取り出す時は型の宣言しなければならない！ as!NS~~
    dicB = array[indexPath.row] as! NSDictionary
    
    cell.nameLabel.adjustsFontSizeToFitWidth = true
    cell.nameLabel.minimumScaleFactor = 0.5 //# 最小でも80%までしか縮小しない場合
    cell.PesoLabel.adjustsFontSizeToFitWidth = true
    cell.PesoLabel.minimumScaleFactor = 0.5 //# 最小でも80%までしか縮小しない場合
    cell.YenLabel.adjustsFontSizeToFitWidth = true
    cell.YenLabel.minimumScaleFactor = 0.5
    
    
    cell.ProductsImage.image = UIImage(named: dicB["camera"] as! String)
    

    cell.nameLabel.text? = dicB["item"] as! String
    
    
    if Change == 1{
    
    cell.PesoLabel.text? = dicB["pricePeso"] as! String
    //罫線の余白をとる
    cell.layoutMargins = UIEdgeInsets.zero
    
    
    var amountYen3:String = dicB["priceYen"] as! String
    
    
    var Aaa = amountYen3.replacingOccurrences(of: ".", with: "")
    // 呼び出し
    if isOnlyNumber(Aaa) {
      // 数字のみ
      //amountPHPにレートが入っている
      print("ここに入っている\(amountPHP)")
      //型変換
      var amountYen = dicB["priceYen"] as! String
      
      var exchangePhp = amountPHP * Double(amountYen)!
      //amountPhpArray = NumberFormatter().number(from: dicB["priceYen"]) as! Int
      //0fの意味、小数点の後ろが０桁　後ろが２だったら２桁
     var exchangePhp3 = NSString(format: "%.0f",exchangePhp)
      
      cell.YenLabel.text? = String(exchangePhp3)
      cell.phpLabel.text? = "php"
      cell.YenUnitLabel.text? = "php"
      
    } else {
      // 数字のみでない
      cell.YenLabel.text? = dicB["priceYen"] as! String
      cell.phpLabel.text? = "php"
      cell.YenUnitLabel.text? = "php"
    }
      
      
    }else{
      
      cell.PesoLabel.text? = self.dicB["pricePeso"] as! String
      //罫線の余白をとる
      cell.layoutMargins = UIEdgeInsets.zero
      
      var amountYen4:String = dicB["pricePeso"] as! String
      
      var Aaa = amountYen4.replacingOccurrences(of: ".", with: "")
      // 呼び出し
      if isOnlyNumber(Aaa) {
        // 数字のみ
        //amountPHPにレートが入っている
        print("ここに入っている\(amountPHP)")
        //型変換
        var amountYen3 = dicB["pricePeso"] as! String
        
        var exchangePhp5 = Double(amountYen3)! / amountPHP
        //amountPhpArray = NumberFormatter().number(from: dicB["priceYen"]) as! Int
        //0fの意味、小数点の後ろが０桁　後ろが２だったら２桁
        var exchangePhp10 = NSString(format: "%.0f",exchangePhp5)
        
        cell.YenLabel.text? = dicB["priceYen"] as! String
        cell.PesoLabel.text? = String(exchangePhp10)
        cell.phpLabel.text? = "円"
        cell.YenUnitLabel.text? = "円"
        
      } else {
        // 数字のみでない
        cell.YenLabel.text? = dicB["priceYen"] as! String
        cell.phpLabel.text? = "円"
        cell.YenUnitLabel.text? = "円"
      }
    }
    
      
    
    
    return cell
  }
  
  

//  }else if Change == 2{
//
//  // 円表示にするための計算式
//  var amountYen3:String = dicB["pricePeso"] as! String
//  var Aaa = amountYen3.replacingOccurrences(of: ".", with: "")
//  // 呼び出し
//  if isOnlyNumber(Aaa) {
//  var amountPesoA = dicB["pricePeso"] as! String
//  var exchangePhpA = amountPHP * 10 / 20 * Double(amountPesoA)!
//  //amountPhpArray = NumberFormatter().number(from: dicB["priceYen"]) as! Int
//  //0fの意味、小数点の後ろが０桁　後ろが２だったら２桁
//  var exchangePhp4 = NSString(format: "%.0f",exchangePhpA)
//
//  cell.YenLabel.text? = String(exchangePhp4)
//  } else {
//  // 数字のみでない
//  cell.YenLabel.text? = dicB["pricePeso"] as! String
//  }
//
//  }
  
  
  
      
      
      
  
  // 数字のみかを調べる。
  func isOnlyNumber(_ str:String) -> Bool {
    let predicate = NSPredicate(format: "SELF MATCHES '\\\\d+'")
    return predicate.evaluate(with: str)
  }

  
  

      //型変換
      //amountPhpArray.append(Int(dicB["priceYen"] as! String)!)
      
      
      
      //    var amountP:Int = Int(0.45)
      //    for element in amountPhpArray {
      //      print(element * amountP)
      //      //print(Double(element * amountP)); 10000
      //    }
      
      
      
      //cell.YenLabel.text? = dicB["priceYen"] as! String
      
  //  internal func onClickMySwicth(sender: UISwitch){
//
//
//    if sender.isOn {
//
//      cell.php = "On"
//      myLabel.backgroundColor = UIColor.orange
//    }
//    else {
//      myLabel.text = "Off"
//      myLabel.backgroundColor = UIColor.gray
//    }
//  }
//
  
  

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
