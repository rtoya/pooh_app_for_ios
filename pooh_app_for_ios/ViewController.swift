import UIKit

// TOP
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "images/background.png")!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // TOPに戻る
    @IBAction func goBackTop(segue: UIStoryboardSegue) {
    }
}

// ログインフォーム
class LoginView: UIViewController {
    
    // keybordを一旦隠してます（keybordが出た時にformが移動する処理などが必要）
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true;
    }

    // フォームの値
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        super.view.backgroundColor = UIColor(patternImage: UIImage(named: "images/background.png")!)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // loginボタンをタップした時の挙動
    @IBAction func loginTapped(sender: AnyObject) {
        
        // 未入力処理
        if(txtEmail==""){ return }
        if(txtPassword==""){ return }
        
        // 登録フォームの値を修正（toJSON）
        let loginData:[String:AnyObject] = [
          "email": txtEmail.text,
          "password": txtPassword.text
        ]
        let jsonString = JSON(loginData).toString()

        
        
        // post処理
        var request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:3000/login")!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
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