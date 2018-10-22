//  TopicsListData.swift
//  TD assignment
//
//  Created by Sacha Sukhdeo on 2018-10-21.
//  Copyright © 2018 Sacha Sukhdeo. All rights reserved.

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class TopicsListData {
    
    let url = "https://api.duckduckgo.com/?q=apple&format=json&pretty=1"
    
    func getTopics(completion: @escaping (Dictionary<String, [JSON]>, [String]) -> Void) {
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let topics = json["RelatedTopics"].arrayValue
                var topicsDict: Dictionary<String, [JSON]> = ["Apple": []]
                var topicsTitles: [String] = ["Apple"]
                var maxTopics = 20
                topics.forEach({ item in
                    if maxTopics > 0 {
                        if item["Text"].string != nil {
                            topicsDict["Apple"]?.append(item)
                            maxTopics -= 1
                        } else if let name = item["Name"].string {
                            if topicsDict[name] == nil {
                                topicsTitles.append(name)
                                topicsDict[name] = item["Topics"].arrayValue
                                maxTopics -= item["Topics"].arrayValue.count
                            }
                        }
                    }
                })
                completion(topicsDict, topicsTitles)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
