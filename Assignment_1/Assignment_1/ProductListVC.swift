//
//  ProductListVC.swift
//
//
//  Created by Akhil Madishetty on 19/09/21.
//

import UIKit

class ProductListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    private var productData = [Product]()
    var filteredCandies: [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Products List"
        
            navigationItem.hidesSearchBarWhenScrolling = false
            navigationItem.searchController = searchController
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search Products")
        
        searchController.searchBar.tintColor = UIColor.black
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancel"
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        checkExitData()
        
        filteredCandies = productData
    
    }
    
    func getAllItems() {
        do {
            productData = try context.fetch(Product.fetchRequest())
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch {
            //error
        }
    }
    
    func createItem(productId: Int, productName: String, productDescription: String, productPrice: String, productProvider: String) {
        
        let newItem = Product(context: context)
        newItem.prodID = Int64(productId)
        newItem.prodName = productName
        newItem.prodPrice = productPrice
        newItem.prodProvider = productProvider
        newItem.prodDesc = productDescription
        
        do {
            try context.save()
            getAllItems()
        }
        catch {
            //error
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCandies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let product = filteredCandies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(product.prodName!)"
        cell.detailTextLabel?.text = "\(product.prodProvider!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = filteredCandies[indexPath.row]
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        vc.details = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // add data
    func addProductData()  {
        
        createItem(productId: 123, productName: "Product1", productDescription: "", productPrice: "33.00", productProvider: "Apple")
        createItem(productId: 245, productName: "Product2", productDescription: "Test Description1", productPrice: "38.00", productProvider: "Ionic")
        createItem(productId: 345, productName: "Product3", productDescription: "Test Description2", productPrice: "17.00", productProvider: "Apple")
        createItem(productId: 456, productName: "Product4", productDescription: "Test Description3", productPrice: "20.00", productProvider: "google")
        createItem(productId: 567, productName: "Product5", productDescription: "Test Description4", productPrice: "25.00", productProvider: "google")
        
        createItem(productId: 678, productName: "Product6", productDescription: "Test Description5", productPrice: "40.00", productProvider: "Microsoft")
        createItem(productId: 789, productName: "Product7", productDescription: "Test Description6", productPrice: "38.00", productProvider: "Microsoft")
        createItem(productId: 890, productName: "Product8", productDescription: "Test Description7", productPrice: "46.00", productProvider: "IBM")
        createItem(productId: 9, productName: "Product9", productDescription: "Test Description8", productPrice: "50.00", productProvider: "IBM")
        createItem(productId: 100, productName: "Product10", productDescription: "Test Description9", productPrice: "35.00", productProvider: "Samsung")
    }
    
    
    func checkExitData() {
        do {
            productData = try context.fetch(Product.fetchRequest())
            if (productData.count == 0) {
                addProductData()
            }else {
                getAllItems()
            }
        }
        catch {
            //error
        }
    }
    
    
}

extension ProductListVC: UISearchResultsUpdating {
    

    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == "" {
            filteredCandies = productData
        } else {
            filteredCandies = productData.filter { $0.prodName!.lowercased().contains(searchController.searchBar.text!.lowercased()) }
            if filteredCandies.isEmpty{
              
                filteredCandies = productData.filter { $0.prodProvider!.lowercased().contains(searchController.searchBar.text!.lowercased()) }
            }
            }

        self.tableView.reloadData()
    }
   
}

