//
//  MainViewController.swift
//  SimpleMessagesViewController
//
//  Created by 福本 on 2016/11/30.
//  Copyright © 2016年 Fukumoto. All rights reserved.
//
import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.height

    @IBOutlet weak var TableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "MessagePage"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Ok")
        let secondViewController = SimpleMessagesViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

}

