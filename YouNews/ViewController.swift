//
//  ViewController.swift
//  YouNews
//
//  Created by Jianhao Huang on 2017/11/30.
//  Copyright © 2017年 Jianhao Huang. All rights reserved.
//

import UIKit
import DJKFlipper

class ViewController: UIViewController, DJKFlipperDataSource {
    @IBOutlet weak var flipView: DJKFlipperView!
    
    var flipperViewArray: [UIViewController] = []
    {
        didSet
        {
            flipView.reload()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flipView.dataSource = self
        
//        getList().forEach {
//            let page = PageViewController(nibName: "PageViewController", bundle: nil)
//            page.view.frame = self.view.bounds
//            page.videoPlayer.loadVideoID($0.id)
//            page.view.layoutSubviews()
//
//            flipperViewArray.append(page)
//        }
//
        let page1 = PageViewController(nibName: "PageViewController", bundle: nil)
        page1.view.frame = self.view.bounds
        page1.videoPlayer.loadVideoID("o7IKI9hqNnM")
        page1.view.layoutSubviews()

        let page2 = PageViewController(nibName: "PageViewController", bundle: nil)
        page2.view.frame = self.view.bounds
        page2.videoPlayer.loadVideoID("ryHuDh9PYmw")
        page2.view.layoutSubviews()

        flipperViewArray += [page1,page2]
        
        
        
        
        
    }

    func getList() -> [List] {
        var lists = [List]()
        
        if let urlStr = "https://181v29xxme.execute-api.us-west-2.amazonaws.com/prod/api/v1/list/0".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                if let data = data, let listResults = try? decoder.decode([List].self, from: data) {
                    
                    lists = listResults
//                    for row in listResults {
//                        print(row)
//                    }
                } else {
                    print("error")
                }
            }
            
            
            task.resume()
        }
        
        return lists
    }
    
    func numberOfPages(_ flipper: DJKFlipperView) -> NSInteger {
        return flipperViewArray.count
    }

    func viewForPage(_ page: NSInteger, flipper: DJKFlipperView) -> UIView {
        return flipperViewArray[page].view
    }
    
}

struct List: Codable {
        var id: String
        var title: String
        var owner: String
        var time: String
}


