//
//  MainViewController.swift
//  PanGestureDemo
//
//  Created by gannha on 19/01/2022.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var indicatorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate var startYPosition: CGFloat = 0
    fileprivate var isBottom: Bool = true
    fileprivate var isInAnimation: Bool = false
    fileprivate var isTop: Bool = false
    
    @IBAction func panGesture(_ gesture: UIPanGestureRecognizer) {
        guard let panView = gesture.view else { return }
        indicatorView.isHidden = true
        let translation = gesture.translation(in: view)
        switch gesture.state {
        case .possible: break
        case .began:
            startYPosition = panView.center.y + translation.y
            isTop = (panView.center.y + translation.y) > 550
            if isTop {
                UIView.animate(
                    withDuration: 0.4,
                    delay: 0,
                    usingSpringWithDamping: 0.2,
                    initialSpringVelocity: 1,
                    options: .curveEaseIn
                ) {
                    panView.transform = CGAffineTransform(scaleX: 1.25, y: 1)
                }
            }
        case .changed:
            panView.center = CGPoint(x: panView.center.x, y: panView.center.y + translation.y)
            gesture.setTranslation(CGPoint(x: 0, y: 0), in: view)
        case .ended:
            if panView.center.y + translation.y > 550  {
                toBottom(gesture)
            } else if panView.center.y + translation.y < 450 {
                toTop(gesture)
            } else {
                if startYPosition < 450 {
                    toTop(gesture)
                } else if startYPosition > 550 {
                    toBottom(gesture)
                }
            }
        case .cancelled: break
        case .failed: break
        @unknown default: break

        }
    }
    
    fileprivate func toBottom(_ gesture: UIPanGestureRecognizer) {
        guard let panView = gesture.view else { return }
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 1,
            options: .curveEaseIn
        ) { [weak self] in
            panView.center = CGPoint(x: panView.center.x , y: 667.5)
            gesture.setTranslation(CGPoint(x: 0, y: 0), in: self?.view)
            panView.transform = CGAffineTransform(scaleX: 0.8, y: 1)
        } completion: { [weak self] _ in
            guard let indicatorView = self?.indicatorView else { return }
            UIView.transition(
                with: indicatorView,
                duration: 0.4,
                options: .curveEaseIn
            ){ [weak self] in
                self?.indicatorView.isHidden = false
            }
        }
    }
    
    fileprivate func toTop(_ gesture: UIPanGestureRecognizer) {
        guard let panView = gesture.view else { return }
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.2,
            initialSpringVelocity: 1,
            options: .curveEaseIn
        ) { [weak self] in
            panView.center = CGPoint(x: panView.center.x , y: 350)
            gesture.setTranslation(CGPoint(x: 0, y: 0), in: self?.view)
        }
    }
    
    fileprivate func startAnimationWithDuration (
        _ duration: TimeInterval,
        animations: @escaping () -> (),
        delay: TimeInterval = 0,
        usingSpringWithDamping: CGFloat? = nil,
        options: UIView.AnimationOptions = [],
        isMainAnimation: Bool = true,
        completion: ((Bool) -> Void)? = nil
    ) {
        if isMainAnimation {
            isInAnimation = true
        }
        
        if let usingSpringWithDamping = usingSpringWithDamping {
            UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: 0, options: options, animations: animations, completion: { [weak self] (isComplete) in
                self?.isInAnimation = false
                
                completion?(isComplete)
            })
        }
        else {
            UIView.animate(withDuration: duration, delay: delay, animations: animations, completion: { [weak self] (isComplete) in
                self?.isInAnimation = false
                
                completion?(isComplete)
            })
        }
    }
}
