//
//  ServiceHandler.swift
//  HappyKids
//
//  Created by Mac on 12/9/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

let BASEURL = ""
let BASEURLOurProduct = ""

let imageURL = "https://mobileandwebsitedevelopment.com/dress-app/upload/face_image/"


class ServiceHandler: NSObject {
    
    static let sharedInstance = ServiceHandler()
    
    // Mark : ==================== Post Methode =============================================
    
    func postServiceMethod(params:[String:Any],apiName:String, completion:@escaping ([String: Any]?,Error?)->()){
        let parameters:Parameters=params
        let urlString=URL(string: "\(BASEURL)\(apiName)")
        
        
        
//        Alamofire.request(urlString!, method: .post, parameters: parameters).responseJSON { response in
      Alamofire.request(urlString!, method: .post, parameters: params).responseJSON
      {
        response in
           
            switch (response.result)
            {
            case .success(_):
                if response.value != nil
                {
                    let result = response.value as! [String : Any]
                    
                    completion(result,nil)
                }
                
            case.failure(_):
                print("Error message : \(String(describing: response.error))")
                let error = response.error
                completion(nil,error)
                
                break
            }
        }
    }

   
  func abcd(abc:String, completion:@escaping([String]?, Error?) -> ()) {
    print(abc)
    completion([abc],nil)
  }
    
    
    //===============********************Get api service method********************===============
    
    func getServiceMethod(params : [String:Any],apiName:String,completion: @escaping ([String: Any]?, Error?) ->()) {

        let parameters:Parameters=params
        let urlString=URL(string: "\(BASEURL)\(apiName)")
        print("\(BASEURL)\(apiName)")
        //Alamofire.request(urlString!,method: .get, parameters:parameters).responseJSON { response in
        Alamofire.request(urlString!,method: .get, parameters:parameters).responseJSON { response in
            switch (response.result)
            {
            case .success(_):
                if response.value != nil
                {
                    let result = response.value as! [String : Any]
                    
                    completion(result,nil)
                }
                
            case.failure(_):
                print("Error message : \(String(describing: response.error))")
                let error = response.error
                completion(nil,error)
                
                break
            }
        }
    }
  
  func getServiceMethodModelWise(params : [String:Any],apiName:String,completion: @escaping (Data?, Error?) ->()) {
    
    let parameters:Parameters=params
    let urlString=URL(string: "\(BASEURL)\(apiName)")
    print("\(BASEURL)\(apiName)")
    //Alamofire.request(urlString!,method: .get, parameters:parameters).responseJSON { response in
    Alamofire.request(urlString!,method: .get, parameters:parameters).responseJSON { response in
      switch (response.result)
      {
      case .success(_):

          if let data = response.data
          {
            completion(data, nil)
          }

      case.failure(_):
        print("Error message : \(String(describing: response.error))")
        let error = response.error
        completion(nil,error)
        
        break
      }
    }
  }
  
  func getServiceMethodModelWise2(params : [String:Any],apiName:String,completion: @escaping (Data?, Error?) ->()) {
    
    let parameters:Parameters=params
    let urlString=URL(string: "\(BASEURLOurProduct)\(apiName)")
    print("\(BASEURLOurProduct)\(apiName)")
    //Alamofire.request(urlString!,method: .get, parameters:parameters).responseJSON { response in
    Alamofire.request(urlString!,method: .get, parameters:parameters).responseJSON { response in
      switch (response.result)
      {
      case .success(_):
        
        if let data = response.data
        {
          completion(data, nil)
        }
        
      case.failure(_):
        print("Error message : \(String(describing: response.error))")
        let error = response.error
        completion(nil,error)
        
        break
      }
    }
  }
    
    
    func getServiceMethodTwo(params : [String:Any],apiName:String,completion: @escaping ([Any]?, Error?) ->()) {

        let parameters:Parameters=params
        let urlString=URL(string: "\(BASEURL)\(apiName)")
        print("\(BASEURL)\(apiName)")
        //Alamofire.request(urlString!,method: .get, parameters:parameters).responseJSON { response in
        Alamofire.request(urlString!,method: .get, parameters:parameters).responseJSON { response in
            switch (response.result)
            {
            case .success(_):
                if response.value != nil
                {
                    let result = response.value as! [Any]
                    
                    completion(result,nil)
                }
                
            case.failure(_):
                print("Error message : \(String(describing: response.error))")
                let error = response.error
                completion(nil,error)
                
                break
            }
        }
    }
    
    func getServiceMethodPayment(params : [String:Any],apiName:String,completion: @escaping ([String: Any]?, Error?) ->()) {

            let parameters:Parameters=params
            let urlString=URL(string: "http://mobileandwebsitedevelopment.com/clavesgame/front/\(apiName)")

            Alamofire.request(urlString!,method: .get, parameters:parameters).responseJSON { response in
    //        Alamofire.request(urlString!,method: .get, parameters:parameters).responseJSON { response in
                switch (response.result)
                {
                case .success(_):
                    if response.value != nil
                    {
                        let result = response.value as! [String : Any]
                        
                        completion(result,nil)
                    }
                    
                case.failure(_):
                    print("Error message : \(String(describing: response.error))")
                    let error = response.error
                    completion(nil,error)
                    
                    break
                }
            }
        }
    
    
    
