//
//  ResultViewController.swift
//  DynamicViewContainer
//
//  Created by Klaudius Ivan on 11/05/20.
//  Copyright © 2020 Klau. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    var parentVC: ParentViewController?
    var result: String = "aw"
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = result
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
