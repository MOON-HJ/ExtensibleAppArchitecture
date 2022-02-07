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

final class AppRootComponent: Component<AppRootDependency>, AppHomeDependency, FinanceHomeDependency, ProfileHomeDependency, TransportHomeDependency  {
  let cardOnFileRepository: CardOnFileRepositoryType
  let superPayRepository: SuperPayRepository
  
  lazy var transportHomeBuildable: TransportHomeBuildable = {
    return TransportHomeBuilder(dependency: self)
  }()
  
  init(dependency: AppRootDependency,
                cardOnFileRepository: CardOnFileRepositoryType,
                superPayRepository: SuperPayRepository
  ) {
    self.cardOnFileRepository = cardOnFileRepository
    self.superPayRepository = superPayRepository
    super.init(dependency: dependency)
  }
}

