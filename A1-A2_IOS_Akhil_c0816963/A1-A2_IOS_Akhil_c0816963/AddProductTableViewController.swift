//
//  AppDelegate.swift
//  A1-A2_IOS_Akhil_c0816963
//
//  Created by Akhil Madishetty on 19/09/21.
//
import UIKit
import CoreData
class AddProductTableViewController: UITableViewController {
    let context =
            (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productDesc: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var typeProviderName: UITextField!
    var providerTab : Product?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selected = providerTab{
            id.text = selected.productID
            productName.text = selected.productName
            productDesc.text = selected.productDesc
            price.text = selected.productPrice
            typeProviderName.text = selected.productName
        }

    }

    @IBAction func save(_ sender: Any) {
        let requests : NSFetchRequest<Provider> = Provider.fetchRequest()
        requests.predicate = NSPredicate(format: "provider = '\(typeProviderName.text!)'")
        let collectprovider = try! context.fetch(requests)
        var provider : Provider!
        if collectprovider.count == 0{
             provider = Provider(context: context)
             provider.provider = typeProviderName.text
        }
        else{
             provider = collectprovider[0]
        }
        if let selected = providerTab{
            selected.productDesc = productDesc.text
            selected.productID = id.text
            selected.productName = productName.text
            selected.productPrice = price.text
            selected.provider = provider
        }
        else{
            let product = Product(context: context)
            product.productDesc = productDesc.text
            product.productID = id.text
            product.productName = productName.text
            product.productPrice = price.text
            product.provider = provider
        }
        try! context.save()
        id.text = nil
        productDesc.text = nil
        productName.text = nil
        price.text = nil
        typeProviderName.text = nil
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }


}
