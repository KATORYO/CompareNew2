//
//  ThirdViewController3_1.swift
//  Compare
//
//  Created by 加藤諒 on 2017/10/08.
//  Copyright © 2017年 mirai. All rights reserved.
//

import UIKit
import CoreData

class ThirdViewController3_1: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
  
  @IBOutlet weak var myTableView: UITableView!
  
  
  var numbFingers = -1
  
  var numFin = -1

  var contentFavorite:[String] = []
  var contentFavoriteImage:[String] = []
  var contentFavoriteNo:[Int] = []
  
  var contentFavoriteDate:[Date] = []
  
  var noDesu:Int = -1
  
 
  var contentFavoriteDesu:String = ""

  
  
  @IBOutlet weak var editBtn: UIBarButtonItem!
  
   let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 25)] as [String: Any]
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      

      //fontawsome適用！
      self.editBtn.setTitleTextAttributes(attributes, for: .normal)
          self.editBtn.title = String.fontAwesomeIcon(name: .th)
      
        read()
    
      
        myTableView.reloadData()
        // 罫線を青色に設定.
        myTableView.separatorColor = UIColor.lightGray
     
      
      
      //registerで登録する！！
      //tableViewを使えるようにする！
      self.myTableView.register(UINib(nibName: "CustomTableView2", bundle: nil), forCellReuseIdentifier: "Cell2")
      
      
    }
  
  
  
  //appdelegateに書いた値を共有できるようにする
  var delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
  
  
  override func viewWillAppear(_ animated: Bool) {
    
    read()

    reloadInputViews()
    myTableView.reloadData()
    
  }
  
  
  //CoreDataに保存されているデータの読み込み処理（READ）
  func read(){

    contentFavorite = []
    contentFavoriteNo = []
    contentFavoriteImage = []
    contentFavoriteDate = []
    
    
    //AppDelegateを使う用意をしておく
    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //エンティティを操作するためのオブジェクトを使用
    let viewContext = appD.persistentContainer.viewContext
    
    //どのエンティティからデータを取得してくるか設定
    let query:NSFetchRequest<Favorite> = Favorite.fetchRequest()
    
    //データ一括取得
    do{
      //保存されてるデータをすべて取得
      let fetchResults = try viewContext.fetch(query)
      
      //一件ずつ表示
      for result:AnyObject in fetchResults{
        let favorite:String? = result.value(forKey:"favorite") as? String
        let favoriteImage:String? = result.value(forKey: "favoriteImage") as? String
        
        let favoriteNo = result.value(forKey: "favoriteNo") as! String
        
        let saveDate:Date = result.value(forKey: "saveDate") as! Date
        
        if contentFavorite.count == nil{
          print("失敗です")
        }else{
        contentFavorite.append(favorite as! String)
     contentFavoriteImage.append(favoriteImage as! String)
          
          //型変換　String型からInt
          var favoriteNo2 = NumberFormatter().number(from: favoriteNo) as! Int
          
        contentFavoriteNo.append(favoriteNo2 as! Int)
          
        contentFavoriteDate.append(saveDate)
          
        }
  
      }
    }catch{
      
    }
  }

  
  
  
  
  //セクションの数
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  //セルの数
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contentFavorite.count
  }
  
  
  
  //ここで画面を表示 cellに値を設定！
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! CustomTableViewCell2
    
   
    cell.LabelArray?.text = contentFavorite[indexPath.row]
    
    cell.ImageArray?.image = UIImage(named: contentFavoriteImage[indexPath.row])
    
    
    cell.accessoryType = .disclosureIndicator
    return cell
    
  }
  
  
  
  
  //押された時の処理//データ受け渡し画面
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    //self.numbFingers = indexPath.row
    
    self.numbFingers = contentFavoriteNo[indexPath.row]
    
    
    
    
    contentFavoriteDesu = contentFavorite[indexPath.row]
    
    
    //3-1の情報を1-3に
    self.numFin = indexPath.row
    
    performSegue(withIdentifier: "nextFavorite", sender: nil)
  }

  
    //次の画面を設定
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    let next: ViewController1_3 = segue.destination as! ViewController1_3
    
    
    //マクドナルド等の情報を送っている
    next.myArrayListFrom3_1 = contentFavoriteDesu
    
    next.scSelectedIndex = numbFingers

    next.scNumFin = numFin
   
    
  }
  @IBAction func editBtn(_ sender: UIBarButtonItem) {
    setEditing(isEditing, animated: true)
  }
  
  
  
  /*
   編集ボタンが押された際に呼び出される
   */
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    
    //通常モードと編集モードを切り替える。
    if(myTableView.isEditing == true) {
      myTableView.isEditing = false
    } else {
      myTableView.isEditing = true
    }
  
  }
  
        //スワイプ処理！
      //なぜこれで表示されるのか？？＝＝delegateで委譲している為！
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
  let action = UITableViewRowAction(style: .default, title: "削除"){ action, indexPath in
  
  //アクション
  
  self.noDesu = indexPath.row
  
  //AppDelegateを使う用意をしておく
  let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
  
  //エンティティを操作するためのオブジェクトを使用
  let viewContext = appD.persistentContainer.viewContext
  
  //どのエンティティからデータを取得してくるか設定
  let query:NSFetchRequest<Favorite> = Favorite.fetchRequest()
  
  //更新するデータの取得！ここで絞り込み
  let namePredicte = NSPredicate(format: "saveDate = %@", self.contentFavoriteDate[self.noDesu] as CVarArg)
 // 絞り込み検索（更新したいデータを取得する）
  query.predicate = namePredicte
  
  
  do{
    let fetchRequests = try viewContext.fetch(query)
    for result:AnyObject in fetchRequests{
      //取得したデータを指定し、削除
      let record = result as! NSManagedObject
      
      viewContext.delete(record)
    }
    //削除した状態を保存
    try viewContext.save()
    
  }catch{
    print("削除失敗")
  }

  self.read()
  self.myTableView.reloadData()
  
    }
    
    return [action]
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
