//
//  ViewController.swift
//  SimpleMessagesViewController
//
//  Created by 福本 on 2016/11/27.
//  Copyright © 2016年 Fukumoto. All rights reserved.
//

import UIKit

class SimpleMessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate{

    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let sampleMessages = ["ref", "lplp", "fojfiew"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SimpleMessagesViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)

        let tableView = UITableView()
        tableView.frame = CGRect(
            x: 0,
            y: statusBarHeight,
            width: self.view.frame.width,
            height: self.view.frame.height - statusBarHeight
        )
        
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)

        let textMessageArea = UIView()
        textMessageArea.frame = CGRect(
            x: 0,
            y: self.view.frame.height - 60,
            width: self.view.frame.width,
            height: 60
        )
        self.view.addSubview(textMessageArea)
        
        let messageTextView = UITextView()
        messageTextView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.width,
            height: textMessageArea.frame.size.height
        )
        messageTextView.delegate = self
        messageTextView.font = UIFont.systemFont(ofSize: 16)
        textMessageArea.addSubview(messageTextView)
    
        
        let messageTextPlaceholder = UILabel()
        messageTextPlaceholder.frame = CGRect(
            x: 10,
            y: 0,
            width: self.view.frame.width - 20,
            height: textMessageArea.frame.size.height
        )
        messageTextPlaceholder.text = "メッセージを入力"
        messageTextPlaceholder.font = UIFont.systemFont(ofSize: 16)
        messageTextPlaceholder.textColor = UIColor(red: 230/255, green:230/255, blue: 230/255, alpha: 1)
        textMessageArea.addSubview(messageTextPlaceholder)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "\(sampleMessages[indexPath.row])"
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleMessages.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //click cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }

    func DismissKeyboard(){
        view.endEditing(true)
    }
}

