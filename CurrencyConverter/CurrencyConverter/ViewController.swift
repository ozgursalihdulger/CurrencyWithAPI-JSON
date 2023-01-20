//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Özgür Salih Dülger on 19.01.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var euroLabel: UILabel!
    
    @IBOutlet weak var czkLabel: UILabel!
    
    @IBOutlet weak var gbpLabel: UILabel!
    
    @IBOutlet weak var plnLabel: UILabel!
    
    @IBOutlet weak var dkkLabel: UILabel!
    
    @IBOutlet weak var tryLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func showRates(_ sender: Any) {
        
        let url = URL(string: "https://api.freecurrencyapi.com/v1/latest?apikey=ySDSUM7W1qnqpi6p12iZo1XEQeZPie6mPQQ6k2sF")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                
                let okButton = UIAlertAction(title: "OKEY", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                
                if data != nil {
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["data"] as? [String : Any] {
                                
                                if let euro = rates ["EUR"] as? Double {
                                    self.euroLabel.text = "EUR: \(euro) "
                                }
                                
                                if let czk = rates ["CZK"] as? Double {
                                    self.czkLabel.text = "CZK: \(czk) "
                                }
                                
                                if let gbp = rates ["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp) "
                                }
                                
                                if let pln = rates ["PLN"] as? Double {
                                    self.plnLabel.text = "PLN: \(pln) "
                                }
                                
                                if let dkk = rates ["DKK"] as? Double {
                                    self.dkkLabel.text = "DKK: \(dkk) "
                                }
                                
                                if let turkish = rates ["TRY"] as? Double {
                                    self.tryLabel.text = "TÜRK LİRASI: \(turkish) "
                                }
                                
                            
                            }
                        }
                        
                    } catch {
                        print("Error")
                    }
                    
                    
                    
                    
                }
            }
            
        }
        
        task.resume()
        
        
    }
}

