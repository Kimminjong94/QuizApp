//
//  Question.swift
//  myProjectQuiz
//
//  Created by 김민종 on 2021/12/16.
//

import Foundation


struct Question {
    
    let text: String
    let answer: String
    
    init(q: String, a: String) {
        text = q
        answer = a
    }
    
}
