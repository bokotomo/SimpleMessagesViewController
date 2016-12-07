//
//  ViewController.swift
//  SimpleMessagesViewController
//
//  Created by 福本 on 2016/11/27.
//  Copyright © 2016年 Fukumoto. All rights reserved.
//

import UIKit

class SimpleMessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate{

    let sampleMessages: [[String: Any]] = [["id":"1", "name":"tomo", "text":"よろしく！どこに住んでいるの？^^", "date":"2016/12/20 18:05:11"],
                                           ["id":"2", "name":"taro", "text":"Hello! I am living in Shinjuku but I will go to Asakusa next time!", "date":"2016/12/20 18:05:11"],
                                           ["id":"1", "name":"tomo", "text":"I live in Shibuya", "date":"2016/12/20 18:05:11"],
                                           ["id":"2", "name":"taro", "text":"いいね！今度遊ぼう！", "date":"2016/12/20 18:05:11"],
                                           ["id":"1", "name":"tomo", "text":"OK!", "date":"2016/12/20 18:05:11"],
                                           ["id":"2", "name":"taro", "text":"Good!", "date":"2016/12/20 18:05:11"],
                                           ["id":"1", "name":"tomo", "text":"ok", "date":"2016/12/20 18:05:11"],
                                           ["id":"2", "name":"taro", "text":"ok", "date":"2016/12/20 18:05:11"],
                                           ["id":"1", "name":"tomo", "text":"ok", "date":"2016/12/20 18:05:11"],
                                           ["id":"1", "name":"tomo", "text":"ok", "date":"2016/12/20 18:05:11"]]
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let textMessageHieght:CGFloat = 50
    let placeholderColor: UIColor = UIColor(red: 220/255, green:220/255, blue: 220/255, alpha: 1)
    var tableView: UITableView!
    var textMessageArea: UIView!
    var messageTextPlaceholder: UILabel!
    var messageTextSendButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(SimpleMessagesViewController.showKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SimpleMessagesViewController.hideKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SimpleMessagesViewController.dismissKeyBoard))
        view.addGestureRecognizer(tap)

        tableView = UITableView()
        tableView.frame = CGRect(
            x: 0,
            y: statusBarHeight,
            width: self.view.frame.width,
            height: self.view.frame.height - statusBarHeight - textMessageHieght
        )
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        tableView.separatorColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)

        textMessageArea = UIView()
        textMessageArea.frame = CGRect(
            x: 0,
            y: self.view.frame.height - textMessageHieght,
            width: self.view.frame.width,
            height: textMessageHieght
        )
        textMessageArea.backgroundColor = UIColor.white
        self.view.addSubview(textMessageArea)
        
        let messageTextView = UITextView()
        messageTextView.frame = CGRect(
            x: 5,
            y: 0,
            width: textMessageArea.frame.size.width - 60,
            height: textMessageArea.frame.size.height
        )
        messageTextView.delegate = self
        messageTextView.font = UIFont.systemFont(ofSize: 16)
        textMessageArea.addSubview(messageTextView)
    
        
        messageTextPlaceholder = UILabel()
        messageTextPlaceholder.frame = CGRect(
            x: 10,
            y: 0,
            width: messageTextView.frame.size.width,
            height: textMessageArea.frame.size.height
        )
        messageTextPlaceholder.text = "New Message"
        messageTextPlaceholder.font = UIFont.systemFont(ofSize: 16)
        messageTextPlaceholder.textColor = placeholderColor
        textMessageArea.addSubview(messageTextPlaceholder)

        messageTextSendButton = UIButton()
        messageTextSendButton.frame = CGRect(
            x: self.view.frame.size.width - 55,
            y: 10,
            width: 45,
            height: 30
        )
        messageTextSendButton.setTitle("Send", for: UIControlState())
        messageTextSendButton.backgroundColor = UIColor(red: 105/255, green:69/255, blue: 254/255, alpha: 1)
        messageTextSendButton.setTitleColor(UIColor.white, for: UIControlState())
        messageTextSendButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        messageTextSendButton.layer.cornerRadius = 5
        messageTextSendButton.addTarget(self, action: #selector(SimpleMessagesViewController.sendTextMessageButton(_:)), for: .touchUpInside)
        textMessageArea.addSubview(messageTextSendButton)
        
        let barLine = UIView()
        barLine.frame = CGRect(
                x: 0,
                y: 0,
                width: self.view.frame.width,
                height: 1
        )
        barLine.backgroundColor = UIColor(red: 230/255, green:230/255, blue: 230/255, alpha: 1)
        textMessageArea.addSubview(barLine)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        
        if sampleMessages[indexPath.row]["id"] as! String == "1" {
            let userText = UILabel()
            userText.frame = CGRect(
                x: 10,
                y: 10,
                width: self.view.frame.size.width - 80,
                height: 40
            )
            userText.text = "\(sampleMessages[indexPath.row]["text"]!)"
            userText.numberOfLines = 0
            userText.font = UIFont.systemFont(ofSize: 14)
            userText.sizeToFit()
            userText.textColor = UIColor(red: 40/255, green:40/255, blue: 40/255, alpha: 1)


            let textBackArea = UIView()
            textBackArea.frame = CGRect(
                x: 10,
                y: 5,
                width: userText.frame.size.width + 20,
                height: userText.frame.size.height + 20
            )
            textBackArea.backgroundColor = UIColor(red: 245/255, green:245/255, blue: 245/255, alpha: 1)
            textBackArea.layer.cornerRadius = 10
            cell.contentView.addSubview(textBackArea)
            textBackArea.addSubview(userText)
            
        }else{
            let userText = UILabel()
            userText.frame = CGRect(
                x: 10,
                y: 10,
                width: self.view.frame.size.width - 80,
                height: 40
            )
            userText.text = "\(sampleMessages[indexPath.row]["text"]!)"
            userText.numberOfLines = 0
            userText.font = UIFont.systemFont(ofSize: 14)
            userText.sizeToFit()
            userText.textColor = UIColor(red: 255/255, green:255/255, blue: 255/255, alpha: 1)

            let textBackArea = UIView()
            textBackArea.frame = CGRect(
                x: self.view.frame.size.width - userText.frame.size.width - 30,
                y: 5,
                width: userText.frame.size.width + 20,
                height: userText.frame.size.height + 20
            )
            textBackArea.backgroundColor = UIColor(red: 105/255, green:69/255, blue: 254/255, alpha: 1)
            textBackArea.layer.cornerRadius = 10
            cell.contentView.addSubview(textBackArea)
            textBackArea.addSubview(userText)
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleMessages.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //click cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let userText = UILabel()
        userText.frame = CGRect(
            x: 10,
            y: 10,
            width: self.view.frame.size.width - 50,
            height: 40
        )
        userText.text = "\(sampleMessages[indexPath.row]["text"]!)"
        userText.numberOfLines = 0
        userText.font = UIFont.systemFont(ofSize: 14)
        userText.sizeToFit()
        return userText.frame.size.height + 30
    }

    func dismissKeyBoard(){
        view.endEditing(true)
    }

    func showKeyboard(_ notification: Foundation.Notification) {

        let keyboardRect = ((notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        UIView.animate(withDuration: 0.25, animations: {
            
            self.tableView.frame.origin.y = -(keyboardRect?.size.height)!

            self.textMessageArea.frame.origin.y = self.view.frame.height - 50  - (keyboardRect?.size.height)!
           
        }, completion: nil)
        
    }

    func hideKeyboard(_ notification: Foundation.Notification) {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.tableView.frame.origin.y = self.statusBarHeight
            self.textMessageArea.frame.origin.y = self.view.frame.height - 50
        }, completion: nil)
    }

    func textViewDidChange(_ textView: UITextView) {
        
        if(textView.text.isEmpty == false){
            messageTextPlaceholder.isHidden = true
        }else{
            messageTextPlaceholder.isHidden = false
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if(textView.text.characters.count > 750){
            return false
        }
        if( text == "\n"){
            
        }
        
        return true
    }

    func sendTextMessageButton(_ button: UIButton!) {

    }

}
