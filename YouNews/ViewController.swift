//
//  ViewController.swift
//  YouNews
//
//  Created by Jianhao Huang on 2017/11/30.
//  Copyright © 2017年 Jianhao Huang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        if let urlStr = "http://127.0.0.1:5000/".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
//            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
////                print(String(data: data!, encoding: .utf8)!)
//                let decoder = JSONDecoder()
//                if let data = data, let songResults = try? decoder.decode(ListResults.self, from: data) {
//                    for song in songResults.results {
//                        print(song)
//                    }
//                } else {
//                    print("error")
//                }
//            }
//            task.resume()
//        }
        
        
        if let path = Bundle.main.path(forResource: "list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                print(jsonResult)
            } catch {
                // handle error
            }
        }
    }


}
struct ListResults: Codable {
    struct List: Codable {
        var id: String
        var title: String
        var owner: String
        var time: String
    }
    var results: [List]
}



