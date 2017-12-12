//
//  ViewController.swift
//  PlistExample
//
//  Created by John Diczhazy on 12/9/17.
//  Copyright © 2017 JohnDiczhazy. All rights reserved.
// Based on https://stackoverflow.com/questions/9335475/iphone-read-write-plist-file/9338807#9338807
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nationTextField: UITextField!
    @IBOutlet weak var capitalTextField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayNationAndCapitalCityNames()
        }
        
        
        //Display Nation and Capital
        func displayNationAndCapitalCityNames() {
            let plistPath = self.getPath()
            self.textView.text = ""
            if FileManager.default.fileExists(atPath: plistPath) {
                if let nationAndCapitalCitys = NSMutableDictionary(contentsOfFile: plistPath) {
                    for (_, element) in nationAndCapitalCitys.enumerated() {
                        self.textView.text = self.textView.text + "\(element.key) --> \(element.value) \n"
                    }
                }
            }
        }
        
        //On Click OF Submit
        @IBAction func onSubmit(_ sender: UIButton) {
            let plistPath = self.getPath()
            if FileManager.default.fileExists(atPath: plistPath) {
                let nationAndCapitalCitys = NSMutableDictionary(contentsOfFile: plistPath)!
                nationAndCapitalCitys.setValue(capitalTextField.text!, forKey: nationTextField.text!)
                nationAndCapitalCitys.write(toFile: plistPath, atomically: true)
            }
            nationTextField.text = ""
            capitalTextField.text = ""
            displayNationAndCapitalCityNames()
        }
    
    func getPath() -> String {
        let plistFileName = "data.plist"
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentPath = paths[0] as NSString
        let plistPath = documentPath.appendingPathComponent(plistFileName)
        
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: plistPath) {
            print("file exists!")
            return plistPath
        } else {
            let dicContent:[String:String] = [:]
            let plistContent = NSDictionary(dictionary: dicContent)
            plistContent.write(toFile: plistPath, atomically: true)
            print("file does not exist, creating......")
            return plistPath
        }
        
        
    }
}
