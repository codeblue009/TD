//  ViewController.swift
//  TD assignment
//
//  Created by Sacha Sukhdeo on 2018-10-20.
//  Copyright © 2018 Sacha Sukhdeo. All rights reserved.

import UIKit
import SwiftyJSON

class TopicsListVC: UIViewController {

    var topics: [JSON]?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        TopicsListData().getTopics(completion: { json in
            self.topics = json
            self.tableView.reloadData()
            print(self.topics)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension TopicsListVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topics?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let topics = topics,
            topics.count > indexPath.row {
            let topic = topics[indexPath.row]
            cell.textLabel?.text = topic["Text"].string
        }
    }
    
}
