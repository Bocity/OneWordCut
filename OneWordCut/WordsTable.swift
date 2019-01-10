//
//  ViewController.swift
//  TableViewSwift
//
//  Created by lisonglin on 14/04/2017.
//  Copyright © 2017 lisonglin. All rights reserved.
//

import UIKit
import RealmSwift

class WordsTable: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var dataSource:NSMutableArray = [] 
    var tableView: UITableView = UITableView()
    var click = Word()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let n = realm.objects(Word.self) .count
        self.title = "TableView"
        let tmp = realm.objects(Word.self)
        for i in 0...n-1 {
            dataSource.add(tmp[i])
        }
        
        tableView = UITableView(frame:CGRect(x:0,y:20,width:self.view.frame.size.width,height:self.view.frame.size.height*2/3), style:UITableViewStyle.plain)
        tableView.tableFooterView = UIView()
        self.view .addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    //tableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "cellId"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        if (cell == nil) {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellId)
        }
        let x = self.dataSource[indexPath.row] as! Word
        cell?.textLabel?.text = "\(x.english)                           \(x.chinese)"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            //删除数据源当前的数据
            
           let x = self.dataSource[indexPath.row] as! Word
            let y = realm.objects(Word.self).filter("id = \(x.id)")
            print(y)
            try! realm.write {
                realm.delete(y)
            }
            self.dataSource .removeObject(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
    @IBAction func exitToHere(sender : UIStoryboardSegue){
        
    }
    //点击
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let x = self.dataSource[indexPath.row] as! Word
        click = x
        print(click)
        tableView .deselectRow(at: indexPath, animated: true)
        var sb = UIStoryboard(name:"Main", bundle:nil)
        var vc = sb.instantiateViewController(withIdentifier: "VC") as! DetailViewController//
        vc.id = x.id
        self.present(vc, animated:true, completion:nil)
        //self.performSegue(withIdentifier: "VC", sender:nil)
        
    }

    
    
}

