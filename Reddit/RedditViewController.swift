//
//  RedditViewController.swift
//  Reddit
//
//  Created by Andrew Carter on 8/30/19.
//  Copyright © 2019 AshleyCo. All rights reserved.
//

import UIKit
import SafariServices

class RedditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet private var tableView: UITableView!
    private var posts: [Post] = []
    private let api = API()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        reloadPosts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        tableView.flashScrollIndicators()
    }
    
    // MARK: - Instance Methods
    
    private func makeHomepageRquest() -> URLRequest {
        let config = AppConfig.shared
        var components = URLComponents()
        components.port = config.apiPort
        components.host = config.apiHost
        components.scheme = "https"
        components.path = "/.json"
        
        let url = components.url!
        let request = URLRequest(url: url)
        
        return request
    }
    
    private func reloadPosts() {
        let request = makeHomepageRquest()
        
        api.perform(request: request) { (result: PostResult) in
            DispatchQueue.main.async {
                switch result {
                case .success(let wrapper):
                    self.posts = wrapper.data.children.map({ $0.data })
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    let controller = UIAlertController(title: "Error",
                                                       message: error.localizedDescription,
                                                       preferredStyle: .alert)
                    self.present(controller, animated: true)
                    break
                }
            }
        }
    }
    
    private func setupTableView() {
        tableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.identifier)
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier,
                                                 for: indexPath) as! PostTableViewCell
        
        let post = posts[indexPath.row]
        cell.titleLabel.text = post.title
        
        return cell
    }

    // MARK: - UITableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
       
        guard let url = URL(string: post.url) else {
            return
        }
        
        let controller = SFSafariViewController(url: url)
        present(controller, animated: true)
    }
    
}

