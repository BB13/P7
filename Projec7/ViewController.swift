//
//  ViewController.swift
//  Projec7
//
//  Created by Billy Benson on 5/31/17.
//  Copyright © 2017 Billy Benson. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [[String: String]]() //creaetes an array of dictionaries
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                
                if json["metadata"]["responseinfo"]["status"].intValue == 200 {
                    
                    //we're ok to parse .. aka convert the JSON into JavaSctipt DATA
                    parse(json: json)
                }
            }
        }
    
    }
    
    func parse(json: JSON) {  //L97 @ 9 mins
        
        for result in json["results"].arrayValue {
            
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title" : title, "body" : body, "sigs" : sigs]
      
            petitions.append(obj)
        }
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return petitions.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel? .text = "Title goes here"
        cell.detailTextLabel?.text = "Subtitle goes here"
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

