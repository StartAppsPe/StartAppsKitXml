
//
//  XmlExtensions.swift
//  StartAppsKitXmlPackageDescription
//
//  Created by Gabriel Lanata on 16/10/17.
//

import Foundation
import AEXML

extension AEXMLElement {
    func getChild(_ key: String) throws -> AEXMLElement {
        return try self[key].first.tryUnwrap(errorMessage: "Valor \(key) no encontrado")
    }
    func getChildren(_ key: String) -> [AEXMLElement] {
        return self[key].children
    }
    func getString(_ key: String, minSize: Int = 1) throws -> String {
        let stringValue = try self[key].value.tryUnwrap(errorMessage: "Valor \(key) no encontrado")
        return try stringValue.cleaned(minSize: minSize).tryUnwrap(errorMessage: "Valor \(key) vacío")
    }
    func getStringOptional(_ key: String, minSize: Int = 1) -> String? {
        return self[key].value?.cleaned(minSize: minSize)
    }
    func getInt(_ key: String) throws -> Int {
        let stringValue = try getString(key)
        return try Int(stringValue).tryUnwrap(errorMessage: "Valor \(key) no es numérico")
    }
    func getIntOptional(_ key: String) -> Int? {
        if let stringValue = getStringOptional(key) {
            return Int(stringValue)
        }
        return nil
    }
    func getNumber(_ key: String) throws -> NSNumber {
        return try getInt(key) as NSNumber
    }
    func getNumberOptional(_ key: String) -> NSNumber? {
        return getIntOptional(key) as NSNumber?
    }
}

