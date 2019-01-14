//
//  Card.swift
//  OneWordCut
//
//  Created by 郝进 on 2019/1/8.
//  Copyright © 2019年 Bocity. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

class Card: UIViewController {
    let realm = try! Realm()
    
    let imageContentView :YKIMageContentView = YKIMageContentView()
    var dataSrouce:[YKCellObject]!
    var tmp = [Word]()
    var ans = 0;
    override func viewDidLoad() {
        ans = 0
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageContentView.frame = CGRect(x: 0, y: 20, width: self.view.bounds.size.width, height: 600)
        imageContentView.backgroundColor = UIColor.clear
        imageContentView.delegate = self as? ImageScrollerDelegate;
        self.view.addSubview(imageContentView);
        
        let n = realm.objects(Word.self).filter("kill == false") .count
        
        if n == 0 {
            return
        }
        
        let tmp2 = realm.objects(Word.self).filter("kill == false")
        
        for i in 0...n-1{
            tmp.append(tmp2[i])
        }
        
        dataSrouce = createDataSource()
        imageContentView.reloadView();
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createDataSource() -> [YKCellObject] {
        
        var tDataSrouce = [YKCellObject]()
        for url in tmp{
            let cellOb = YKCellObject()
            cellOb.url = "https://s2.ax1x.com/2019/01/13/FvT87q.png"
            cellOb.title = "\(url.english)    \(url.chinese)"
            tDataSrouce.append(cellOb);
        }
        
        return tDataSrouce;
    }
}

extension Card:ImageScrollerDelegate{
    func numerOfCells() -> Int {
        return dataSrouce.count
    }
    
    func cellForRowAtIndex(index: NSInteger,imageContentView:YKIMageContentView) -> YKImageViewCell {
        var cell = imageContentView.dqueueReuseCell()
        if cell == nil {
            cell = YKImageViewCell(frame: CGRect(x: 0, y: 20, width: 320, height: 450))
        }
        
        let proerpty = dataSrouce[index];
        cell?.titleLabel.text = dataSrouce[index].title;
        cell?.imageView.sd_setImage(with: URL(string: proerpty.url!)
            , completed: { (image, error, type, url) in
                if error != nil{
                    print("error:\(String(describing: error?.localizedDescription))")
                }
        })
        
        return cell!
    }
    
    func didSelectedCellAtIndex(index: NSInteger, cell: YKImageViewCell) {
        print(index)
        
    }
    
    func didSwipToLeft(index: NSInteger) {
        let dog = realm.objects(Word.self).filter("id ==  \(tmp[ans].id)").last
        print("\(ans)L")
        try! realm.write {
            dog?.kill = true
        }

        ans = ans + 1
    }
    
    func didSwipToRight(index: NSInteger) {
        
        let dog = realm.objects(Word.self).filter("id == \(tmp[ans].id)").last
        print("\(ans)R")
        try! realm.write {
            dog?.kill = false
        }
        ans = ans + 1

    }
    
}
