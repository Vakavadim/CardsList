//
//  NetworkManager.swift
//  CardsList
//
//  Created by Вадим Гамзаев on 15.04.2023.
//

import Foundation

protocol INetworkManager {
	func getAllCompanies(offset: Int, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

enum NetworkError: Error {
	case unauthorized
	case badRequest(String)
	case serverError
}

class NetworkManager: INetworkManager {
	
	init() {}

	private let baseURL = "http://dev.bonusmoney.pro/mobileapp/"
	private let tokenHeader = ["TOKEN": "123"]

	func getAllCompanies(offset: Int, completion: @escaping (Result<Data, NetworkError>) -> Void) {
		let urlString = baseURL + "getAllCompaniesIdeal"
		let parameters: [String: Any] = ["offset": offset]

		sendRequest(urlString: urlString, parameters: parameters, completion: completion)
	}
	
	// построение запроса данных по URL
	func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
		guard let url = URL(string: urlString) else {return}
		let request = URLRequest(url: url)
		
		// вызов функции createDataTask для создания URLSession dataTask
		let task = createDataTask(from: request, completion: completion)
		task.resume()
	}
	
	// создание URLSession dataTask
	private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
		return URLSession.shared.dataTask(with: request) { data, response, error in
			DispatchQueue.main.async {
				completion(data, error)
			}
		}
	}

	private func sendRequest(
		urlString: String,
		parameters: [String: Any],
		completion: @escaping (Result<Data, NetworkError>) -> Void
	) {
		guard let url = URL(string: urlString) else { return }

		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.allHTTPHeaderFields = tokenHeader
		request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])

		let task = URLSession.shared.dataTask(with: request) { data, response, _ in
			guard let httpResponse = response as? HTTPURLResponse, let data = data else {
				completion(.failure(.serverError))
				return
			}

			switch httpResponse.statusCode {
			case 200:
				completion(.success(data))
			case 401:
				completion(.failure(.unauthorized))
			case 400:
				let message = String(data: data, encoding: .utf8) ?? ""
				completion(.failure(.badRequest(message)))
			default:
				completion(.failure(.serverError))
			}
		}

		task.resume()
	}
}
