//
//  PopViewController.swift
//  ProgrammingAssignment
//
//  Created by Junjie Xu on 9/2/19.
//  Copyright © 2019 Junjie Xu. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {

    @IBAction func reutrnToScreenButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
