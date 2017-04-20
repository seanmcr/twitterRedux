//
//  HamburgerMenuViewController.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/19/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class HamburgerMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    
    var viewControllers: [(String, UIViewController)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.delegate = self
        menuTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tweetsNavController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController")
        viewControllers = [("Home", tweetsNavController)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HamburgerMenuCell", for: indexPath) as! HamburgerMenuCell
        cell.titleLabel.text = viewControllers[indexPath.row].0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
