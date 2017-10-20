
//
//  XmlExtensions.swift
//  StartAppsKitXmlPackageDescription
//
//  Created by Gabriel Lanata on 16/10/17.
//

import Foundation
import AEXML

extension AEXMLElement {
    
    public func getChild(_ key: String) throws -> AEXMLElement {
        return try self[key].first.tryUnwrap(errorMessage: "Valor \(key) no encontrado")
    }
    
    public func getChildren(_ key: String) -> [AEXMLElement] {
        return self[key].children
    }
    
    public func getAll(_ key: String) -> [AEXMLElement] {
        return self[key].all ?? []
    }
    
    public func getString(_ key: String, minSize: Int = 1) throws -> String {
        let stringValue = try self[key].value.tryUnwrap(errorMessage: "Valor \(key) no encontrado")
        return try stringValue.cleaned(minSize: minSize).tryUnwrap(errorMessage: "Valor \(key) vacío")
    }
    
    public func getStringOptional(_ key: String, minSize: Int = 1) -> String? {
        return self[key].value?.cleaned(minSize: minSize)
    }
    
    public func getInt(_ key: String) throws -> Int {
        let stringValue = try getString(key)
        return try Int(stringValue).tryUnwrap(errorMessage: "Valor \(key) no es número entero")
    }
    
    public func getIntOptional(_ key: String) -> Int? {
        if let stringValue = getStringOptional(key) {
            return Int(stringValue)
        }
        return nil
    }
    
    public func getDouble(_ key: String) throws -> Double {
        let stringValue = try getString(key)
        return try Double(stringValue).tryUnwrap(errorMessage: "Valor \(key) no es numérico")
    }
    
    public func getDoubleOptional(_ key: String) -> Double? {
        if let stringValue = getStringOptional(key) {
            return Double(stringValue)
        }
        return nil
    }
    
    public func getNumber(_ key: String) throws -> NSNumber {
        return try getDouble(key) as NSNumber
    }
    
    public func getNumberOptional(_ key: String) -> NSNumber? {
        return getDoubleOptional(key) as NSNumber?
    }
    
    public func getDecimalNumber(_ key: String) throws -> NSDecimalNumber {
        return try getDouble(key) as NSDecimalNumber
    }
    
    public func getDecimalNumberOptional(_ key: String) -> NSDecimalNumber? {
        return getDoubleOptional(key) as NSDecimalNumber?
    }
    
}

