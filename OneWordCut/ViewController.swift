//
//  ViewController.swift
//  OneWordCut
//
//  Created by 郝进 on 2019/1/8.
//  Copyright © 2019年 Bocity. All rights reserved.
//

import UIKit
import RealmSwift  

class Word: Object{
    @objc dynamic var id = 0
    @objc dynamic var english = ""
    @objc dynamic var chinese = ""
    @objc dynamic var kill = false

}



class ViewController: UIViewController {
    
    @IBAction func exitToHere(sender : UIStoryboardSegue){
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let realm = try! Realm() 
        print(realm.configuration.fileURL!)
        
        let puppies = realm.objects(Word.self).filter("id < 1")
        var pup = realm.objects(Word.self).max(ofProperty: "id") as Int?
        
        if (pup==nil){
            pup = 0
        }
        
        let myWord = Word()
        myWord.chinese = "狗"
        myWord.english = "dog"
        myWord.kill = true
        myWord.id = Int(pup!) + 1
        
        try! realm.write {
            realm.add(myWord)
        }
        
        print(puppies.count)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

