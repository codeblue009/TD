//  ViewController.swift
//  TD assignment
//
//  Created by Sacha Sukhdeo on 2018-10-20.
//  Copyright © 2018 Sacha Sukhdeo. All rights reserved.

import UIKit
import SwiftyJSON

class TopicsListVC: UIViewController {

    var topics: Dictionary<String, [JSON]>?
    var names: [String]?
    var previousIndexPath: IndexPath?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadTopics()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.navigationBar.barTintColor = .orange
    }

    func loadTopics() {
        TopicsListData().getTopics(completion: { topicsDict, topicsNames in
            self.topics = topicsDict
            self.names = topicsNames
            self.tableView.reloadData()
        })
    }
    
    @IBAction func refresh(_ sender: Any) {
        loadTopics()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail",
            let indexPath = self.tableView.indexPathForSelectedRow {
            previousIndexPath = indexPath
            if let link = topics?[names![indexPath.section]]?[indexPath.row]["FirstURL"].string {
                (segue.destination as! DetailVC).link = URL(string: link)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension TopicsListVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return names?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let name = names?[section] else { return 0}
        return topics?[name]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! TopicsTableViewCell).imageArticle.image = nil
        (cell as! TopicsTableViewCell).imageArticle.link = nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UITableViewHeaderFooterView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = .orange
        headerView.contentView.backgroundColor = .orange
        return headerView
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let name = names?[section] else { return ""}
        return name
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let names = names,
            names.count > indexPath.section,
            let topic = topics?[names[indexPath.section]],
            let text = topic[indexPath.row]["Text"].string,
            let topicsCell = cell as? TopicsTableViewCell {
                topicsCell.title.text = text

                if let imageLink = topic[indexPath.row]["Icon"]["URL"].string,
                    let imageURL = URL(string: imageLink) {
                    topicsCell.imageArticle.link = imageURL
                }
                else {
                    topicsCell.imageArticle.frame = CGRect()
                }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowDetail", sender: self)
    }
    
}
