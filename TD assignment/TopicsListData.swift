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
    
    func getTopics(completion: @escaping ([JSON]) -> Void) {
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json["RelatedTopics"].arrayValue)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
