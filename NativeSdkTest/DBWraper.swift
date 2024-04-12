//
//  DBWraper.swift
//  NativeSdkTest
//
//  Created by Suhail Thajudeen on 12/04/24.
//

import Foundation

struct Configuration:Codable {
    var appID: String
    var origin: String
    var baseURL: String
    var language: String
    var isDefault: Bool
}


class ConfigurationManager {
    static let shared = ConfigurationManager()
    private let userDefaults = UserDefaults.standard
    private let configKey = "SavedConfigurations"
    
    // Save configuration
    func saveConfiguration(config: Configuration) {
        guard !config.appID.isEmpty, !config.origin.isEmpty, !config.baseURL.isEmpty, !config.language.isEmpty else {
            print("Error: Mandatory fields cannot be empty.")
            return
        }
        
        
        
        var savedConfigs = getConfigurations()
        savedConfigs.append(config)
        saveConfigurations(configs: savedConfigs)
    }
    
    // Retrieve configurations
    func getConfigurations() -> [Configuration] {
        guard let configsData = userDefaults.data(forKey: configKey) else {
            return []
        }
        let decoder = JSONDecoder()
        if let savedConfigs = try? decoder.decode([Configuration].self, from: configsData) {
            return savedConfigs
        }
        return []
    }
    
    // Save configurations array
    private func saveConfigurations(configs: [Configuration]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(configs) {
            userDefaults.set(encoded, forKey: configKey)
        }
    }
    
    // Delete configuration at index
    func deleteConfiguration(at index: Int) {
        var savedConfigs = getConfigurations()
        savedConfigs.remove(at: index)
        saveConfigurations(configs: savedConfigs)
    }
    
    func getDefaultConfiguration() -> Configuration? {
        let configurations = getConfigurations()
        return configurations.first { $0.isDefault }
    }
    
    
    func setDefaultConfiguration(at index: Int) {
        var configurations = getConfigurations()
        for i in 0..<configurations.count {
            configurations[i].isDefault = (i == index)
        }
        saveConfigurations(configs: configurations)
    }
}
