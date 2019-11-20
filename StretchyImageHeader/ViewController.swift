//
//  ViewController.swift
//  StretchyImageHeader
//
//  Created by talha on 20/11/2019.
//  Copyright © 2019 syemojis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var childImgView: UIView!
    @IBOutlet weak var parentSubView: UIView!
    @IBOutlet weak var parentScrollView: UIScrollView!
    
    //Constraints
    @IBOutlet weak var topChildConstraint: NSLayoutConstraint!
    @IBOutlet weak var parentViewHC: NSLayoutConstraint!
    
    
    private var lastContentOffset: CGFloat = 0
    var originalHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if let newImage  =  UIImage(named: "clem-onojeghuo-hxhg3ul-CDw-unsplash"){
        //    self.childImgView.backgroundColor = UIColor(patternImage: newImage)
            
            let backgroundImage = UIImageView(frame: self.childImgView.bounds)
            backgroundImage.image = newImage
            backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
            self.childImgView.insertSubview(backgroundImage, at: 0)
        }
        
      
        // Do any additional setup after loading the view.
        
        self.setupScrollView()
        
        originalHeight = parentViewHC.constant
    }
    
    
    func setupScrollView(){
        self.parentScrollView.delegate = self
        parentScrollView.bounces = true
        parentScrollView.alwaysBounceVertical = true
        parentScrollView.isDirectionalLockEnabled = true
        
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


extension ViewController : UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let defaultTop = CGFloat(0)
        print("The offsets are",offset)
        // If we have not scrolled too high then stick to default y pos
        var currentTop = defaultTop
        if offset < 0{ //Whenever we go too high run this code block
            //The new top (y position) of the imageview
            currentTop = offset
            parentViewHC.constant = originalHeight - offset
        }else{
              parentViewHC.constant = originalHeight
        }
        
        
        self.topChildConstraint.constant = currentTop
    }
    
}
