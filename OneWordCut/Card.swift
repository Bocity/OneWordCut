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
        imageContentView.frame = CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: 400)
        imageContentView.delegate = self as? ImageScrollerDelegate;
        self.view.addSubview(imageContentView);
        
        let n = realm.objects(Word.self).filter("kill == false") .count
        
        if n == 0 {
            return
        }
        
        var tmp2 = realm.objects(Word.self).filter("kill == false")
        
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
            cellOb.url = "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1547039767&di=8a819f6955c5dbca83977661f695ea4a&src=http://img.zcool.cn/community/01379359690c4ea8012193a337f7cb.JPG@1280w_1l_2o_100sh.jpg"
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
            cell = YKImageViewCell(frame: CGRect(x: 0, y: 64, width: 260, height: 300))
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
