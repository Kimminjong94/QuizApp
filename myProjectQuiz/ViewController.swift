//
//  ViewController.swift
//  myProjectQuiz
//
//  Created by 김민종 on 2021/12/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var trueLabel: UIButton!
    @IBOutlet weak var falseLabel: UIButton!
    @IBOutlet weak var progressLabel: UIProgressView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var backGroundLabel: UIImageView!
    
    let urlString = "https://upload.wikimedia.org/wikipedia/commons/d/db/Background_Clouds_2_%2855079272%29.jpeg"

    
    let quiz = [
        Question(q: "4+4 = 8", a: "True"),
        Question(q: "2+2 = 4", a: "True"),
        Question(q: "3+3 = 12", a: "False"),
        Question(q: "1+1 = 2", a: "True"),
        Question(q: "12-3 = 9", a: "True"),
        Question(q: "3+12 = 2", a: "False"),
        Question(q: "3+10 = 10", a: "False"),
        Question(q: "3+3 = 12", a: "False")
    ]
    
    var quetionNumber = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()
        
        fetchImage({ (data) in
            print(data)
        })
    }

    @IBAction func answerButton(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle
        let actualAnswer = quiz[quetionNumber].answer
        
        if userAnswer == actualAnswer {
            sender.backgroundColor = UIColor.green
            score += 1
        } else {
            sender.backgroundColor = UIColor.red
        }
        
        if quetionNumber + 1 < quiz.count {
            quetionNumber += 1
        } else {
            quetionNumber = 0
            score = 0
        }
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(update), userInfo: nil, repeats: false)
        
    }
    
    @objc func update() {
        
        DispatchQueue.main.async() {
            self.label.text = self.quiz[self.quetionNumber].text
            self.trueLabel.backgroundColor = UIColor.clear
            self.falseLabel.backgroundColor = UIColor.clear
            self.scoreLabel.text = "Score: \(self.getScore())"
            self.progressLabel.progress = Float(self.quetionNumber + 1) / Float(self.quiz.count)
        }
    }
    
    func getScore() -> Int {
        return score
    }
    
    private func fetchImage(_ completion: @escaping (Result<(Data, URLResponse), Error>) -> Void) {

        let getDataTask = URLSession.shared.dataTask(with: URL(string: urlString)!) {data, response, error in
            if let error = error {
              completion(.failure(error))
            } else if let data = data, let response = response {
              completion(.success((data, response)))
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                let image = UIImage(data: data!)
                self.backGroundLabel.image = image
            }
        }
        getDataTask.resume()
    }
}

