//
//  OnboardOneViewController.swift
//  EagleEye-Xcode
//
//  Created by Austin Potts on 1/10/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class OnboardOneViewController: UIViewController {

    @IBOutlet weak var learnMore: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        learnMore.layer.cornerRadius = 20
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
