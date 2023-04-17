//
//  NetworkDataFetcher.swift
//  CardsList
//
//  Created by Вадим Гамзаев on 17.04.2023.
//

import Foundation

protocol INetworkDataFetcher {
	func fetchData(offset: Int, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

class CardsDataFetcher: INetworkDataFetcher {
	
	var networkService: NetworkService!
	
	init(networkService: NetworkService = NetworkService()) {
		self.networkService = networkService
	}

	private let baseURL = "http://dev.bonusmoney.pro/mobileapp/"
	private let tokenHeader = ["TOKEN": "123"]
	
	
	func fetchData(offset: Int, completion: @escaping (Result<Data, NetworkError>) -> Void) {
		let urlString = baseURL + "getAllCompaniesIdeal"
		let parameters: [String: Any] = ["offset": offset]
		
		
	}

	
	//	private let baseURL = "http://dev.bonusmoney.pro/mobileapp/"
	//	private let tokenHeader = ["TOKEN": "123"]

	//	func getAllCompanies(offset: Int, completion: @escaping (Result<Data, NetworkError>) -> Void) {
	//		let urlString = baseURL + "getAllCompaniesIdeal"
	//		let parameters: [String: Any] = ["offset": offset]
	//
	//		sendRequest(urlString: urlString, parameters: parameters, completion: completion)
	//	}
}
