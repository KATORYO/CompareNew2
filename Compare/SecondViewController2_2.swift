//
//  SecondViewController2_2.swift
//  Compare
//
//  Created by 加藤諒 on 2017/10/01.
//  Copyright © 2017年 mirai. All rights reserved.
//

//変えた
import UIKit
import CoreData
import FontAwesome_swift
import Social
import Photos
import AssetsLibrary

class SecondViewController2_2: UIViewController,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
  

  
  let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Memo")
  
  //メモNo
  var MemoNo = -1
  
  //メモ内容
  @IBOutlet weak var myTitle: UITextView!
  
  
  
  
  let dateformatter = NSDate()
  
  //twiiterボタン
  var myComposeView : SLComposeViewController!
  
  //fontawsome適用！
  let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 22)] as [String: Any]
  
  //インスタンスの作成
  //let saves = UserDefaults.standard
  
  //@NSManaged var name: String
  
  var contentTitle:[String] = []
  
  var contentDate:[Date] = []
  
  
  var fetchedArray: [NSManagedObject] = []
  
  
  var NoDesuYo = 0
  
  
  
  let notificationCenter = NotificationCenter.default
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    print(MemoNo)
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Memo")
    do {
      fetchedArray = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
  }
  
  //テキストを閉じる処理
  @IBAction func closeBtn(_ sender: UIBarButtonItem) {
    myTitle.resignFirstResponder()
  }
  
  
  
  
  
  @IBOutlet weak var BackBtn: UIBarButtonItem!
  
  
  
  let strLeft = NSAttributedString(string: "")
  let attachment = NSTextAttachment()
  let str = NSMutableAttributedString()
  
  
  
  //viedDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
   
    
    var myTitle2:NSAttributedString = myTitle.attributedText
    
  
    
    //    let attributes = [NSFontAttributeName: UIFont.fontAwesome(ofSize: 20)] as [String: Any]
    BackBtn.setTitleTextAttributes(attributes, for: .normal)
    BackBtn.title = String.fontAwesomeIcon(name: .chevronLeft)
    
    
    
    //CoreDataからデータを読み込む処理
    read()
    
    //myTitle.text? = ""
    
    
    //現在データの取得コード
    //datedesuyoに日付が入っている
    let now = NSDate()
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    let dateDesuyo = formatter.string(from: now as Date)
    
    
    
    
    //ここが一つ前の新規ボタンを押しても表示されない鍵
    if MemoNo == -1 {
      myTitle.text? = ""
    }else{
      myTitle.text? = contentTitle[MemoNo]
      
    }
    
    
    
    //ペーストなどの処理をはる！
    // MenuController生成.
    let myMenuController: UIMenuController = UIMenuController.shared
    
    // MenuControllerを表示.
    myMenuController.isMenuVisible = true
    
    // 矢印の向きを下に設定.
    myMenuController.arrowDirection = UIMenuControllerArrowDirection.down
    
    // rect、viewを設定.
    myMenuController.setTargetRect(CGRect.zero, in: self.view)
    
    // MenuItem生成.
    let myMenuItem_1: UIMenuItem = UIMenuItem(title: "文字色", action: #selector(SecondViewController2_2.onMenu1(sender:)))
    let myMenuItem_2: UIMenuItem = UIMenuItem(title: "テキスト編集", action: #selector(SecondViewController2_2.onMenu2(sender:)))
    let myMenuItem_3: UIMenuItem = UIMenuItem(title: "写真", action: #selector(SecondViewController2_2.onMenu3(sender:)))
    
    
    
    // MenuItemを配列に格納.
    let myMenuItems: NSArray = [myMenuItem_1, myMenuItem_2, myMenuItem_3]
    
    // MenuControllerにMenuItemを追加.
    myMenuController.menuItems = myMenuItems as? [UIMenuItem]
    
    
    keyboardToolbar(textView:  myTitle)
    
    
    
  }//viewdidloadの閉じタグ
  
  
  
  //キーボード押した時に上に現れる
  func keyboardToolbar(textView: UITextView) {
    
    let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    toolbar.barStyle = UIBarStyle.default
    toolbar.bounds.size.height = 25
    
    let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    
    
    let done: UIBarButtonItem = UIBarButtonItem(title: "閉じる", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.doneButtonActionn))
    done.tintColor = UIColor.blue
    
  
    //完成してないため10/24
//    let choosePicture: UIBarButtonItem = UIBarButtonItem(title: "choosePicture", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.choosePicture))
//    choosePicture.tintColor = UIColor.blue
//
//
//    let cameraPhoto: UIBarButtonItem = UIBarButtonItem(title: "pen", style: .plain, target: self, action: #selector(self.cameraPhotoAction))
//    cameraPhoto.tintColor = UIColor.blue
    
    
    let twitter: UIBarButtonItem = UIBarButtonItem(title: "twiter", style: .plain, target: self, action: #selector(self.twitter))
    //cameraPhoto.tintColor = UIColor.blue
    
    let faceBook: UIBarButtonItem = UIBarButtonItem(title: "faceBook", style: .plain, target: self, action: #selector(self.facebook))
    //cameraPhoto.tintColor = UIColor.blue
    
    
    
    done.setTitleTextAttributes(attributes, for: .normal)
    done.title = String.fontAwesomeIcon(name: .close)
    
//    cameraPhoto.setTitleTextAttributes(attributes, for: .normal)
//    cameraPhoto.title = String.fontAwesomeIcon(name: .camera)
//
//    choosePicture.setTitleTextAttributes(attributes, for: .normal)
//    choosePicture.title = String.fontAwesomeIcon(name: .pictureO)
    
    twitter.setTitleTextAttributes(attributes, for: .normal)
    twitter.title = String.fontAwesomeIcon(name: .twitter)
    
    faceBook.setTitleTextAttributes(attributes, for: .normal)
    faceBook.title = String.fontAwesomeIcon(name: .facebook)
    
    
    var items = [UIBarButtonItem]()
    
//    items.append(cameraPhoto)
//    items.append(choosePicture)
    items.append(flexSpace)
    items.append(twitter)
    items.append(faceBook)
    
    
    items.append(done)
    
    toolbar.items = items
    toolbar.sizeToFit()
    
    textView.inputAccessoryView = toolbar
    
  }
  
  //カ
  func doneButtonActionn() {
    self.myTitle.resignFirstResponder()
  }
  
  
  // ボタンイベント.
  func twitter(sender : AnyObject) {
    // SLComposeViewControllerのインスタンス化.
    // ServiceTypeをTwitterに指定.
    myComposeView = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
    
    // 投稿するテキストを指定.
    myComposeView.setInitialText("Facebook Test")
    
    //myComposeView = UIImage(frame: CGRect(x: 0, y: 0, width: 100, height: 10))
    
    // 投稿する画像を指定.
    myComposeView.add(UIImage(named: "Appliance-12"))
    
    
    
    // myComposeViewの画面遷移.
    self.present(myComposeView, animated: true, completion: nil)
  }
  
  
  func facebook(sender : AnyObject) {
    
    // ServiceTypeをFacebookに指定.
    myComposeView = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
    
    // 投稿するテキストを指定.
    myComposeView.setInitialText(myTitle.text)
    
    // 投稿する画像を指定.
    myComposeView.add(UIImage(named: "EtcTop"))
    
    // myComposeViewの画面遷移.
    self.present(myComposeView, animated: true, completion: nil)
    
  }
  
  
  
  
  
  // カメラロールから写真を選択する処理
  @IBAction func choosePicture() {
    // カメラロールが利用可能か？
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
      // 写真を選ぶビュー
      let pickerView = UIImagePickerController()
      // 写真の選択元をカメラロールにする
      // 「.camera」にすればカメラを起動できる
      pickerView.sourceType = .photoLibrary
      // デリゲート
      pickerView.delegate = self
      // ビューに表示
      self.present(pickerView, animated: true)
    }
  }
  
  
  
  
  
  
  //カメラボタン
  func cameraPhotoAction(){
    
    
    //カメラが使えるかどうか判断するための情報を取得する（列挙体p.286） //このデバイスで使えるかどうか
    let camera = UIImagePickerControllerSourceType.camera
    
    //カメラが使える場合 の判断コード 型メソッド（isSourceTypeAvailable）
    if UIImagePickerController.isSourceTypeAvailable(camera){ //01
      
      //ImagePickerControllerオブジェクトを生成
      let picker = UIImagePickerController()
      
      //カメラタイプと設定
      picker.sourceType = camera
      
      //デリゲートの設定(撮影後のメソッドを感知するため)
      picker.delegate = self
      
      //ImagePickerの表示（モーダル）
      present(picker,animated: true,completion: nil)
    } //01
    
    self.myTitle.resignFirstResponder()
    
  }
  
  
  //カメラで撮影し終えた後に発動するメリット
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
    //imageViewに撮影した写真をセットするために、imageを保存　　何かのボタンを押したときに表示させるための時ように、Imageに型をいれる
    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    
    //imageViewに設
    var attach:NSTextAttachment = NSTextAttachment()
    attach.image = (image)
    attach.bounds=CGRect(x: 0, y: 0, width: (350), height: (350))
    var attr_string:NSAttributedString = NSAttributedString(attachment: attach)
    
    
    
//    // 選択した画像・写真を取得し、imageViewに表示
//    if let info1 = info, let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
//      ProfileImage.image = editedImage
//    }else{
//      ProfileImage.image = image
//    }
    
    myTitle.attributedText = attr_string
    
    //自分のデバイス（今このプログラムが動いている場所）に写真を保存
    UIImageWriteToSavedPhotosAlbum(image,nil,nil,nil)
    
    
    //モーダルで表示した写真撮影用の画面を閉じる（前の画面に戻る）
    dismiss(animated: true, completion: nil)
    
  }
  
  
  

  
  //textviewに編集する
  //UITextFieldが編集開始された直後に呼ばれる.
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    
    self.keyboardToolbar(textView: textView)
    return true
  }
  
  
  //テキストビューに編集する
  //UITextViewが編集終了する直前に呼ばれる.
  func textViewShouldEndEditing(_ textview: UITextView) -> Bool {
    print("textFieldShouldEndEditing" + myTitle.text!)
    return true
  }
  
  
  //作成したMenuItemが表示されるようにする.
  override func canPerformAction(_ action: Selector, withSender sender: Any!) -> Bool {
    if action == #selector(SecondViewController2_2.onMenu1(sender:)) || action == #selector(SecondViewController2_2.onMenu2(sender:)) || action == #selector(SecondViewController2_2.onMenu3(sender:))  {
      return true
    }
    return false
  }
  
  
  //MenuItemが押されたとき！！
  internal func onMenu1(sender: UIMenuItem) {
    print("onMenu1")
  }
  
  internal func onMenu2(sender: UIMenuItem) {
    print("onMenu2")
  }
  
  internal func onMenu3(sender: UIMenuItem) {
    print("onMenu3")
  }
  
  
  
  
  
  //CoreDataに保存されているデータの読み込み処理（READ）
  func read(){
    
    //AppDelegateを使う用意をしておく
    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //エンティティを操作するためのオブジェクトを使用
    let viewContext = appD.persistentContainer.viewContext
    
    //どのエンティティからデータを取得してくるかc設定
    let query:NSFetchRequest<Memo> = Memo.fetchRequest()
    //
    //    let namePredicte = NSPredicate(format: "saveData = %@"
    //    query.predicate = namePredicte
    //
    //データ一括取得
    do{
      //保存されてるデータをすべて取得
      let fetchResults = try viewContext.fetch(query)
      
      //一件ずつ表示
      for result:AnyObject in fetchResults{
        let memo:String? = result.value(forKey:"memo") as? String
        let saveData:Date = result.value(forKey: "saveData") as! Date
        
        if memo == nil {
          print("0です")
        }else{
          contentTitle.append(memo!)
          contentDate.append(saveData)
        }
        
      }
    }catch{
    }
    
    //画面表示
    //print(contentTitle[0]+memoNo)
    
    
    myTitle.reloadInputViews()
  }
  
  
  //削除ボタンが押された時(DELETEに当たる処理)
  @IBAction func tapDeleate(_ sender: UIBarButtonItem) {
    
    //AppDelegateを使う用意をしておく
    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //エンティティを操作するためのオブジェクトを使用
    let viewContext = appD.persistentContainer.viewContext
    
    //どのエンティティからデータを取得してくるか設定
    let query:NSFetchRequest<Memo> = Memo.fetchRequest()
    
    
    //データを一括取得
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
      
    }
    contentTitle = []
    read()
    myTitle.reloadInputViews()
  }
  
  
  //戻るボタンと保存ボタン
  @IBAction func BackBtn(_ sender: UIBarButtonItem) {
    
    var nakamiComfirm = ""
    
    nakamiComfirm = myTitle.text
    
    var mymyText = myTitle.text
  
    
    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //エンティティを操作するためのオブジェクトを作成
    let viewContext = appD.persistentContainer.viewContext
    
//    if ((nakamiComfirm == "") || (nakamiComfirm == nil)){
    //var abc:String = ""
    //isEmptyは空かどうかの判断
    if nakamiComfirm.isEmpty {
      print("empty!!")
      print("保存しない")
    }else{
      if MemoNo == -1{
        print("新規追加")
        let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appD.persistentContainer.viewContext
        
        //ToDoエンティティオブジェクトを作成
        let Memo = NSEntityDescription.entity(forEntityName: "Memo", in: viewContext)
        
        //ToDoエンティティにレコード（行）を挿入するためのオブジェクトを作成
        let newRecord = NSManagedObject(entity: Memo!, insertInto: viewContext)
        
        
//        // UIImage => NSDataに変換して保存
//        if let image = UIImage(named: "image") {
//          let imageData = UIImageJPEGRepresentation()
//          var mymymyTitle:String = myTitle.text as String}
  
        
//          let imageD = UIImage(named: "Image")
//        let myTitle2 = UIImageJPEGRepresentation(imageD!, 1),
//
//
//          // 画像のパスを取得
//          var imageUrl = UIImagePickerControllerReferenceURL as? NSURL
//
        
        //myTitle = myTitle2 as! String
        //(named: image)
        
//        myTitle = imageUrl
//
//        var aaa = myTitle.text as String
        
//        newRecord.setValue(myTitle.text(string: "http://www.test.co.jp"); forKey: "memo")
        
        //値のセット(アトリビュート毎に指定) forKeyはモデルで指定したアトリビュート名
        newRecord.setValue(myTitle.text, forKey: "memo")
        newRecord.setValue(Date(), forKey: "saveData")
        
        //print("実験\(mymymyTitle)")
        
        
        //レコード（行）の即時保存
        do{
          try viewContext.save()
        }catch {
          
        }
        
        read()
        
        myTitle.reloadInputViews()
        
        print("viewWillDisappear")
        
      }else{
        print("編集保存")
        
        //編集モードでかつ文字が入ってない時
        
        let query:NSFetchRequest<Memo> = Memo.fetchRequest()
        
        //更新するデータの取得！ここで絞り込み
        let namePredicte = NSPredicate(format: "saveData = %@", contentDate[MemoNo] as CVarArg)
        //絞り込み検索（更新したいデータを取得する）
        query.predicate = namePredicte
        
        do{
          
          let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
          
          //エンティティを操作するためのオブジェクトを作成
          let viewContext = appD.persistentContainer.viewContext
          
          
          //絞り込み検索している
          let fetchResults = try! viewContext.fetch(query)
          
          
          //全部有る分フェッチを回す（一つだけ）
          for result:AnyObject in fetchResults {
            
            // 編集可能にする
            let record = result as! NSManagedObject
            
            //編集された分はここに保存
            //record setvalueが編集キー
            record.setValue(myTitle.text, forKey: "memo")
            
            do{
              //レコードの即時保存
              //ここで確定！
              try viewContext.save()
            }catch{
            }
          }
        }
      }
    }
    //一つ前に戻る処理！
    self.dismiss(animated: true, completion: nil)
  }
  
  
  
  
  
  
  
  //新規作成ボタン（compose）
  @IBAction func newPageBtn(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: "nextAgain", sender: nil)
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    let same: SecondViewController2_2 = segue.destination as! SecondViewController2_2
    
     var noDesuYo:Int = 1
    
    same.NoDesuYo = noDesuYo

  }

  
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  
  
  
  //  func a(_ ) ->{
  //    var attach:NSTextAttachment = NSTextAttachment()
  //    attach.image = (image)
  //    attach.bounds=CGRect(x: 0, y: 0, width: 40, height: 40)
  //    var attr_string:NSAttributedString=NSAttributedString(attachment: attach)
  //    result.insertAttributedString(myTitle, atIndex: 40)
  //  }
  
  
  
  
  // cell.textLabel!.text = self.saves
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}


