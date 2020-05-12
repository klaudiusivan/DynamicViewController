//
//  ViewController.swift
//  DynamicViewContainer
//
//  Created by Klaudius Ivan on 11/05/20.
//  Copyright © 2020 Klau. All rights reserved.
//

import UIKit

enum ListVC:String{
    case AnswerSheet
    case Result
}
class ParentViewController: UIViewController {
    
    var answerSheetVC:AnswerSheetViewController?
    var resultVC:ResultViewController?
    var nextPage:ListVC?
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        
    }
    
   
    //MARK: - Action Parent Function
    @IBAction func backButtonTapped(_ sender: Any) {
        switch nextPage {
        case .Result:
            updateChildView(.AnswerSheet)
        default:
            break
        }
    }
    
    //MARK: - Function
    private func setupView() {
        ///object ini di inisialisasi karena merupakan halaman pertama yang muncul
        initializeVC()
        updateChildView(.AnswerSheet)
    }
    private func initializeVC(){
        answerSheetVC = AnswerSheetViewController(nibName: "AnswerSheetViewController", bundle: Bundle(identifier: "id.klauStudio.DynamicViewContainer.DynamicViewContainer"))
        answerSheetVC?.parentVC = self
        
        resultVC = ResultViewController(nibName: "ResultViewController", bundle: Bundle(identifier: "id.klauStudio.DynamicViewContainer.DynamicViewContainer"))
        resultVC?.parentVC = self
    }
    
    ///jembatan untuk fungsi navigasi antar halaman
    private func updateChildView(_ nextPage:ListVC) {
        self.nextPage = nextPage
        switch nextPage {
        case .AnswerSheet:
            showPage(page: nextPage, from: resultVC!, to: answerSheetVC!)
            backButton.isHidden = true
        case .Result:
            showPage(page: nextPage, from: answerSheetVC!, to: resultVC!)
            backButton.isHidden = false
        }
    }
    
    ///view life cycle pada parent VC
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        containerView.frame.size.height = viewController.view.frame.height
        viewController.view.frame.size.width = containerView.bounds.width
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
        
        //add constraint to view controller
        containerView.addConstraints([
            NSLayoutConstraint(item: viewController.view!, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: viewController.view!, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: viewController.view!, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: viewController.view!, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1, constant: 0)
        ])
        
        //add animation to show
        viewController.view.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            viewController.view.alpha = 1
        }, completion: nil)
        
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        //add animation to hide
        UIView.animate(withDuration: 0.5, animations: {
            viewController.view.alpha = 0
        }, completion: nil)
        
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    //MARK: - Show Child VC
    /// Tahapan dalam passing data:
    /// 1. Initialisasi Object Child yang dituju
    /// 2. Access variabel yang mau di isi
    /// 3. Panggil function navigasi
    
    
    ///Keterangan:
    ///Object child pada parent di initialisasi di masing-masing class child sebelum memanggil function navigasi, hal ini dilakukan karena mengikuti tahapan passing data
    
    private func showPage(page:ListVC,from:UIViewController?,to:UIViewController){
        nextPage = page
        
        //di cek nil karena answer sheet adalah halaman pertama, sehingga object result belum ada
        if from != nil{
            remove(asChildViewController: from!)
        }
        
        switch page {
        case .AnswerSheet:
            NotificationCenter.default.addObserver(self, selector: #selector(showResult), name: NSNotification.Name(rawValue: ListVC.Result.rawValue), object: nil)
        case .Result:
            NotificationCenter.default.addObserver(self, selector: #selector(showResult), name: NSNotification.Name(rawValue: ListVC.AnswerSheet.rawValue), object: nil)
        }
        
        add(asChildViewController: to)
    }
    
    //MARK: - Observer Function
    /// aksi dari observer sebagai penghubung antara child dan parent untuk memicu navigasi
    @objc func showAnswerSheet(){
        updateChildView(.AnswerSheet)
    }
    
    @objc func showResult(){
        updateChildView(.Result)
    }
}

