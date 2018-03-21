//
//  ViewController.swift
//  CircularView
//
//  Created by Appinventiv on 08/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:--> Outlets
    
    //@IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var circlesTF: UITextField!
    @IBOutlet weak var someView: UIView!
    
    @IBAction func tapButton(_ sender: Any) {
        let circularView2 = self.storyboard?.instantiateViewController(withIdentifier: "circularcollection") as! Circularcollection
        self.navigationController?.pushViewController(circularView2, animated: true)
    }
    
    @IBAction func showButton(_ sender: Any) {
        if circlesTF != nil{
            setUpLayer()
        }
    }
    
    //MARK:--> Variable and object declaration
    
    let replicatorLayer = CAReplicatorLayer()
    var toggle: Bool = true
    //let images = ["A","B","C","D","E","F","G","H","I","J"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpLayer() {
        let numberOfItems = Int(circlesTF.text!)
        replicatorLayer.instanceCount = numberOfItems!
        replicatorLayer.instanceColor = UIColor.white.cgColor
        replicatorLayer.backgroundColor = UIColor.white.cgColor
        
        let angle = Float(Double.pi * 2.0) / Float(numberOfItems!)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
        
        let instanceLayer = CALayer()
        let layerWidth: CGFloat = 40
        let midX = view.bounds.midX
        //let midY = view.bounds.midY
        
        instanceLayer.frame = CGRect(x: 0, y: 0, width: layerWidth, height: layerWidth)
        instanceLayer.cornerRadius = layerWidth/2
        instanceLayer.backgroundColor = UIColor.gray.cgColor
        instanceLayer.opacity = 0.6
        
        let circum = CGFloat(numberOfItems!)*layerWidth
        let radius = circum/(2*3.14)
        let dia = 2.0*radius
        someView.frame = CGRect(x: 0, y: 0, width: dia, height: dia)
        someView.backgroundColor = UIColor.white
        someView.center = self.view.center
        replicatorLayer.frame = CGRect(x: 0, y: 0, width: dia, height: dia)
        let x = dia/4
        let y = dia/4
        replicatorLayer.contentsCenter = CGRect(x: x, y: y, width: dia, height: dia)
        someView.layer.addSublayer(replicatorLayer)
        
        let imageView = UIImageView()
        imageView.frame = CGRect(x: midX-55, y: 27.0, width: layerWidth, height: layerWidth)
        imageView.image = UIImage(named: "C")
        let image = imageView.image?.cgImage
        instanceLayer.contents = image
        instanceLayer.masksToBounds = true
        
        replicatorLayer.addSublayer(instanceLayer)
        //
        //        let instanceLayer2 = CALayer()
        //        let layerWidth2: CGFloat = 5.0
        //        let midX2 = someView.bounds.midX
        //        let midY2 = someView.bounds.midY
        //        instanceLayer2.frame = CGRect(x: midX2, y: midY2, width: layerWidth2, height: 70)
        //        instanceLayer2.backgroundColor = UIColor.gray.cgColor
        //        someView.layer.addSublayer(instanceLayer2)
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = 10
        rotateAnimation.repeatCount=Float.infinity
        self.replicatorLayer.add(rotateAnimation, forKey: nil)
        //someView.layer.add(rotateAnimation, forKey: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        toggle = !toggle
        if toggle{
            replicatorLayer.shadowOpacity = 0.6
            replicatorLayer.shadowRadius = 7.0
            replicatorLayer.shadowOffset = .zero
        }
            
        else{
            replicatorLayer.shadowOpacity = 0.0
            replicatorLayer.shadowRadius = 0.0
        }
    }
}
