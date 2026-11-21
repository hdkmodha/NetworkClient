//
//  Constants.swift
//
//
//  Created by Hardik Modha on 09/12/23.
//

import Foundation

public enum Constants {
    public enum ErrorMessage {
        public static let successMessage = "Everything worked as expected"
        public static let badRequestMessage = "The request was unacceptable, often due to missing a required parameter."
        public static let invalidTokenMessage = "Invalid Access Token"
        public static let forbiddenMessage = "Missing permissions to perform request"
        public static let notFoundMessage = "The requested resource doesn’t exist"
        public static let internalServerError = "Server Not Found"
        public static let serviceUnavailableMessage = "Something went wrong on our end"
        public static let jsonNotParseMessage = "Response can not parse"
    }
}
