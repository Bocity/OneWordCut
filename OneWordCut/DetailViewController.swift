//
//  DetailViewController.swift
//  OneWordCut
//
//  Created by 郝进 on 2019/1/9.
//  Copyright © 2019年 Bocity. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {

    
    @IBOutlet weak var textview: UITextView!

    @IBOutlet weak var Judge: UISwitch!
    

    let realm = try! Realm()
    var id:Int = 0;
    var engli:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let x = realm.objects(Word).filter("id == \(id)").last
        engli = (realm.objects(Word).filter("id == \(id)").last?.english)!
        Judge.setOn((x?.kill)!, animated: true)
        let url = "https://xtk.azurewebsites.net/BingDictService.aspx?Word=" + (x?.english)!
        Alamofire.request(url).responseJSON { response in
//            print(response.request)  // 原始的URL请求
//            print(response.response) // HTTP URL响应
//            print(response.data)     // 服务器返回的数据
//            print(response.result)   // 响应序列化结果，在这个闭包里，存储的是JSON数据
            
            let json = JSON(response.result.value)
            print(json)
            self.textview.text = json["defs"][0]["pos"].stringValue + json["defs"][0]["def"].stringValue + "\n\n" +  json["defs"][1]["pos"].stringValue + json["defs"][1]["def"].stringValue + "\n\n" + json["defs"][2]["pos"].stringValue +   json["defs"][2]["def"].stringValue + "\n\n" +  json["defs"][3]["pos"].stringValue + json["defs"][3]["def"].stringValue
        }
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Change(_ sender: Any) {
        print(id)
        let realm = try! Realm()
        let dog = realm.objects(Word.self).filter("id ==  \(id)").last
        try! realm.write {
            dog?.kill = Judge.isOn
        }

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
