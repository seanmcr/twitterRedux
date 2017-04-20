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
    
    var contentViewPanStartPoint: CGPoint!
    
    var viewControllers: [(title: String, viewController: UIViewController)]!
    
    private var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(inactiveViewController: oldValue)
            updateActiveViewController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.rowHeight = UITableViewAutomaticDimension
        menuTableView.estimatedRowHeight = 75
        // Do any additional setup after loading the view.
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tweetsNavController = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController")
        viewControllers = [
            ("Home", tweetsNavController)]
        
        activeViewController = viewControllers[0].viewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanContentView(_ sender: UIPanGestureRecognizer) {
        let minXOffset = contentView.bounds.width / 2
        let maxXOffset = view.bounds.width + (contentView.bounds.width / 2) - 40
        switch sender.state {
        case .began:
            contentViewPanStartPoint = contentView.center
            break
        case .changed:
            let start = contentViewPanStartPoint!
            let translation = sender.translation(in: view)
            contentView.center = CGPoint(
                x: min(max(minXOffset, start.x + translation.x), maxXOffset),
                y: start.y)
            break
        case .ended:
            let velocity = sender.velocity(in: view)
            if (velocity.x > 0) {
                showMenu()
            } else {
                hideMenu()
            }
            break
        case .cancelled:
            break
        default:
            break
        }
    }
    
    func showMenu(){
        let maxXOffset = view.bounds.width + (contentView.bounds.width / 2) - 40
        UIView.animate(withDuration: 0.400, delay: 0, options: .curveEaseOut, animations: {
            self.contentView.center.x = maxXOffset
        }, completion: nil)
    }
    
    func hideMenu(){
        UIView.animate(withDuration: 0.400, delay: 0, options: .curveEaseOut, animations: {
            self.contentView.frame.origin.x = 0
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HamburgerMenuCell", for: indexPath) as! HamburgerMenuCell
        cell.titleLabel.text = viewControllers[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        activeViewController = viewControllers[indexPath.row].viewController
        hideMenu()
    }
    
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inactiveVC = inactiveViewController {
            // call before removing child view controller's view from hierarchy
            inactiveVC.willMove(toParentViewController: nil)
            inactiveVC.view.removeFromSuperview()
            // call after removing child view controller's view from hierarchy
            inactiveVC.removeFromParentViewController()
        }
    }
    
    private func updateActiveViewController() {
        if let activeVC = activeViewController {
            // call before adding child view controller's view as subview
            addChildViewController(activeVC)
            activeVC.view.frame = contentView.bounds
            contentView.addSubview(activeVC.view)
            // call before adding child view controller's view as subview
            activeVC.didMove(toParentViewController: self)
        }
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
