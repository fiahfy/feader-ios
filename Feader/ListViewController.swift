//
//  ListViewController.swift
//  Feader
//
//  Created by fiahfy on 2017/12/04.
//  Copyright © 2017年 fiahfy. All rights reserved.
//

import UIKit
import RxAlamofire
import RxSwift

class ListViewController: UITableViewController {
    
    private var entries = [RSS.Feed.Entry]()
    
    private struct Identifier {
        static let BasicCell = "BasicCell"
        static let WebViewController = "WebViewController"
    }
    
    private let rssUrlString = "https://fiahfy.blogspot.com/feeds/posts/summary?alt=json"

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        load()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        switch identifier {
        case Identifier.WebViewController:
            guard let url = sender as? URL, let controller = segue.destination as? WebViewController else {
                return
            }
            controller.url = url
        default:
            break
        }
    }
    
    //MARK: IBAction

    @IBAction func refresh(_ sender: UIRefreshControl) {
        load()
    }
    
    //MARK: Private
    
    private func load() {
        _ = requestData(.get, rssUrlString)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (response, data) in
                guard let `self` = self, let rss = try? JSONDecoder().decode(RSS.self, from: data) else {
                    return
                }
                self.entries = rss.feed.entries
                self.tableView.reloadData()
                }, onError: nil, onCompleted: { [weak self] in
                    self?.refreshControl?.endRefreshing()
                }, onDisposed: nil)
    }
}

//MARK: - UITableViewDataSource

extension ListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.BasicCell) ?? UITableViewCell()
        let entry = entries[indexPath.row]
        cell.textLabel?.text = entry.title.text
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = entries[indexPath.row]
        guard let permalink = entry.permalink, let url = URL(string: permalink) else {
            return
        }
        performSegue(withIdentifier: Identifier.WebViewController, sender: url)
    }
}
