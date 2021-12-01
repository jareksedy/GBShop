//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Ярослав on 01.12.2021.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
