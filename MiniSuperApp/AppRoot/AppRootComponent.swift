//
//  AppRootComponent.swift
//  MiniSuperApp
//
//  Created by 문효재 on 2022/02/07.
//

import Foundation
import AppHome
import FinanceHome
import ProfileHome
import FinanceRepository
import ModernRIBs
import TransportHome
import TransportHomeImpl
import Topup
import TopupImpl
import AddPaymentMethod
import AddPaymentMethodImpl
import Network
import NetworkImp

final class AppRootComponent: Component<AppRootDependency>, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency, TransportHomeDependency, TopupDependency, AddPaymentMethodDependency {
  let cardOnFileRepository: CardOnFileRepositoryType
  let superPayRepository: SuperPayRepository
  
  lazy var transportHomeBuildable: TransportHomeBuildable = {
    return TransportHomeBuilder(dependency: self)
  }()
  var topupBaseViewController: ViewControllable { rootViewController.topViewControllable }
  
  lazy var topupBuildable: TopupBuildable = {
    return TopupBuilder(dependency: self)
  }()
  
  lazy var addPaymentMethodBuildable: AddPaymentMethodBuildable = {
    return AddPaymentMethodBuilder(dependency: self)
  }()
  
  private let rootViewController: ViewControllable
  
  init(dependency: AppRootDependency,
       rootViewController: ViewControllable
  ) {
    let network = NetworkImp(session: URLSession.shared)
    
    self.cardOnFileRepository = CardOnFileRepository()
    self.superPayRepository = BaseSuperPayRepository(network: network, baseURL: BaseURL().financeBaseURL)
    self.rootViewController = rootViewController
    super.init(dependency: dependency)
  }
}

