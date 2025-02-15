//
//  NewGameViewController.swift
//  Drawsaurus
//
//  Created by Shark on 2015-08-18.
//  Copyright (c) 2015 JRC. All rights reserved.
//

import UIKit
import Parse

class NewGameViewController: UIViewController {

    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBAction func newGameButton(sender: UIButton) {
        if ((descriptionTextField.text != nil) && (descriptionTextField.text != "")) {
            var gameArr: NSMutableArray = NSMutableArray()
            var imageArr: NSMutableArray = NSMutableArray()
            gameArr.addObject(descriptionTextField.text)
            var game1: Game = Game(guess: descriptionTextField.text)
            var PFGame: PFObject = PFObject(className: "Game")
            PFGame["wordData"] = gameArr
            PFGame["imageData"] = imageArr
            PFGame["user"] = PFUser.currentUser()
            PFGame["didFinish"] = false
            
            PFGame.saveInBackground()
            println("game successfully created")
            performSegueWithIdentifier("SegueNewGameToMain", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
