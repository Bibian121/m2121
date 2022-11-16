//
//  ViewController.swift
//  M21_Homework
//
//  Created by Maxim Nikolaev on 15.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var labelFish: UILabel = {
       let label = UILabel()
        label.text = " Поймано рыб: \(valueFishCatched)"
        label.textColor = .green
        label.backgroundColor = .white
        label.frame = CGRect(x: 130, y: 780, width: 140, height: 20)
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        return label
    }()
    
    lazy var buttonReset : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 40, y: 780, width: 50, height: 20)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.setTitle("reset", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
        return button
    }()
    
    var fishes = [Fish]()
    let valueFish = 5
    var valueFishCatched = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
        
        let backImage = UIImage(named: "ocean") ?? UIImage()
        view.backgroundColor = UIColor(patternImage: backImage)
        
        view.addSubview(labelFish)
        view.addSubview(buttonReset)
        
        setFish()

    }
    
    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        for fish in 0..<fishes.count {
            let tapLocation = gesture.location(in: fishes[fish].fish.superview)
            if (fishes[fish].fish.layer.presentation()?.frame.contains(tapLocation))! {
                print("fish tapped!")
                if fishes[fish].isFishCathed { return }
                fishes[fish].isFishCathed = true
                fishCatchedAnimation(fishes[fish].fish)
            }
        }
    }
    
    @objc func resetGame () {
        if valueFishCatched == 5 {
            setFish()
            valueFishCatched = 0
            print("Все рыбы пойманы!")
        } else {
            print("Продалжаем играть!")
        }
    }
    
    func setFish () {
        for _ in 0 ..< valueFish {
            let newFish:Fish = Fish(fish: UIImageView(image: UIImage(named: "fishOne")!), isFishCathed: false)
            newFish.fish.frame = CGRect( x: Int.random(in: 45 ... 300), y: Int.random(in: 70 ... 700), width: 100, height: 100)
            newFish.fish.alpha = 1.0
            newFish.fish.contentMode = .scaleAspectFit
            switch Int.random(in: 1...5) {
                case 1: newFish.fish.image = UIImage(named: "fishOne")
                case 2: newFish.fish.image = UIImage(named: "fishTwo")
                case 3: newFish.fish.image = UIImage(named: "fishThree")
                case 4: newFish.fish.image = UIImage(named: "fishFour")
                default: newFish.fish.image = UIImage(named: "fishFive")
            }
            switch Int.random(in: 1...4) {
                case 1: moveLeft()
                case 2: moveRight()
                case 3: moveTop()
                default: moveBottom()
            }
            fishes.append(newFish)
            view.addSubview(newFish.fish)
        }
    }

    func moveLeft() {
        for fish in 0..<fishes.count {
        if fishes[fish].isFishCathed { return }
            
      UIView.animate(withDuration: 1.0,
                     delay: 2.0,
                     options: [.curveEaseInOut , .allowUserInteraction],
                     animations: { [unowned self] in
          self.fishes[fish].fish.center = CGPoint( x: Int.random(in: 45 ... 300), y: Int.random(in: 70 ... 700))
      },
                     completion: { [unowned self] finished in
                      print("fish moved left!")
                      self.moveRight()
      })
        }
    }


    func moveRight() {
        for fish in 0..<fishes.count {
        if fishes[fish].isFishCathed { return }

        UIView.animate(withDuration: 1.0,
                       delay: 2.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: { [unowned self] in
            self.fishes[fish].fish.center = CGPoint( x: Int.random(in: 45 ... 300), y: Int.random(in: 70 ... 700))
        },
                       completion: { [unowned self] finished in
                        print("fish moved right!")
                        self.moveTop()
        })
        }
    }

    func moveTop() {
        for fish in 0..<fishes.count {
        if fishes[fish].isFishCathed { return }

        UIView.animate(withDuration: 1.0,
                       delay: 2.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: { [unowned self] in
            self.fishes[fish].fish.center = CGPoint( x: Int.random(in: 45 ... 300), y: Int.random(in: 70 ... 700))
        },
                       completion: { [unowned self] finished in
                        print("fish moved top!")
                        self.moveBottom()
        })
        }
    }

    func moveBottom() {
        for fish in 0..<fishes.count {
        if fishes[fish].isFishCathed { return }

        UIView.animate(withDuration: 1.0,
                       delay: 2.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: { [unowned self] in
            self.fishes[fish].fish.center = CGPoint( x: Int.random(in: 45 ... 300), y: Int.random(in: 70 ... 700))
        },
                       completion: { [unowned self] finished in
                        print("fish moved bottom!")
                        self.moveLeft()
        })
        }
    }

    func fishCatchedAnimation(_ fish: UIImageView) {
        UIView.animate(withDuration: 1.0,
                       delay: 2.0,
                       options: [.curveEaseInOut , .allowUserInteraction],
                       animations: {
                        fish.alpha = 0.0
                        fish.center = CGPoint( x: 200 , y: -900)
        },
                       completion: { finished in
            self.valueFishCatched += 1
            print("Пойманно рыб: \(self.valueFishCatched)")
            self.labelFish.text = "Поймано рыб: \(self.valueFishCatched)"
        })
    }
}

