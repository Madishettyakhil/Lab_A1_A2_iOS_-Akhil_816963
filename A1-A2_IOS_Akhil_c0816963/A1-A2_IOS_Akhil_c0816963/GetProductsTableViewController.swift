//
//  AppDelegate.swift
//  A1-A2_IOS_Akhil_c0816963
//
//  Created by Akhil Madishetty on 19/09/21.
//
import UIKit
import CoreData

class GetProductsTableViewController: UITableViewController {
    var providertabed : Provider?
    var Aproducts : [Product] = []
    let mngcontext =
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = providertabed{
            let requests : NSFetchRequest<Product> =  Product.fetchRequest()
            Aproducts = try! mngcontext.fetch(requests)
            Aproducts = Aproducts.filter({$0.provider?.provider == providertabed?.provider})
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Aproducts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text =
            Aproducts[indexPath.row].productName
        cell.detailTextLabel?.text = Aproducts[indexPath.row].provider?.provider

        return cell
    }
    

}
