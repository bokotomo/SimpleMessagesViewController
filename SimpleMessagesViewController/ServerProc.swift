import UIKit

//Server communication processing class
class ServerProc{
    let condition = NSCondition()
    
    func async(url:String,post:String,funcs: @escaping ([String:Any]) -> Void){
        
        var r = URLRequest(url:URL(string: url)!)
        r.httpMethod = "POST"
        r.httpBody = post.data(using: String.Encoding.utf8)
        
        var parsedData :[String:Any] = [:]
        let task = URLSession.shared.dataTask(with: r) { (data, response, error) in
            
            if error != nil {
                print(error)
            } else {
                do {
                    parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            funcs(parsedData)
        }
        task.resume()
    }
    
    func sync(url:String,post:String) -> [String:Any]{
        
        var r = URLRequest(url:URL(string: url)!)
        r.httpMethod = "POST"
        r.httpBody = post.data(using: String.Encoding.utf8)
        
        var parsedData :[String:Any] = [:]
        let task = URLSession.shared.dataTask(with: r) { (data, response, error) in
            
            if error != nil {
                print("--------- error")
                
            } else {
                do {
                    parsedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            self.condition.signal()
            self.condition.unlock()
        }
        self.condition.lock()
        task.resume()
        self.condition.wait()
        self.condition.unlock()
        return parsedData
    }

    func async_img(url:String,funcs: @escaping (UIImage) -> Void){
        
        var u:URL?
        if( url.range(of: "Error") == nil){
            u = URL(string:url)
        }else{
            u = URL(string:"")
        }
        let r = URLRequest(url:u!)
        NSURLConnection.sendAsynchronousRequest(r, queue:OperationQueue.main){(res, data, err) in
            let httpResponse = res as? HTTPURLResponse
            var im = UIImage(named: "Theme_img")
            if data != nil && httpResponse!.statusCode != 404{
                im = UIImage(data:data!)
            }
            //関数実行
            funcs(im!)
        }
    }
    
}

