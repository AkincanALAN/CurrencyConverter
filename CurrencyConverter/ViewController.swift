//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Akıncan ALAN on 7/30/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    
    @IBOutlet weak var basedCurrencyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        basedCurrencyLabel.text = "Based : EUR"
    }
    
    @IBAction func getRatesCilcked(_ sender: Any) {
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=d7d14301df3a1b2ce323cc8878877c65")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(self, animated: true)
                
            } else {
                
                if data != nil {
                    //data taken
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        
                        DispatchQueue.main.async {
                            
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                
                                if let usd = rates["USD"] {
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                
                                if let turkish = rates["TRY"] {
                                    self.tryLabel.text = "TRY : \(turkish)"
                                }
                                
                                if let jpy = rates["JPY"] {
                                    self.jpyLabel.text = "JPY : \(jpy)"
                                }
                                
                                if let cad = rates["CAD"] {
                                    self.cadLabel.text = "CAD : \(cad)"
                                }
                                
                                if let gbp = rates["GBP"] {
                                    self.gbpLabel.text = "GBP : \(gbp)"
                                }
                                
                                if let chf = rates["CHF"] {
                                    self.chfLabel.text = "CHF : \(chf)"
                                }
                                
                            }

                        }
                        
                    } catch {
                        print("error")
                    }
                }
            }
        }
        
        task.resume()
        
    }

}

// The base currency should be changeable in V2.
