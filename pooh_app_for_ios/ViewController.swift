import UIKit

// TOP
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "images/background.png"))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // TOPに戻る
    @IBAction func goBackTop(segue: UIStoryboardSegue) {
    }
}


// アカウント登録
class AccCreateView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        super.view.backgroundColor = UIColor(patternImage: UIImage(named: "images/background.png"))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var createInput: UITextField!
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
        super.view.backgroundColor = UIColor(patternImage: UIImage(named: "images/background.png"))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // loginボタンをタップした時の挙動
    @IBAction func loginTapped(sender: AnyObject) {
        
        // formの値をjsonに格納
        let loginData:[String:AnyObject] = [
          "email": txtEmail.text,
          "password": txtPassword.text
        ]
        let jsonString = JSON(loginData).toString() // json.swiftを利用（pod install で入らないので注意）
        
        
        // APIでpost（URLはどっかでまとめて管理したい）
        /*
        var request = NSMutableURLRequest(URL: NSURL(string: "localhost:3000/login"), cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 5)
        var response: NSURLResponse?
        var error: NSError?
        
        request.HTTPBody = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        request.HTTPMethod = "POST"
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // send the request
        NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        
        // responceから処理を切り分け
        if let httpResponse = response as? NSHTTPURLResponse {
            println("HTTP response: \(httpResponse.statusCode)")
        } else {
            println("No HTTP response")
        }
        */
        
        
        
    }
}