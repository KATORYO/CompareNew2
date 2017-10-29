//
//  SecondViewController.swift
//  Compare
//
//  Created by 加藤諒 on 2017/09/17.
//  Copyright © 2017年 mirai. All rights reserved.
//

import UIKit
import CoreData
import FontAwesome_swift
import Social

class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
  var myText:String!
  
  var contentTitle:[String] = []
  
  
  var contentDate:[Date] = []
  
  //fontawsomeのため
  @IBOutlet weak var newPage: UIBarButtonItem!
  @IBOutlet weak var editBtn: UIBarButtonItem!
  let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 25)] as [String: Any]
  
 
  
  //appdelegateに書いた値を共有できるようにする
  var delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
  
  //メモNo
  var memoNo:Int = 0
  
  
  var noDesu:Int = -1
  
  
  @IBOutlet weak var myTableViewMemo: UITableView!
 
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    print()
    //fontawsome適用！
    self.editBtn.setTitleTextAttributes(attributes, for: .normal)
    self.editBtn.title = String.fontAwesomeIcon(name: .th)
    //fontawsome適用！
    self.newPage.setTitleTextAttributes(attributes, for: .normal)
    self.newPage.title = String.fontAwesomeIcon(name: .pencilSquareO)
    
    myTableViewMemo.delegate = self
    myTableViewMemo.reloadData()
    
    // 罫線を青色に設定.
    myTableViewMemo.separatorColor = UIColor.lightGray
    
    // 編集中のセル選択を許可.
    //編集中でも中身確認ができるmyTableViewMemo.allowsSelectionDuringEditing = true
  
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    read()
    
    myTableViewMemo.reloadData()
    
  }
  
  
  
  
  
  
  //CoreDataに保存されているデータの読み込み処理（READ）
  func read(){
    
    contentTitle = []
    contentDate = []
    
    //AppDelegateを使う用意をしておく
    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //エンティティを操作するためのオブジェクトを使用
    let viewContext = appD.persistentContainer.viewContext
    
    //どのエンティティからデータを取得してくるか設定
    let query:NSFetchRequest<Memo> = Memo.fetchRequest()
    
    //データ一括取得
    do{
      //保存されてるデータをすべて取得
      let fetchResults = try viewContext.fetch(query)
      
      //一件ずつ表示
      for result:AnyObject in fetchResults{
        let memo:String? = result.value(forKey:"memo") as? String
        let saveData:Date = result.value(forKey: "saveData") as! Date
       
        print("memo:\( result.value(forKey:"memo"))")
        
        print("saveData:\(result.value(forKey: "saveData"))")

        if memo == nil{
          print("0です")
        }else{
        contentTitle.append(memo as! String)
        
        //付け加え
        contentDate.append(saveData)

        }
      }
    }catch{
      
    }
  }
  
  
  
 

override func didReceiveMemoryWarning() {
  super.didReceiveMemoryWarning()
  // Dispose of any resources that can be recreated.
}

  
  //セクションの数
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  //表示するセルの数
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    //必要な処理か？
    if contentTitle.count == 0{
    return 0
    }else{
      return contentTitle.count
    }
    
  }
  
  
  //cellに表示させる　値を決める
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
    
    
    let formatter:DateFormatter = DateFormatter()
      formatter.dateFormat = "yyyy/MM/dd HH:mm"
    
    formatter.locale = Locale(identifier: "ja_JP")
    
    let date = formatter.string(from: contentDate[indexPath.row])
    
    
//    let sectionData = contentTitle[indexPath.row]
//    let cellData = sectionData
    if contentTitle == nil {
      cell.textLabel?.text = ""
      cell.detailTextLabel?.text = String(describing: contentDate[indexPath.row])
    }else{
        //cell.detailTextLabel?.text = contentTitle[indexPath.row]
      cell.detailTextLabel?.text = date
        cell.textLabel?.text = contentTitle[indexPath.row]
    }
    
      //cell.textLabel?.text = contentTitle[memoNo]
    
    //入力したときのデータを入れたい！
      //cell.detailTextLabel?.text = data_in_code_entry
      cell.accessoryType = .disclosureIndicator
    
    //サブタイトルのカラーが青色
      cell.detailTextLabel?.textColor = UIColor.blue
    
//    
    
    //contentTitle[1] = memoNo
    //cell.textLabel!.text = contentTitle[]
    //cell.textLabel!.text = contentTitle[indexPath.row]
    
    return cell
  }

    //押された時の処理//データ受け渡し画面
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
     self.memoNo = indexPath.row


  
    performSegue(withIdentifier: "next3", sender: nil)
  }
  
  
  
  //ユーザー記録の上にある書き込みマーク
  @IBAction func newPage(_ sender: UIBarButtonItem) {
 
      performSegue(withIdentifier: "next4", sender: nil)
    }
  
  
  //エディットボタン！
  @IBAction func editBtn(_ sender: UIBarButtonItem) {
    
    setEditing(isEditing, animated: true)
    
  }
  
  
  
  /*
   編集ボタンが押された際に呼び出される
   */
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    
    if contentTitle == nil{
      print("失敗")
    }else{
    
    //通常モードと編集モードを切り替える。
    if(myTableViewMemo.isEditing == true) {
      myTableViewMemo.isEditing = false
    } else {
      myTableViewMemo.isEditing = true
    }
    
    
    }
//    // TableViewを編集可能にする
//    myTableViewMemo.setEditing(editing, animated: true)
//
//    // 編集中のときのみaddButtonをナビゲーションバーの左に表示する
//    //if editing {
//      print("編集中")
//      let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(SecondViewController.addCell(sender:)))
//      self.navigationItem.setLeftBarButton(addButton, animated: true)
//    } else {
//      print("通常モード")
//      //self.navigationItem.setLeftBarButton(nil, animated: true)
//    }
  }
  /*
   addButtonが押された際呼び出される
   */
  func addCell(sender: AnyObject) {
    print("追加")

    
    // TableViewを再読み込み.
    myTableViewMemo.reloadData()
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
      let query:NSFetchRequest<Memo> = Memo.fetchRequest()
      
      //更新するデータの取得！ここで絞り込み
      let namePredicte = NSPredicate(format: "saveData = %@", self.contentDate[self.noDesu] as CVarArg)
      //絞り込み検索（更新したいデータを取得する）
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
      self.myTableViewMemo.reloadData()
      
    }
    
    return [action]
  }
  
//  
//  func deleteData(){
//    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//    let context:NSManagedObjectContext = appDelegate.managedObjectContext
//    let fetchRequest:NSFetchRequest<Memo> = Memo.fetchRequest()
//    let predicate = NSPredicate(format:"%K = %@","name","相田あい")
//    fetchRequest.predicate = predicate
//    let fetchData = try! context.fetch(fetchRequest)
//    if(!fetchData.isEmpty){
//      for i in 0..<fetchData.count{
//        let deleteObject = fetchData[i] as Memo
//        context.delete(deleteObject)
//      }
//      do{
//        try context.save()
//      }catch{
//        print(error)
//      }
//    }  
//  }
  
  

  
  //受け渡しメソッド
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if (segue.identifier == "next3") {
      let subVC: SecondViewController2_2 = (segue.destination as? SecondViewController2_2)!
      subVC.MemoNo = self.memoNo
      print(memoNo)
    }
    
    
    
  }
  
  

  
  
  @IBAction func back (_ segue:UIStoryboardSegue){}
  
  
  
}//class閉じ
