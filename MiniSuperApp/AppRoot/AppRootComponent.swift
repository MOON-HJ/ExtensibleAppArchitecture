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

final class AppRootComponent: Component<AppRootDependency>, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency, TransportHomeDependency, TopupDependency  {
  let cardOnFileRepository: CardOnFileRepositoryType
  let superPayRepository: SuperPayRepository
  
  lazy var transportHomeBuildable: TransportHomeBuildable = {
    return TransportHomeBuilder(dependency: self)
  }()
  var topupBaseViewController: ViewControllable { rootViewController.topViewControllable }
  
  lazy var topupBuildable: TopupBuildable = {
    return TopupBuilder(dependency: self)
  }()
  
  private let rootViewController: ViewControllable
  
  init(dependency: AppRootDependency,
       cardOnFileRepository: CardOnFileRepositoryType,
       superPayRepository: SuperPayRepository,
       rootViewController: ViewControllable
  ) {
    self.cardOnFileRepository = cardOnFileRepository
    self.superPayRepository = superPayRepository
    self.rootViewController = rootViewController
    super.init(dependency: dependency)
  }
}

