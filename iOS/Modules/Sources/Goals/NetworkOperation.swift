//
//  SwiftUIView.swift
//  
//
//  Created by Gabriel Soria Souza on 12/03/21.
//

import UIKit

typealias ImageOperationCompletion = ((Data?, URLResponse?, Error?) -> Void)?

final class NetworkImageOperation: AsyncOperation {
    var image: UIImage?
    
    private let url: URL
    private let completion: ImageOperationCompletion
    
    init(
        url: URL,
        completion: ImageOperationCompletion = nil) {
        
        self.url = url
        self.completion = completion
        
        super.init()
    }
    
    convenience init?(
        string: String,
        completion: ImageOperationCompletion = nil) {
        
        guard let url = URL(string: string) else { return nil }
        self.init(url: url, completion: completion)
    }
    
    override func main() {
        #if DEBUG
        self.placeholderImage()
        #else
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            defer { self.state = .finished }
            
            if let completion = self.completion {
                completion(data, response, error)
                return
            }
            
            guard error == nil, let data = data else { return }
            
            self.image = UIImage(data: data)
        }.resume()
        #endif
    }
    
    private func placeholderImage() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            defer { self.state = .finished }
            guard let urlPlaceholder = Bundle.module.url(forResource: "placeholder",
                                                          withExtension: "jpeg"),
                  let img = try? Data(contentsOf: urlPlaceholder) else {
                return
            }
            
            let image = UIImage(data: img)
            self.image = image
        }
    }
    
    private func resizedImage() -> CGImage? {
        let nsURL = self.url as NSURL
        guard let imageSource = CGImageSourceCreateWithURL(nsURL,
                                                           nil) else {
            return nil
        }
        
        let _ = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil)
        let option: [NSString: Any] = [
            kCGImageSourceThumbnailMaxPixelSize: 100,
            kCGImageSourceCreateThumbnailFromImageAlways: true
        ]
        let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, option as CFDictionary)
        return scaledImage
    }
}
