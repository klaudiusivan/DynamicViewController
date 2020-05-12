//
//  AnswerSheetViewController.swift
//  DynamicViewContainer
//
//  Created by Klaudius Ivan on 11/05/20.
//  Copyright © 2020 Klau. All rights reserved.
//

import UIKit

class AnswerSheetViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var hideMeButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    var parentVC: ParentViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func hideButtonPressewd(_ sender: Any) {
        hideMeButton.isHidden = true
    }
    
    @IBAction func showButtonPressed(_ sender: Any) {
        hideMeButton.isHidden = false
    }
    @IBAction func didAnswer(_ sender: Any) {
        parentVC?.resultVC = ResultViewController(nibName: "ResultViewController", bundle: Bundle(identifier: "id.klauStudio.DynamicViewContainer.DynamicViewContainer"))
        parentVC?.resultVC?.result = "True"
        NotificationCenter.default.post(name: NSNotification.Name(ListVC.Result.rawValue), object: nil)
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
extension AnswerSheetViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
