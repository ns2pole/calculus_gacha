import Foundation
import StoreKit
import Flutter

class StoreKitTest: NSObject, SKProductsRequestDelegate {
    private var productsRequest: SKProductsRequest?
    private var result: FlutterResult?
    
    func testProductRequest(productId: String, result: @escaping FlutterResult) {
        self.result = result
        
        let productIds = Set([productId])
        let request = SKProductsRequest(productIdentifiers: productIds)
        request.delegate = self
        self.productsRequest = request
        
        print("StoreKitTest: Requesting product: \(productId)")
        request.start()
    }
    
    // MARK: - SKProductsRequestDelegate
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("StoreKitTest: Received \(response.products.count) products")
        
        if response.products.isEmpty {
            print("StoreKitTest: No products found")
            print("StoreKitTest: Invalid product IDs: \(response.invalidProductIdentifiers)")
            
            let errorMessage = "No products found. Invalid IDs: \(response.invalidProductIdentifiers.joined(separator: ", "))"
            result?(["success": false, "error": errorMessage])
            return
        }
        
        for product in response.products {
            print("StoreKitTest: Found product:")
            print("  - Product ID: \(product.productIdentifier)")
            print("  - Localized Title: \(product.localizedTitle)")
            print("  - Localized Description: \(product.localizedDescription)")
            print("  - Price: \(product.price)")
            print("  - Price Locale: \(product.priceLocale?.identifier ?? "nil")")
            print("  - Localized Price: \(product.localizedPrice ?? "nil")")
        }
        
        let firstProduct = response.products.first!
        result?([
            "success": true,
            "productId": firstProduct.productIdentifier,
            "title": firstProduct.localizedTitle,
            "description": firstProduct.localizedDescription,
            "price": firstProduct.price.doubleValue,
            "priceLocale": firstProduct.priceLocale?.identifier ?? "",
            "localizedPrice": firstProduct.localizedPrice ?? ""
        ])
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        print("StoreKitTest: Request failed with error: \(error.localizedDescription)")
        result?(["success": false, "error": error.localizedDescription])
    }
}

extension SKProduct {
    var localizedPrice: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price)
    }
}

