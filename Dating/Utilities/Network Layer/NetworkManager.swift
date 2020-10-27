//
//  NetworkManager.swift
//  Dating
//
//  Created by Agil Madinali on 10/25/20.
//

import UIKit

class NetworkManager {
    
    // MARK: Singleton pattern
    static let manager = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() { }
    
    // MARK: URL Session to get data from server
    
    // swiftlint:disable:next variable_name
    func request<T: Decodable>(_ t: T.Type, completion: @escaping (Result<T, CustomError>) -> Void) {
        
        guard let url = URL(string: "https://randomuser.me/api/?results=100") else { return }
        URLSession.shared.dataTask(with: url) { data, response, _ in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else { return }
            
            do {
                let objData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(objData))
                }
            } catch {
                completion(.failure(.failedFetchingData))
            }
        }.resume()
    }
    
    func downloadImage(with urlString: String, completion: @escaping (Result<UIImage?, CustomError>) -> Void) {
    
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completion(.success(image))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badImageUrl))
            return
        }
    
        do {
            let data = try Data(contentsOf: url)
            if let image = UIImage(data: data) {
                cache.setObject(image, forKey: cacheKey)
                completion(.success(image))
            } else {
                completion(.failure(.couldNotUnwrapImage))
            }
        } catch {
            completion(.failure(.couldNotDownloadImage))
        }
    }
}
