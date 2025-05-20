//
//  ViewState.swift
//  FieldFinder-App
//
//  Created by Kevin Heredia on 20/5/25.
//
import Foundation

enum ViewState<T> {
    case idle
    case loading
    case success(T)
    case error(String)
}


extension ViewState {
    var data: T? {
        if case let .success(value) = self {
            return value
        }
        return nil
    }
}

