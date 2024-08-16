//
//  ImageNetwork.swift
//  Muda
//
//  Created by Bowon Han on 8/16/24.
//

import UIKit

final class ImageNetwork {
    static func requestImageURL(data: String?, imageView: UIImageView) {
        guard let imageUrl = data else { return }
        guard let url = URL(string: imageUrl) else { return }
        
        let backgroundQueue = DispatchQueue(label: "background_queue",qos: .background)
        
        backgroundQueue.async {
            guard let data = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
    }
}
