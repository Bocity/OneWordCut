//
//  addWord.swift
//  OneWordCut
//
//  Created by 郝进 on 2019/1/8.
//  Copyright © 2019年 Bocity. All rights reserved.
//

import UIKit
import RealmSwift
class addWord: UIViewController {

    @IBOutlet weak var AddResult: UILabel!
    @IBOutlet weak var EnglishText: UITextField!
    @IBOutlet weak var ChineseText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func KeyBoard(_ sender: Any) {
        EnglishText.resignFirstResponder()
    }
    
    @IBAction func KeyBoard2(_ sender: Any) {
        ChineseText.resignFirstResponder()
    }
    
    @IBAction func AddWord(_ sender: UIButton) {
        let realm = try! Realm() 
        let pup = realm.objects(Word.self).max(ofProperty: "id") as Int?
        let myWord = Word()
        myWord.chinese = ChineseText.text!
        myWord.english = EnglishText.text!
        myWord.id = Int(pup!) + 1
        myWord.kill = false
        myWord.isdown = false
        myWord.json = ""
        EnglishText.text = ""
        ChineseText.text = ""
        var cha:String = "english == \"" + myWord.english + "\""
        if (realm.objects(Word.self).filter(cha).count == 0){
            AddResult.text = "添加成功！~"
            try! realm.write {
                realm.add(myWord)
            }
        }else{
            AddResult.text = "这个词你已经添加过，请确认！"
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
