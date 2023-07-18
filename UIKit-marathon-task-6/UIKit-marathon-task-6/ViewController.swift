//
//  ViewController.swift
//  UIKit-marathon-task-6
//
//  Created by Руслан Сабиров on 18/07/2023.
//

import UIKit

class ViewController: UIViewController {
    private lazy var squareView: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var dynamicAnimator = UIDynamicAnimator()
    private lazy var collision = UICollisionBehavior()
    private var snapBehaviour: UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(squareView)
        squareView.center = view.center
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
        view.addGestureRecognizer(tap)
        setupAnimation()
    }
    
    private func setupAnimation() {
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collision)
    }
    
    @objc func onTap(_ gesture: UITapGestureRecognizer){
        if let snapBehaviour {
            dynamicAnimator.removeBehavior(snapBehaviour)
        }
        
        let touchPoint = gesture.location(in: view)
        snapBehaviour = UISnapBehavior(item: squareView, snapTo: touchPoint)
        snapBehaviour?.damping = 1.0
        dynamicAnimator.addBehavior(snapBehaviour ?? UISnapBehavior())
    }
}