      //===============********************upload with Image service method********************===============
       
        func uploadServiceMethod(params : [String:Any], image:UIImage,apiName:String,imageName:String, completion: @escaping ([String: Any]?, Error?) ->())
         {
             let parameters:Parameters=params
             let urlString=URL(string: "\(BASEURL)\(apiName)")
            let imageData=image.jpegData(compressionQuality: 0.5)
             
             Alamofire.upload(multipartFormData:
                 {
                     (multipartFormData) in
                     multipartFormData.append(imageData!, withName: imageName , fileName: "file.jpeg", mimeType: "image/jpeg")
                     for (key, value) in parameters
                     {
                         multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                     }
             }, to:urlString!,headers:nil)
             { (result) in
                 switch result
                 {
                 case .success(let upload,_,_ ):
                     upload.uploadProgress(closure: { (progress) in
                         //Print progress
                     })
                     upload.responseJSON
                         { response in
                             
                             if response.result.value != nil
                             {
                                 let resultDict :NSDictionary = response.result.value! as! NSDictionary
                                 completion(resultDict as? [String : Any] ,nil)
                             }
                     }
                 case .failure(_):
                     
                     completion(nil,result as? Error)
                     break
                 }
             }
         }
    
      //===============********************upload with two Images service method********************===============
        
        //func uploadTwoImageServiceMethod(params : [String:Any], image:UIImage,imageSec:UIImage,imageThird:UIImage,imageFourth:UIImage,imageFifth:UIImage,apiName:String,imageName:String,imageNameSec:String,imageNameThird:String,imageNameFourth:String,imageNameFifth:String,completion: @escaping ([String: Any]?, Error?) ->())
        func uploadTwoImageServiceMethod(params : [String:Any], image:UIImage,imageSec:UIImage,apiName:String,imageName:String,imageNameSec:String,completion: @escaping ([String: Any]?, Error?) ->())
        {
            
            let parameters:Parameters=params
            let urlString=URL(string: "\(BASEURL)\(apiName)")
            
            
            let imageData=image.jpegData(compressionQuality: 0.5)
            let imageDataSec = imageSec.jpegData(compressionQuality: 0.5)
            
//             let imageDataTh = imageThird.jpegData(compressionQuality: 0.5)
//             let imageDataFth = imageFourth.jpegData(compressionQuality: 0.5)
//             let imageDataFiv = imageFifth.jpegData(compressionQuality: 0.5)
    //         let imageDataSix = imageSixth.jpegData(compressionQuality: 0.5)
    //         let imageDataSeven = imageSeventh.jpegData(compressionQuality: 0.5)
    //         let imageDataEight = imageSec.jpegData(compressionQuality: 0.5)
            
            
            Alamofire.upload(multipartFormData:
                {
                    (multipartFormData) in
                    multipartFormData.append(imageData!, withName: imageName , fileName: "file.jpeg", mimeType: "image/jpeg")
                    multipartFormData.append(imageDataSec!, withName: imageNameSec, fileName: "file.jpeg", mimeType: "image/jpeg")
//                    multipartFormData.append(imageDataTh!, withName: imageNameThird, fileName: "file.jpeg", mimeType: "image/jpeg")
//                    multipartFormData.append(imageDataFth!, withName: imageNameFourth, fileName: "file.jpeg", mimeType: "image/jpeg")
//                    multipartFormData.append(imageDataFiv!, withName: imageNameFifth, fileName: "file.jpeg", mimeType: "image/jpeg")
    //                multipartFormData.append(imageDataSix!, withName: imageNameSixth, fileName: "file.jpeg", mimeType: "image/jpeg")
    //                multipartFormData.append(imageDataSeven!, withName: imageNameSeventh, fileName: "file.jpeg", mimeType: "image/jpeg")
    //                multipartFormData.append(imageDataEight!, withName: imageNameEight, fileName: "file.jpeg", mimeType: "image/jpeg")
                                                    
                    
                    for (key, value) in parameters
                    {
                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }
            }, to:urlString!,headers:nil)
            { (result) in
                switch result
                {
                case .success(let upload,_,_ ):
                    upload.uploadProgress(closure: { (progress) in
                        //Print progress
                    })
                    
                    print(upload.responseJSON)
                    upload.responseJSON
                        { response in
                            
                            
                            if response.result.value != nil
                            {
                                let resultDict :NSDictionary = response.result.value! as! NSDictionary
                                completion(resultDict as? [String : Any] ,nil)
                            }
                    }
                case .failure(_):
                    
                    completion(nil,result as? Error)
                    break
                }
            }
        }




      
    
}


let downloader = ImageDownloader()
extension UIImageView {
    
    
    
    func loadImage(url: NSURL,placeholderImage:UIImage){
        
        //let downloader = ImageDownloader()
        let urlRequest = URLRequest(url: url as URL)
        downloader.download(urlRequest) { response in
            print(response.request as Any)
            print(response.response as Any)
            debugPrint(response.result)
            
            if let image = response.value {
                self.image=image
            }
            else
            {
                self.image = placeholderImage
            }
        }
    
    }
}

