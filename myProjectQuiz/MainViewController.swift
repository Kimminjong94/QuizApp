//
//  MainViewController.swift
//  myProjectQuiz
//
//  Created by 김민종 on 2021/12/16.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MusicPlayer.shared.startBackgroundMusic()
        
//        getImage()
        
        print("Begin of code")
        let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/d/db/Background_Clouds_2_%2855079272%29.jpeg")!
        downloadImage(from: url)
        print("image will continue downloading in the background and it will be loaded when it ends.")

    }
    
    @IBAction func startButton(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController else {
                return
            }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: {() in print("화면전환 완료")})
        }
        
        MusicPlayer.shared.gamePlaydMusic()


    }
    
//    func getImage() {
//        if let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/d/db/Background_Clouds_2_%2855079272%29.jpeg") {
//            let task = URLSession.shared.dataTask(with: url) { data, response, error in
//                guard let data = data, error == nil else { return }
//                DispatchQueue.main.async {
//                    self.mainImageView.image = UIImage(data: data)
//                }
//            }
//            task.resume()
//        }
//    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                [weak self] in self?.mainImageView.image = UIImage(data: data)
            }
        }
    }

    

}
