//
//  TabBarViewController.swift
//  Developer Test
//
//  Created by Marko Meden User on 06/07/2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewControllers?.forEach { $0.view }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        tabBarController?.viewControllers?.forEach {
//            let _ = $0.view
//            $0.viewWillAppear(true)
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