//  //保存   //（機能していない）
//  @IBAction func saveButton(sender: AnyObject) {
//    //AppDelegateを使う用意をしておく
//    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//    //エンティティを操作するためのオブジェクトを作成
//    let viewContext = appD.persistentContainer.viewContext
//    //ToDoエンティティオブジェクトを作成
//    let Memo = NSEntityDescription.entity(forEntityName: "Memo", in: viewContext)
//    //ToDoエンティティにレコード（行）を挿入するためのオブジェクトを作成
//    let newRecord = NSManagedObject(entity: Memo!, insertInto: viewContext)
//    //値のセット(アトリビュート毎に指定) forKeyはモデルで指定したアトリビュート名
//    newRecord.setValue(myTitle.text, forKey: "memo")
//    //レコード（行）の即時保存
//    do{
//      try viewContext.save()
//    }catch{
//    }
//    //配列再取得
//    //配列を空っぽにして、readで再び読み込み。
//    //reloadDataでリアルタイム表示を可能にさせる
//    //contentTitle = []
//    fetchedArray = []
//    read()
//    myTitle.reloadInputViews()
//    //myTitle.reloadData()
//  }//保存ボタンの閉じたぐ
//
//
//
//  //一つ前に戻る処理+保存処理！（機能していない）
//  @IBAction func backBtn(_ sender: UIBarButtonItem) {
//    let appD:AppDelegate = UIApplication.shared.delegate as! AppDelegate
//    let viewContext = appD.persistentContainer.viewContext
//    let Memo = NSEntityDescription.entity(forEntityName: "Memo", in: viewContext)
//    let newRecord = NSManagedObject(entity: Memo!, insertInto: viewContext)
//    newRecord.setValue(myTitle.text, forKey: "memo")
//    do{
//      try viewContext.save()
//    }catch{
//    }
//    fetchedArray = []
//    read()
//    myTitle.reloadInputViews()
//    //performSegue(withIdentifier: "next4", sender: nil)
//  }

//  //画面から非表示になる直前に呼ばれる！
//  //画面が戻るときに！
//  override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)

/// HTML形式で記述された文字列をNSAttributedStringに変換する
///
/// - Parameter text: 変換する文字列
/// - Returns: HTMLドキュメントに変換されたNSAttributedString
//func parseText2HTML(sourceText text: String) -> NSAttributedString? {
//
//  // 受け取ったデータをUTF-8エンコードする
//  let encodeData = text.data(using: String.Encoding.utf8, allowLossyConversion: true)
//
//  // 表示データのオプションを設定する
//  let attributedOptions : [String: AnyObject] = [
//    NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType as AnyObject,
//    NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue as AnyObject
//  ]
//
//  // 文字列の変換処理
//  var attributedString:NSAttributedString?
//  do {
//    attributedString = try NSAttributedString(
//
//      data: encodeData!,
//      options: attributedOptions,
//      documentAttributes: nil
//    )
//  } catch let e {
//    // 変換でエラーが出た場合
//  }
//  return attributedString
//}

