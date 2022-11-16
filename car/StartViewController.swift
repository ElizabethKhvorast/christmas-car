//
//  StartViewController.swift
//  car
//
//  Created by Елизавета Хворост on 16/11/2022.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startPressed(_ sender: Any)
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyBoard.instantiateViewController(withIdentifier: "GameViewController") as? ViewController
        {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBAction func recordPressed(_ sender: Any)
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let ViewController = storyBoard.instantiateViewController(withIdentifier: "RecordViewController")
            as? RecordViewController
        {
            self.navigationController?.pushViewController(ViewController, animated: true)
        }
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
