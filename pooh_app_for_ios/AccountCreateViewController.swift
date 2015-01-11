import UIKit

// アカウント登録
class AccountCreate: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.backgroundColor = UIColor(patternImage: UIImage(named: "images/background.png")!)
        
                tableView.dataSource = self
                tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellName: String
        
        // cellNameの宣言
        switch indexPath.row {
        case 0:
            cellName = "nickNameCell"
        case 1:
            cellName = "mailCell"
        case 2:
            cellName = "passwordCell"
        default:
            cellName = ""
        }
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellName, forIndexPath: indexPath) as UITableViewCell
    
        // txtFieldの宣言
        switch indexPath.row {
        case 0:
            let nameTxt = cell.viewWithTag(1) as UITextField
        case 1:
            let txtEmail = cell.viewWithTag(1) as UITextField
        case 2:
            var txtPassword = cell.viewWithTag(1) as UITextField
        default:
            let txtField = cell.viewWithTag(1) as UITextField
        }
        
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath!) {
        // do nothing
        
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 30
    }
    
    @IBAction func createUserTapped(sender: AnyObject) {
        // 未入力処理
/*        if(txtName==""){ return }
        if(txtEmail==""){ return }
        if(txtPassword==""){ return }
*/
        
        // 登録フォームの値を修正（toJSON）
        let loginData:[String:AnyObject] = [
            "email": "mshbmmsmsm.u.yauya.da.yo.n@gmail.com",
            "password": "password"
            /*
            "email": txtEmail.text,
            "password": txtPassword.text
            */
        ]
        let jsonString = JSON(loginData).toString()
        
        // post処理
        var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:3000/user/create")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // send the request
        var urlData = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        if let httpResponse = response as? NSHTTPURLResponse {
            let statusCode = httpResponse.statusCode
            if (statusCode == 200){
                // login成功時の処理
                var responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                var user_id = JSON.parse(responseData)["user_id"]
                
                // NSUserDefaultsにユーザーデータを保存
                let ud = NSUserDefaults.standardUserDefaults()
                var udId : AnyObject! = ud.objectForKey("id")
                ud.setObject(user_id.toString(), forKey: "id")
                println("\(udId)")
                
                // 画面遷移
                var next = PoohMapViewController()
                self.presentViewController(next, animated: false, completion: nil)
                
            } else {
                println("通信エラーが発生したよ.")
            }
        } else {
            println("データの送信に失敗したよ.")
        }
    }
    
}
