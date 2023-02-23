//
//  ViewController.swift
//  TextContainsEmoji
//
//  Created by Salman Biljeek on 2/23/23.
//

import UIKit

class ViewController: UIViewController {
    
    let text1: String = "Contains Emoji 😀"
    let text2: String = "Contains Emoji"
    lazy var label1: UILabel = {
        let label = UILabel()
        label.text = self.text1
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 270).isActive = true
        return label
    }()
    lazy var label2: UILabel = {
        let label = UILabel()
        label.text = self.text2
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 270).isActive = true
        return label
    }()
    
    let boolLabel1: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.textColor = .systemPink
        return label
    }()
    
    let boolLabel2: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.textColor = .systemPink
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        let stack1 = UIStackView(arrangedSubviews: [
            label1,
            boolLabel1
        ])
        stack1.axis = .horizontal
        stack1.spacing = 3
        stack1.alignment = .center
        
        let stack2 = UIStackView(arrangedSubviews: [
            label2,
            boolLabel2
        ])
        stack2.axis = .horizontal
        stack2.spacing = 3
        stack2.alignment = .center
        
        let mainStack = UIStackView(arrangedSubviews: [
            stack1,
            stack2
        ])
        mainStack.axis = .vertical
        mainStack.spacing = 0
        mainStack.alignment = .leading
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mainStack)
        mainStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 25).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let text1ContainsEmoji = text1.containsEmoji
        let text2ContainsEmoji = text2.containsEmoji
        
        boolLabel1.text = String(text1ContainsEmoji)
        boolLabel2.text = String(text2ContainsEmoji)
    }
}

extension Character {
    // A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
    // Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }
    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}

extension String {
    var isSingleEmoji: Bool { count == 1 && (first?.isEmoji ?? false) }
    var containsEmoji: Bool { contains { $0.isEmoji } }
}

