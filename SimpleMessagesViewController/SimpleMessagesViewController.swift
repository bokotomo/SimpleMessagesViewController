//
//  ViewController.swift
//  SimpleMessagesViewController
//
//  Created by 福本 on 2016/11/27.
//  Copyright © 2016年 Fukumoto. All rights reserved.
//

import UIKit

class SimpleMessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate{

    let sampleMessages: [[String: Any]] = [["id":"1", "type":"text", "user_img_url":"https://tomo.syo.tokyo/openimg/shibuya.jpg", "name":"tomo", "contents":"Hello,where do you live?", "date":"2016/12/20 18:05:11"],
                                           ["id":"2", "type":"text", "user_img_url":"https://tomo.syo.tokyo/openimg/car.jpg", "name":"taro", "contents":"Hello! I'm living in Shinjuku but I will go to Asakusa next time!", "date":"2016/12/20 18:05:11"],
                                           ["id":"1", "type":"text", "user_img_url":"https://tomo.syo.tokyo/openimg/shibuya.jpg", "name":"tomo", "contents":"I live in Shibuya", "date":"2016/12/20 18:05:11"],
                                           ["id":"2", "type":"text", "user_img_url":"https://tomo.syo.tokyo/openimg/car.jpg", "name":"taro", "contents":"Let's play next time:)", "date":"2016/12/20 18:05:11"],
                                           ["id":"1", "type":"text", "user_img_url":"https://tomo.syo.tokyo/openimg/shibuya.jpg", "name":"tomo", "contents":"OK!", "date":"2016/12/20 18:05:11"],
                                           ["id":"2", "type":"text", "user_img_url":"https://tomo.syo.tokyo/openimg/car.jpg", "name":"taro", "contents":"Do you want something to eat?", "date":"2016/12/20 18:05:11"],
                                           ["id":"1", "type":"text", "user_img_url":"https://tomo.syo.tokyo/openimg/shibuya.jpg", "name":"tomo", "contents":"Udon!", "date":"2016/12/20 18:05:11"],
                                           ["id":"2", "type":"text", "user_img_url":"https://tomo.syo.tokyo/openimg/car.jpg", "name":"taro", "contents":"How is this kind of?", "date":"2016/12/20 18:05:11"],
                                           ["id":"2", "type":"image", "user_img_url":"https://tomo.syo.tokyo/openimg/car.jpg", "name":"taro", "contents":"https://tomo.syo.tokyo/openimg/udon.png", "date":"2016/12/20 18:05:11"],
                                           ["id":"1", "type":"text", "user_img_url":"https://tomo.syo.tokyo/openimg/shibuya.jpg", "name":"tomo", "contents":"nice!", "date":"2016/12/20 18:05:11"]]
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let textMessageHieght: CGFloat = 50
    let imageMessageSize: CGFloat = 200
    let userImgSize: CGFloat = 35
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
            y: 7.5,
            width: textMessageArea.frame.size.width - 60,
            height: textMessageArea.frame.size.height - 7.5
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
        let messageType: String = sampleMessages[indexPath.row]["type"] as! String

