//
//  ViewController.swift
//  palebedev_1Bonus1
//
//  Created by Lebedev Petr on 23.09.2022.
//

import UIKit

class ViewController: UIViewController {
    private enum Constants: Int{
        case  LastIndex = 21
    }
    @IBOutlet weak var backWeel: UIView!
    @IBOutlet weak var frontWheel: UIView!
    @IBOutlet weak var goRightButton: UIButton!
    @IBOutlet weak var carView: UIView!
    @IBOutlet var carBody: [UIView]!
    @IBOutlet weak var turnEngineOffButton: UIButton!
    @IBOutlet weak var turnEngineOnButton: UIButton!
    @IBOutlet weak var goLeftButton: UIButton!
    private var timer: Timer = Timer.scheduledTimer(timeInterval: 21*0.05, invocation: .init(), repeats: true);
    private var isTurned = false;
    override func viewDidLoad() {
        super.viewDidLoad()
        setCarInitialCenterPosition()
        goRightButton.isEnabled = false
        goLeftButton.isEnabled = false
        turnEngineOffButton.isEnabled = false
    }
    
    @IBAction func turnOnEngine(_ sender: Any) {
        turnEngineOnButton.isEnabled = false
        turnEngineOffButton.isEnabled = true
        goLeftButton.isEnabled = true
        goRightButton.isEnabled = true;
        timer = Timer.scheduledTimer(withTimeInterval: 21*0.05, repeats: true) { timer in
            self.animateBody(0)
        }
    }
    @IBAction func offEngine(_ sender: Any) {
        turnEngineOffButton.isEnabled = false
        goRightButton.isEnabled = false
        goLeftButton.isEnabled = false
        turnEngineOnButton.isEnabled = true
        timer.invalidate()
    }
    @IBAction func goLeft(_ sender: Any) {
        if(!isTurned){
            carView.transform = CGAffineTransform(scaleX: -1,y: 1);
            isTurned = true;
        }
        setCarInitialRightPosition()
        UIView.animate(withDuration:0.3,
                       delay: 0,
                       options: [.repeat,.curveLinear]) {
            UIView.modifyAnimations(withRepeatCount: 8, autoreverses: false){
                self.rotateWeels()
            }
        }
        UIView.animate(withDuration: 2.5,delay: 0, animations: {self.setCarInitialCenterPosition()
        }){ _ in
            UIView.animate(withDuration: 2, delay: 0.1, animations: {self.setCarInitialLeftPosition()
            })
            UIView.animate(withDuration:0.3,
                           delay: 0.1,
                           options: [.repeat,.curveLinear]) {
                UIView.modifyAnimations(withRepeatCount: 6, autoreverses: false){
                    self.rotateWeels()
                }
            }
        }
        
    }
    @IBAction func goRight(_ sender: Any) {
        if(isTurned){
            carView.transform = CGAffineTransform(scaleX: 1,y: 1);
            isTurned = false;
        }
        setCarInitialLeftPosition()
        UIView.animate(withDuration:0.3,
                       delay: 0,
                       options: [.repeat,.curveLinear]) {
            UIView.modifyAnimations(withRepeatCount: 8, autoreverses: false){
                self.rotateWeels()
            }
        }
        UIView.animate(withDuration: 2.5,delay: 0, animations: {self.setCarInitialCenterPosition()
        }){ _ in
            UIView.animate(withDuration: 2, delay: 0.1, animations: {self.setCarInitialRightPosition()
            })
            UIView.animate(withDuration:0.3,
                           delay: 0.1,
                           options: [.repeat,.curveLinear]) {
                UIView.modifyAnimations(withRepeatCount: 6, autoreverses: false){
                    self.rotateWeels()
                }
            }
        }
    }
    
    fileprivate func movingCarPart(_ i: Int) {
        if i >= 2 && i <= carBody.count + 1{
            carBody[i-2].bounds.size.height = carBody[i-2].bounds.size.height - 5;
        }
        if (i >= 1 && i<carBody.count + 1){
            carBody[i-1].bounds.size.height = carBody[i-1].bounds.size.height + 5;
        }
        if(i < carBody.count){
            carBody[i].bounds.size.height = carBody[i].bounds.size.height + 5;
        }
        if(i <= carBody.count + 2 && i>=3){
            carBody[i-3].bounds.size.height = carBody[i-3].bounds.size.height - 5;
        }
    }
    
    private func animateBody(_ startIndex: Int){
        if(startIndex > Constants.LastIndex.rawValue){
            return;
        }
        UIView.animate(withDuration: 0.05, animations: {self.movingCarPart(startIndex)}){
            _ in
            self.animateBody(startIndex + 1)
        }
        
    }
    private func rotateWeels(){
        frontWheel.transform = frontWheel.transform.rotated(by: .pi);
        backWeel.transform = backWeel.transform.rotated(by: .pi);
    }
    private func setCarInitialLeftPosition(){
        carView.layer.position = .init(x: -carView.bounds.width, y: view.bounds.height/2)
    }
    private func setCarInitialCenterPosition(){
        carView.layer.position = .init(x: (view.bounds.width)/2, y: view.bounds.height/2)
    }
    private func setCarInitialRightPosition(){
        carView.layer.position = .init(x: view.bounds.width+2*carView.bounds.width, y: view.bounds.height/2)
    }
}

