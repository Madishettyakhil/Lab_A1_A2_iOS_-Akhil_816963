//
//  ProductDetailsVC.swift
//
//
//  Created by Akhil Madishetty on 19/09/21.
//

import UIKit

class ProductDetailsVC: UIViewController {

    @IBOutlet weak var productidLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var productPriceLbl: UILabel!
    @IBOutlet weak var productProviderLbl: UILabel!
    @IBOutlet weak var productDescLbl: UILabel!
    
    var details = Product()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Product Details"
        productidLbl.text = "Product ID: \(details.prodID)"
        productNameLbl.text = "Product Name: \(details.prodName!)"
        productProviderLbl.text = "Product Provider: \(details.prodProvider!)"
        productPriceLbl.text = "Product Price: $ \(details.prodPrice!)"
        productDescLbl.text = "Product Description: \(details.prodDesc!)"
    }

}
