//
//  NetworkManager.swift
//  CardsList
//
//  Created by Вадим Гамзаев on 15.04.2023.
//

import Foundation

protocol INetworkService {
}

enum NetworkError: Error {
	case unauthorized
	case badRequest(String)
	case serverError
}

class NetworkService: INetworkService {
	
//	private let baseURL = "http://dev.bonusmoney.pro/mobileapp/"
//	private let tokenHeader = ["TOKEN": "123"]

//	func getAllCompanies(offset: Int, completion: @escaping (Result<Data, NetworkError>) -> Void) {
//		let urlString = baseURL + "getAllCompaniesIdeal"
//		let parameters: [String: Any] = ["offset": offset]
//
//		sendRequest(urlString: urlString, parameters: parameters, completion: completion)
//	}
	
	// построение запроса данных по URL
	func postRequestWithToken(
		urlString: String,
		token: [String: String],
		parameters: [String: Any],
		completion: @escaping (Result<Data, NetworkError>) -> Void
	) {
		guard let url = URL(string: urlString) else {return}
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.allHTTPHeaderFields = token
		request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
		
		// вызов функции createDataTask для создания URLSession dataTask
		let task = createDataTask(from: request) { response in
			DispatchQueue.main.async {
				completion(response)
			}
		}
		task.resume()
	}
	
	// создание URLSession dataTask
	private func createDataTask(
		from request: URLRequest,
		completion: @escaping (Result<Data, NetworkError>) -> Void
	) -> URLSessionDataTask {
		return URLSession.shared.dataTask(with: request) { data, response, _ in
			guard let httpResponse = response as? HTTPURLResponse, let data = data else {
				completion(.failure(.serverError))
				return
			}

			switch httpResponse.statusCode {
			case 200: // swiftlint:disable:this numbers_smell
				completion(.success(data))
			case 401: // swiftlint:disable:this numbers_smell
				completion(.failure(.unauthorized))
			case 400: // swiftlint:disable:this numbers_smell
				let message = String(data: data, encoding: .utf8) ?? ""
				completion(.failure(.badRequest(message)))
			default:
				completion(.failure(.serverError))
			}
		}
	}

//	private func sendRequest(
//		urlString: String,
//		parameters: [String: Any],
//		completion: @escaping (Result<Data, NetworkError>) -> Void
//	) {
//		guard let url = URL(string: urlString) else { return }
//
//		var request = URLRequest(url: url)
//		request.httpMethod = "POST"
//		request.allHTTPHeaderFields = tokenHeader
//		request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
//
//		let task = URLSession.shared.dataTask(with: request) { data, response, _ in
//			guard let httpResponse = response as? HTTPURLResponse, let data = data else {
//				completion(.failure(.serverError))
//				return
//			}
//
//			switch httpResponse.statusCode {
//			case 200:
//				completion(.success(data))
//			case 401:
//				completion(.failure(.unauthorized))
//			case 400:
//				let message = String(data: data, encoding: .utf8) ?? ""
//				completion(.failure(.badRequest(message)))
//			default:
//				completion(.failure(.serverError))
//			}
//		}
//
//		task.resume()
//	}
}
