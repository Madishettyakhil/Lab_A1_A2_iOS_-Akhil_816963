//
//  AppDelegate.swift
//  A1-A2_IOS_Akhil_c0816963
//
//  Created by Akhil Madishetty on 19/09/21.
//

import UIKit
import CoreData

class AddProviderViewController: UIViewController {
    let context =
            (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var providertype: UITextField!
    var providertabed : Provider?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selected = providertabed{
            providertype.text = selected.provider
        }

    }
    
    @IBAction func save(_ sender: Any) {
        if let selected = providertabed{
            selected.provider = providertype.text
        }
        else{
            let requests : NSFetchRequest<Provider> = Provider.fetchRequest()
            requests.predicate = NSPredicate(format: "provider = '\(providertype.text!)'")
            let collectProvider = try! context.fetch(requests)
            if collectProvider.count == 0{
                let provider = Provider(context: context)
                provider.provider = providertype.text
                
                providertype.text = nil
            }
        }
        
        try! context.save()
    }
   
}
