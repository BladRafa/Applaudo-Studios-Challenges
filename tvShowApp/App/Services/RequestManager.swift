//
//  RequestManager.swift
//  tvShowApp
//
//  Created by Walter Bladimir Rafael on 22/2/21.
//


import UIKit

class RequestManager: NSObject {

    static let sharedService = RequestManager()
    
    typealias WebServiceCompletionBlock = (_ data: [String:AnyObject]?,_ error: Error?) -> Void
    
    func requestAPI(url: String,parameter: [String: Any]?, httpMethodType: Constants.HTTPMethodType, completion: @escaping WebServiceCompletionBlock) {
      
        let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        var request = URLRequest(url: URL(string: escapedAddress!)!)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        
        switch httpMethodType {
            case .POST:
                request.httpMethod = Constants.HTTPMethod.POST.rawValue
            default:
                request.httpMethod = Constants.HTTPMethod.GET.rawValue
        }
        
        if parameter != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameter as Any, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
          
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != Constants.HTTPStatusCodes.OK.rawValue {
                // check for http errors
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    completion(json as [String : AnyObject],nil)
                }
            } catch let error {
                print(error.localizedDescription)
                completion(nil,error)
            }
        }
        task.resume()
    }
}
