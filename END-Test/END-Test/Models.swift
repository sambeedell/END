//
//  Models.swift
//  END-Test
//
//  Created by Sam Beedell on 03/04/2018.
//  Copyright © 2018 Sam Beedell. All rights reserved.
//

import UIKit

class ItemCategory: NSObject {
    var name: String?
    var items: [Item]?
    var type: String? // if large, is brand . if extralarge is title
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "items" {
            items = [Item]()
            for dict in value as! [[String:AnyObject]] {
                let item = Item()
                item.setValuesForKeys(dict)
                items?.append(item)
            }
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    static func fetchItems(completionHandler: @escaping ([ItemCategory]) -> ()) {
        let urlString = "https://raw.githubusercontent.com/sambeedell/END/master/end.json"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
                if let e = error {
                    print(e)
                    return
                }
                
                do {
                    if let json = try(JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as? [String:AnyObject] {
                        if let contents = json["contents"] as? [String:AnyObject] {
                            if let categories = contents["categories"] as? [[String:AnyObject]] {
                                var itemCategories = [ItemCategory]()
                                for dict in categories {
                                    let itemCategory = ItemCategory()
                                    itemCategory.setValuesForKeys(dict)
                                    itemCategories.append(itemCategory)
                                }
                                DispatchQueue.main.async {
                                    completionHandler(itemCategories)
                                }
                            }
                        }
                    }
                } catch let err {
                    print(err)
                }
                
            }.resume()
        }
       
    }
}

@objcMembers
class Item: NSObject {
    var id: NSNumber?
    var title: String?
    var image: String?
    var colour:String?
    var price: String?
}
