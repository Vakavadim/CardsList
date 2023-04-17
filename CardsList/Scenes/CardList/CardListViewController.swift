//
//  ViewController.swift
//  CardsList
//
//  Created by Вадим Гамзаев on 15.04.2023.
//

import UIKit

class CardsListViewController: UIViewController {
	
	let networkManager: INetworkManager
	
	init(networkManager: INetworkManager) {
		self.networkManager = networkManager
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		networkManager.getAllCompanies(offset: 4) { [weak self] result in
			DispatchQueue.main.async {
				switch result {
				case .success(let data):
					do {
						let decoder = JSONDecoder()
						let companies = try decoder.decode([CompanyResponse].self, from: data)
						companies.map {
							print($0.mobileAppDashboard.companyName)
						}
					} catch {
						print("Ошибка декодирования JSON: \(error)")
					}
				case .failure(let error):
					self?.handleError(error)
				}
			}
		}
	}
	
	private func handleError(_ error: NetworkError) {
		var message: String

		switch error {
		case .unauthorized:
			message = "Ошибка авторизации"
		case .badRequest(let errorMessage):
			message = errorMessage
		case .serverError:
			message = "Все упало"
		}

		showAlert(message: message)
	}

	private func showAlert(message: String) {
		let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
		present(alertController, animated: true, completion: nil)
	}
}
