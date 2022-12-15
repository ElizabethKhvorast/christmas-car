//
//  StartViewController.swift
//  car
//
//  Created by Елизавета Хворост on 16/11/2022.
//

import UIKit

class StartViewController: UIViewController
{
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad()
    {
        self.addSnowflakes()
        super.viewDidLoad()
        self.startButton.setAttributedTitle(self.makeAttributedTitle(for: "Start"),
                                            for: .normal)
        self.recordButton.setAttributedTitle(self.makeAttributedTitle(for: "Record"),
                                            for: .normal)
        self.settingsButton.setAttributedTitle(self.makeAttributedTitle(for: "Settings"),
                                            for: .normal)
        
    }
    
    func makeAttributedTitle(for string: String) -> NSAttributedString?
    {
        if let font = UIFont(name: "Saint Nicholas PERSONAL Regular", size: 30)
        {
            var attributedString = AttributedString(string)
            attributedString.font = font
            attributedString.foregroundColor = .systemRed
            //attributedString.underlineStyle = .single
            //attributedString.underlineColor = .purple
            attributedString.kern = 2

            
//            let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor : UIColor.systemRed,
//                                                              NSAttributedString.Key.font : font,
//                                                              NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
//                                                              NSAttributedString.Key.paragraphStyle : NSParagraphStyle.default]
//            let attributedString = NSAttributedString(string: string, attributes: attributes)
            return NSAttributedString(attributedString)
        }
        return nil
    }
    
    func addSnowflakes ()
    {
        let flakeEmitterCell = CAEmitterCell ()
        flakeEmitterCell.contents = UIImage (named: "snowFlake" )?.cgImage
        flakeEmitterCell.scale = 0.1
        flakeEmitterCell.color = UIColor.white.cgColor
        flakeEmitterCell.scaleRange = 0.3
        flakeEmitterCell.lifetime = 20.0
        flakeEmitterCell.birthRate = 20
        flakeEmitterCell.velocity = -30
        flakeEmitterCell.velocityRange = -20
        flakeEmitterCell.yAcceleration = 10
        flakeEmitterCell.xAcceleration = 1
        flakeEmitterCell.spin = -0.1
        flakeEmitterCell.spinRange = 1.0
        let snowEmitterLayer = CAEmitterLayer()
        snowEmitterLayer.emitterPosition = CGPoint(x: view.bounds.width / 2, y: -50)
        snowEmitterLayer.emitterSize=CGSize(width:view.bounds.width,height:0)
        snowEmitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        snowEmitterLayer.beginTime = CACurrentMediaTime ()
        snowEmitterLayer.timeOffset = 10
        snowEmitterLayer.emitterCells = [flakeEmitterCell]
        self.backgroundImageView.layer.addSublayer(snowEmitterLayer)
        //self.view.layer.insertSublayer(snowEmitterLayer, at: 0)
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
    
    
    @IBAction func settingsPressed(_ sender: Any)
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let ViewController = storyBoard.instantiateViewController(withIdentifier: "SettingViewController")
            as? SettingViewController
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
