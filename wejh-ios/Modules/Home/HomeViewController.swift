//
//  HomeViewController.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/1.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxViewController
import NSObject_Rx
import RxDataSources

extension UIColor {

  static var homeBackgroundElevated: UIColor = {
    return UIColor("#F3E6E3", displayP3: true)
  }()

  static var homeBackgroundLower: UIColor = {
    return UIColor("#F8EEEC", displayP3: true)
  }()

}

final class HomeViewController: BaseViewController<HomeViewModel> {

  private var tableView: UITableView!

  private var navigationButtonLogo: UIBarButtonItem!
  private var navigationButtonUser: UIBarButtonItem!

  override func setupUI() {
    tableView = UITableView(frame: .zero, style: .grouped)

    tableView.separatorColor = .clear
    tableView.backgroundColor = .clear

    view.addSubview(tableView)
    tableView.snp.makeConstraints { constraint in
      constraint.trailing.equalTo(self.view)
      constraint.leading.equalTo(self.view)
      constraint.top.equalTo(self.view.safeAreaLayoutGuide)
      constraint.bottom.equalTo(self.view.safeAreaLayoutGuide)
    }

    view.backgroundColor = .homeBackgroundLower
    title = "微精弘"

    configureNavigationBarAppearance(enforceLargeTitle: true, backgroundColor: .homeBackgroundElevated, tintColor: .primaryBlack)

    navigationButtonLogo = UIBarButtonItem(image: UIImage(named: "Images/nav-logo"), style: .plain, target: nil, action: nil)
    navigationButtonUser = UIBarButtonItem(image: UIImage(named: "Images/nav-user"), style: .plain, target: nil, action: nil)

    navigationItem.rightBarButtonItem = navigationButtonUser
    navigationItem.leftBarButtonItem = navigationButtonLogo

    tableView.register(SectionHeaderView.self)

    tableView.register(HomeTodayCellTimetable.self)
    tableView.register(HomeTodayCellCard.self)
  }

  override func bindToViewModel() {
    guard let viewModel = viewModel else {
      return
    }

    let input = HomeViewModel.Input(whatsNewTrigger: rx.viewDidAppear.map({ _ in }), userSceneTrigger: navigationButtonUser.rx.tap)
    let output = viewModel.transform(input: input)

    output.presentWhatsNew.drive(onNext: { [weak self] whatsNewTraits in
      guard let self = self, let traits = whatsNewTraits else {
        return
      }
      let targetScene = Navigator.Scene<DummyNavigable>.whatsNew(traits: traits)
      self.navigator.transition(to: targetScene, type: .modal(), sender: self)
    }).disposed(by: rx.disposeBag)

    output.presentUserScene.drive(onNext: { [weak self] viewModel in
      guard let self = self else {
        return
      }
      let targetScene = Navigator.Scene<UserViewController>.navigable(viewModel: viewModel)
      self.navigator.transition(to: targetScene, type: .modal(), sender: self)
    }).disposed(by: rx.disposeBag)

    let dataSource = RxTableViewSectionedReloadDataSource<HomeTodaySectionModel>(configureCell: { _, tableView, _, item in
      if let cardViewModel = item as? HomeTodayCellCardViewModel {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTodayCellCard.reuseIdentifier) as! HomeTodayCellCard
        cell.connect(viewModel: cardViewModel)
        return cell
      } else {
        fatalError("Unrecognized cell type")
      }
    })

    tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)

    DispatchQueue.main.async {
      output.todaySecion.asObservable().bind(to: self.tableView.rx.items(dataSource: dataSource)).disposed(by: self.rx.disposeBag)
    }
  }

}

extension HomeViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 156.0
  }

}
