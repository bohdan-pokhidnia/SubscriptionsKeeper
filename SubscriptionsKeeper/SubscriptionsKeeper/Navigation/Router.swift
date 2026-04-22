//
//  Router.swift
//  SubscriptionsKeeper
//
//  Created by Bohdan Pokhidnia on 18.04.2026.
//

protocol Router {
    func push(_ route: any Hashable)
    func present(_ route: any Hashable)
    func pop()
    func popToRoot()
    func dismiss()
}