        if sampleMessages[indexPath.row]["id"] as! String == "1" {
            if messageType == "text" {
                let userText = UILabel()
                userText.frame = CGRect(
                    x: 8.75,
                    y: 8.75,
                    width: self.view.frame.size.width - 100 - userImgSize,
                    height: 40
                )
                userText.text = "\(sampleMessages[indexPath.row]["contents"]!)"
                userText.numberOfLines = 0
                userText.font = UIFont.systemFont(ofSize: 14)
                userText.sizeToFit()
                userText.textColor = UIColor(red: 40/255, green:40/255, blue: 40/255, alpha: 1)

                let textBackArea = UIView()
                textBackArea.frame = CGRect(
                    x: userImgSize + 10,
                    y: 5,
                    width: userText.frame.size.width + 17.5,
                    height: userText.frame.size.height + 17.5
                )
                textBackArea.backgroundColor = UIColor(red: 245/255, green:245/255, blue: 245/255, alpha: 1)
                textBackArea.layer.cornerRadius = 10
                cell.contentView.addSubview(textBackArea)
                textBackArea.addSubview(userText)
                
                let imageview_area = UIView(frame: CGRect(x: 5, y: 5 + textBackArea.frame.size.height - userImgSize , width: userImgSize, height: userImgSize))
                let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: userImgSize, height: userImgSize))
                let url_str: String = sampleMessages[indexPath.row]["user_img_url"] as! String
                ServerProc().async_img(url: url_str, funcs: {(img: UIImage) in
                    imageview_area.layer.masksToBounds = true
                    imageview_area.layer.cornerRadius = self.userImgSize/2
                    imageview.image = img
                    
                    imageview.frame = CGRect(x: 0,y: 0 ,width: self.userImgSize,height: self.userImgSize)
                    cell.contentView.addSubview(imageview_area)
                    imageview_area.addSubview(imageview)
                })

            }else if messageType == "image" {
            
            }
            
        }else{
            
            if messageType == "text" {
                let userText = UILabel()
                userText.frame = CGRect(
                    x: 8.75,
                    y: 8.75,
                    width: self.view.frame.size.width - 100 - userImgSize,
                    height: 40
                )
                userText.text = "\(sampleMessages[indexPath.row]["contents"]!)"
                userText.numberOfLines = 0
                userText.font = UIFont.systemFont(ofSize: 14)
                userText.sizeToFit()
                userText.textColor = UIColor(red: 255/255, green:255/255, blue: 255/255, alpha: 1)

                let textBackArea = UIView()
                textBackArea.frame = CGRect(
                    x: self.view.frame.size.width - userText.frame.size.width - 27.5 - userImgSize,
                    y: 5,
                    width: userText.frame.size.width + 17.5,
                    height: userText.frame.size.height + 17.5
                )
                textBackArea.backgroundColor = UIColor(red: 105/255, green:69/255, blue: 254/255, alpha: 1)
                textBackArea.layer.cornerRadius = 10
                cell.contentView.addSubview(textBackArea)
                textBackArea.addSubview(userText)
                
                let imageview_area = UIView(frame: CGRect(x: self.view.frame.size.width - userImgSize - 5, y: 5 + textBackArea.frame.size.height - userImgSize , width: userImgSize, height: userImgSize))
                let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: userImgSize, height: userImgSize))
                let url_str: String = sampleMessages[indexPath.row]["user_img_url"] as! String
                ServerProc().async_img(url: url_str, funcs: {(img: UIImage) in
                    imageview_area.layer.masksToBounds = true
                    imageview_area.layer.cornerRadius = self.userImgSize/2
                    imageview.image = img
                    
                    imageview.frame = CGRect(x: 0,y: 0 ,width: self.userImgSize,height: self.userImgSize)
                    cell.contentView.addSubview(imageview_area)
                    imageview_area.addSubview(imageview)
                })
            }else if messageType == "image" {
                
                let imageview_area2 = UIView(frame: CGRect(x: self.view.frame.size.width - 10 - userImgSize - imageMessageSize, y: 5, width: imageMessageSize, height: imageMessageSize))
                let imageview2 = UIImageView(frame: CGRect(x: 0, y: 0, width: imageMessageSize, height: imageMessageSize))
                let url_str2: String = sampleMessages[indexPath.row]["contents"] as! String
                ServerProc().async_img(url: url_str2, funcs: {(img: UIImage) in
                    imageview_area2.layer.masksToBounds = true
                    imageview_area2.layer.cornerRadius = 10
                    imageview2.image = img
                    
                    imageview2.frame = CGRect(x: 0,y: 0 ,width: self.imageMessageSize, height: self.imageMessageSize)
                    cell.contentView.addSubview(imageview_area2)
                    imageview_area2.addSubview(imageview2)
                })
                
                let imageview_area = UIView(frame: CGRect(x: self.view.frame.size.width - userImgSize - 5, y: 5 + imageMessageSize - userImgSize , width: userImgSize, height: userImgSize))
                let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: userImgSize, height: userImgSize))
                let url_str: String = sampleMessages[indexPath.row]["user_img_url"] as! String
                ServerProc().async_img(url: url_str, funcs: {(img: UIImage) in
                    imageview_area.layer.masksToBounds = true
                    imageview_area.layer.cornerRadius = self.userImgSize/2
                    imageview.image = img
                    
                    imageview.frame = CGRect(x: 0,y: 0 ,width: self.userImgSize,height: self.userImgSize)
                    cell.contentView.addSubview(imageview_area)
                    imageview_area.addSubview(imageview)
                })
            }
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
        let messageType: String = sampleMessages[indexPath.row]["type"] as! String
        
        if messageType == "text" {

            let userText = UILabel()
            userText.frame = CGRect(
                x: 8.75,
                y: 8.75,
                width: self.view.frame.size.width - 100 - userImgSize,
                height: 40
            )
            userText.text = "\(sampleMessages[indexPath.row]["contents"]!)"
            userText.numberOfLines = 0
            userText.font = UIFont.systemFont(ofSize: 14)
            userText.sizeToFit()
            return userText.frame.size.height + 35

        }else if messageType == "image" {
            return imageMessageSize + 20
        }
        
        return 40
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
