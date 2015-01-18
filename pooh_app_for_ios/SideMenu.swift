import UIKit

@objc protocol SideMenuDelegate {
    func sideMenuDidSelectItemAtIndex(index:Int)
    optional func sideMenuWillOpen()
    optional func sideMenuWillClose()
}

class SideMenu: NSObject, MenuTableViewControllerDelegate {
   
}
