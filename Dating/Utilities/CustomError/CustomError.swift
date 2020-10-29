//
//  CustomError.swift
//  Dating
//
//  Created by Agil Madinali on 10/27/20.
//

enum CustomError: Error {
    case badImageUrl
    case couldNotDownloadImage
    case couldNotUnwrapImage
    case failedFetchingData
    case noUsersFound
}
