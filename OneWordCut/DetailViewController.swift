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
import MediaPlayer
import RAMPaperSwitch

class DetailViewController: UIViewController {
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
    
    @IBOutlet weak var textview: UITextView!


    @IBOutlet weak var EA: UILabel!
    @IBOutlet weak var AA: UILabel!
    @IBOutlet weak var Judge: UISwitch!
    @IBOutlet weak var paperSwitch: RAMPaperSwitch!


    @IBAction func PlayE(_ sender: Any) {
        print(ES)
        let url = URL(string:ES)
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem!)
        player!.play()
    }

    @IBAction func PlayA(_ sender: Any) {
        print(AS)
        let url = URL(string:AS)
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem!)
        player!.play()
    }
    let realm = try! Realm()
    var id:Int = 0;
    var engli:String = ""
    var AS:String = ""
    var ES:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let x = realm.objects(Word.self).filter("id == \(id)").last
        engli = (realm.objects(Word.self).filter("id == \(id)").last?.english)!
        Judge.setOn((x?.kill)!, animated: true)
 
//            print(response.request)  // 原始的URL请求
//            print(response.response) // HTTP URL响应
//            print(response.data)     // 服务器返回的数据
//            print(response.result)   // 响应序列化结果，在这个闭包里，存储的是JSON数据
            if (self.realm.objects(Word.self).filter("id == \(id)").last?.isdown == true){
                let json = JSON.init(parseJSON:(self.realm.objects(Word.self).filter("id == \(id)").last?.json)!)
                //JSON
                self.textview.text = json["defs"][0]["pos"].stringValue + json["defs"][0]["def"].stringValue + "\n\n" +  json["defs"][1]["pos"].stringValue + json["defs"][1]["def"].stringValue + "\n\n" + json["defs"][2]["pos"].stringValue +   json["defs"][2]["def"].stringValue + "\n\n" +  json["defs"][3]["pos"].stringValue + json["defs"][3]["def"].stringValue
                self.EA.text = "[" + json["pronunciation"]["BrE"].stringValue + "]"
                self.AA.text = "[" + json["pronunciation"]["AmE"].stringValue + "]"
                self.AS = json["pronunciation"]["AmEmp3"].stringValue
                self.ES = json["pronunciation"]["BrEmp3"].stringValue
                print("cu2o")
            }else{
                let url = "https://xtk.azurewebsites.net/BingDictService.aspx?Word=" + (x?.english)!
                Alamofire.request(url).responseJSON { response in
                let json = JSON(response.result.value)
                self.textview.text = json["defs"][0]["pos"].stringValue + json["defs"][0]["def"].stringValue + "\n\n" +  json["defs"][1]["pos"].stringValue + json["defs"][1]["def"].stringValue + "\n\n" + json["defs"][2]["pos"].stringValue +   json["defs"][2]["def"].stringValue + "\n\n" +  json["defs"][3]["pos"].stringValue + json["defs"][3]["def"].stringValue
                self.EA.text = "[" + json["pronunciation"]["BrE"].stringValue + "]"
                self.AA.text = "[" + json["pronunciation"]["AmE"].stringValue + "]"
                    self.AS = json["pronunciation"]["AmEmp3"].stringValue
                    self.ES = json["pronunciation"]["BrEmp3"].stringValue
                print(json)
                let dog = self.realm.objects(Word.self).filter("id ==  \(self.id)").last
                try! self.realm.write {
                    dog?.json = json.rawString(String.Encoding.utf8)!
                    dog?.isdown = true
                }
            }
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
