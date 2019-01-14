//
//  ViewController.swift
//  OneWordCut
//
//  Created by 郝进 on 2019/1/8.
//  Copyright © 2019年 Bocity. All rights reserved.
//

import UIKit
import RealmSwift
import CircleMenu

class Word: Object{
    @objc dynamic var id = 0
    @objc dynamic var english = ""
    @objc dynamic var chinese = ""
    @objc dynamic var kill = false
    @objc dynamic var isdown = false
    @objc dynamic var json = ""

}

extension UIColor {
    static func color(_ red: Int, green: Int, blue: Int, alpha: Float) -> UIColor {
        return UIColor(
            colorLiteralRed: Float(1.0) / Float(255.0) * Float(red),
            green: Float(1.0) / Float(255.0) * Float(green),
            blue: Float(1.0) / Float(255.0) * Float(blue),
            alpha: alpha)
    }
}



class ViewController: UIViewController ,CircleMenuDelegate{
    
    let items: [(icon: String, color: UIColor)] = [
        ("sso", UIColor(red:0.19, green:0.57, blue:1, alpha:1)),
        ("Plus", UIColor(red:0.22, green:0.74, blue:0, alpha:1)),
        ("icon_search", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1)),
        ("Mine", UIColor(red:0.51, green:0.15, blue:1, alpha:1)),
        ("nearby-btn", UIColor(red:1, green:0.39, blue:0, alpha:1)),
        ]
    
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
        
        print(puppies.count)
        
        let button = CircleMenu(
                    frame: CGRect(x: 177, y: self.view.bounds.size.height - 230, width: 80, height: 80),
                    normalIcon:"icon_menu",
                    selectedIcon:"icon_close",
                    buttonsCount: 4,
                    duration: 0.5,
                    distance: 150)
                button.backgroundColor = UIColor.lightGray
                button.delegate = self
                button.layer.cornerRadius = button.frame.size.width / 2.0
                view.addSubview(button)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
        button.backgroundColor = items[atIndex].color
        
        button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
        
        // set highlited image
        let highlightedImage  = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
        button.setImage(highlightedImage, for: .highlighted)
        button.tintColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
        print("button will selected: \(atIndex)")
    }
    
    func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
        let sb = UIStoryboard(name:"Main", bundle:nil)
        if atIndex ==  0{
            let vc = sb.instantiateViewController(withIdentifier: "Card") as! Card
            self.present(vc, animated:true, completion:nil)
         
        }else if atIndex == 1 {
            let vc = sb.instantiateViewController(withIdentifier: "AddWord") as! addWord
            self.present(vc, animated:true, completion:nil)
        }else if atIndex == 2 {
            let vc = sb.instantiateViewController(withIdentifier: "WT") as! WordsTable
            self.present(vc, animated:true, completion:nil)
        }else {

            let vc = sb.instantiateViewController(withIdentifier: "Mine") as! ViewController2
            self.present(vc, animated:true, completion:nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

