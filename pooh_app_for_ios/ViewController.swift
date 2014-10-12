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