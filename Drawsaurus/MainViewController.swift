//
//  MainViewController.swift
//  Drawsaurus
//
//  Created by Shark on 2015-08-15.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit
import Parse

class MainViewController: ViewController, UITableViewDataSource, UITableViewDelegate {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "SegueToDraw") {
            let drawVC = segue.destinationViewController as? DrawViewController
            
        }
        
    }

    @IBOutlet weak var unplayedGameTableView: UITableView!
    @IBOutlet weak var playedGameTableView: UITableView!
    
    var unplayedGameList: NSMutableArray = NSMutableArray()
    var unplayedGameListString: NSMutableArray = NSMutableArray()

    
    @IBAction func logoutUserButton (sender: AnyObject) {
        PFUser.logOut()
        showLoginSignup()
    }
    
    override func viewDidLoad() {
        unplayedGameList.removeAllObjects()
        self.unplayedGameTableView.delegate = self
        self.unplayedGameTableView.dataSource = self
        self.playedGameTableView.delegate = self
        self.playedGameTableView.dataSource = self
        
        super.viewDidLoad()
        if (PFUser.currentUser() != nil) {
            println("I'm still logged in")
            
            // load games user haven't played; showing older games first
            let findGames = PFQuery(className: "Game")
            findGames.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                if (error == nil) {
                    for object in objects! {
                        let game = object as! PFObject
                        let gameObj = game.objectForKey("wordData") as! NSArray
                        let word = gameObj.lastObject as! String
                        
                        println(word)
                        self.unplayedGameListString.addObject(word)
                        self.unplayedGameList.addObject(game)
                        println("added game to unplayed list")
                        
                        self.unplayedGameTableView.reloadData()
                        
                    }
                } else if (error != nil) {
                    var errorString = error?.userInfo?["error"] as? String
                    var popupAlert: UIAlertController = UIAlertController(title: "Error!", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
                    popupAlert.addAction(UIAlertAction(title: "Refresh", style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
                        self.unplayedGameTableView.reloadData()
                    }))
                    self.presentViewController(popupAlert, animated: true, completion: nil)
                }
            })

            // load games user have played
            self.playedGameTableView.reloadData()

        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    let list: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    let list2: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if (tableView == self.unplayedGameTableView) {
            return unplayedGameListString.count
        } else if (tableView == self.playedGameTableView) {
            return list2.count
        }
        
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        if (tableView == self.unplayedGameTableView) {
            cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as? UITableViewCell
            //cell!.textLabel?.text = list[indexPath.row]
            
            let game: PFObject = unplayedGameList.objectAtIndex(indexPath.row) as! PFObject
            var wordArr = game.objectForKey("wordData") as! NSArray
            var lastWord: String = wordArr.lastObject as! String
            println(lastWord)
            
            cell!.textLabel?.text = lastWord

        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as? UITableViewCell
            cell!.textLabel?.text = list2[indexPath.row]

        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("SegueToDraw", sender: self)
    }
    
    @IBAction func newGameButton(sender: UIButton) {
        performSegueWithIdentifier("SegueToNewGame", sender: self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
