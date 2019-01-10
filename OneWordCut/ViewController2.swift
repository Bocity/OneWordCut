//
//  ViewController2.swift
//  OneWordCut
//
//  Created by 郝进 on 2019/1/8.
//  Copyright © 2019年 Bocity. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController2: UIViewController {

    @IBOutlet weak var NumOfTotal: UILabel!
    @IBOutlet weak var NumOfKilledLable: UILabel!
    @IBAction func exitToHere(sender : UIStoryboardSegue){
        
    }
    
    @IBAction func ExitApp(_ sender: UIButton) {
        exit(0)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updated()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updated()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updated(){
        let realm = try! Realm()
        let puppies = realm.objects(Word.self).count
        let puppies2 = realm.objects(Word.self).filter("kill = true")
        NumOfTotal.text = String(puppies)
        NumOfKilledLable.text = String(puppies2.count)
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
