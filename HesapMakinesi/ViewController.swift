//
//  ViewController.swift
//  HesapMakinesi
//
//  Created by Büşra Özcan on 22.09.2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var sonucLabel: UILabel!
    @IBOutlet weak var customKeyboardView: UIView!
    @IBOutlet weak var text: UITextField!
    var isCustomKeyboardVisible = true;
    
    var yapilanIslem : String = ""
    var rakamlar : [Int] = []
    var rakam = ""
    var sonuc : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customKeyboardView.isHidden = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        text.addGestureRecognizer(tapGesture)
        text.isUserInteractionEnabled = true
    }

    @objc func labelTapped() {
        if isCustomKeyboardVisible {
            customKeyboardView.isHidden = true
            text.becomeFirstResponder()
        } else {
            customKeyboardView.isHidden = false
            text.resignFirstResponder()
        }
        isCustomKeyboardVisible = !customKeyboardView.isHidden
    }

    
    @IBAction func buttonTapped(_ sender: UIButton) {
            if sender.titleLabel!.text! == "←" {
                print("Silme işlemi gerçekleşti")
                
                // silme butonuna tıklandıgında en sondaki karakteri silecek
                var sonKarakter = ""
                if yapilanIslem.isEmpty {
                    sonKarakter = "-1"
                } else {
                    let karakter = yapilanIslem.removeLast()
                    sonKarakter = String(karakter)
                }
                text.text = yapilanIslem
                
                // stringdeki sayıları tekrar bulup baştan hesaplaması lazım!!!
                
                // bu kısımda stringdeki sayıları buluyor
                rakamlar = []
                let regex = try! NSRegularExpression(pattern: "\\d+")
                let matches = regex.matches(in: yapilanIslem, range: NSRange(yapilanIslem.startIndex..., in: yapilanIslem))

                for match in matches {
                    if let range = Range(match.range, in: yapilanIslem) {
                        let sayiString = yapilanIslem[range]
                        print("sayistring : \(sayiString)")
                        if let sayi = Int(sayiString) {
                            rakamlar.append(sayi)
                        }
                    }
                }
                
                // burada buldugu sayıları tekrar topluyor
                sonuc = 0
                for rakam in rakamlar {
                    sonuc += rakam
                }
                sonucLabel.text = String(sonuc)
            
            } else if sender.titleLabel!.text! == "C" {
                rakam = ""
                rakamlar = []
                sonuc = 0
                yapilanIslem = ""
                text.text = yapilanIslem
                sonucLabel.text = "0"
                
                
            } else if sender.titleLabel!.text! == "+" {
                if let intValue = Int(rakam) {
                    rakamlar.append(intValue)
                    sonuc += intValue
                    rakam = ""
                    yapilanIslem += " + "
                    text.text = yapilanIslem
                    sonucLabel.text = String(sonuc)
                } else {
                    print("Rakam inte dönüştürülemedi")
                }
                
                
            } else {
                switch sender.titleLabel?.text {
                    case "9":
                        yapilanIslem += "9"
                        rakam += "9"
                    case "8":
                        yapilanIslem += "8"
                        rakam += "8"
                    case "7":
                        yapilanIslem += "7"
                        rakam += "7"
                    case "6":
                        yapilanIslem += "6"
                        rakam += "6"
                    case "5":
                        yapilanIslem += "5"
                        rakam += "5"
                    case "4":
                        yapilanIslem += "4"
                        rakam += "4"
                    case "3":
                        yapilanIslem += "3"
                        rakam += "3"
                    case "2":
                        yapilanIslem += "2"
                        rakam += "2"
                    case "1":
                        yapilanIslem += "1"
                        rakam += "1"
                    case "0":
                        yapilanIslem += "0"
                        rakam += "0"
                    default:
                        print("Yanlış işlem")
                    
                }
                text.text = yapilanIslem
            }
        
    }

    
}

