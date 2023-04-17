//
//  Sizes.swift
//  CardsList
//
//  Created by Вадим Гамзаев on 15.04.2023.
//

import Foundation
import PinLayout

// swiftlint:disable type_name
enum Sizes {
	
	static let cornerRadius: CGFloat = 6
	static let borderWidth: CGFloat = 1
	
	enum Padding {
		static let top: Percent = 33%
		static let half: CGFloat = 8
		static let normal: CGFloat = 16
		static let double: CGFloat = 32
	}
	
	enum L {
		static let maxWidth: Percent = 90%
		static let width: CGFloat = 200
		static let height: CGFloat = 50
	}
	
	enum M {
		static let maxWidth: Percent = 80%
		static let width: CGFloat = 100
		static let height: CGFloat = 40
	}
	
	enum S {
		static let maxWidth: Percent = 70%
		static let width: CGFloat = 80
		static let height: CGFloat = 30
	}
}
// swiftlint:enable type_name
