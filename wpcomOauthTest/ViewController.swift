//
//  ViewController.swift
//  wpcomOauthTest
//
//  Created by Jorge Bernal Ordovas on 27/05/16.
//  Copyright © 2016 WordPress. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func authorize() {
        OauthManager().authorize()
    }

}

