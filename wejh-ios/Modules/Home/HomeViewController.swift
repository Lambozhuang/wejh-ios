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

final class HomeViewController: BaseViewController<HomeViewModel> {

  private var tableView: UITableView!
  private lazy var menuView: HomeMenuView! = {
    if let nib = Bundle.main.loadNibNamed(HomeMenuView.nibName, owner: self) {
       return nib.first as? HomeMenuView
    }
    return nil
  }()

  private var navigationButtonLogo: UIBarButtonItem!
  private var navigationButtonUser: UIBarButtonItem!

  override func setupUI() {
    view.backgroundColor = UIColor.Home.backgroundLower
    title = "微精弘"

    configureNavigationBarAppearance(enforceLargeTitle: true, backgroundColor: UIColor.Home.backgroundElevated, tintColor: .primaryBlack)

    navigationButtonLogo = UIBarButtonItem(image: UIImage(named: "Images/nav-logo"), style: .plain, target: nil, action: nil)
    navigationButtonUser = UIBarButtonItem(image: UIImage(named: "Images/nav-user"), style: .plain, target: nil, action: nil)

    navigationItem.rightBarButtonItem = navigationButtonUser
    navigationItem.leftBarButtonItem = navigationButtonLogo

    setupTableView()
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
      } else if let timeTableViewModel = item as? HomeTodayCellTimetableViewModel {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTodayCellTimetable.reuseIdentifier) as! HomeTodayCellTimetable
        cell.connect(viewModel: timeTableViewModel)
        return cell
      } else {
        fatalError("Unrecognized cell type")
      }
    })

    output.menu.drive(onNext: { [weak self] menuViewModel in
      self?.menuView.connect(viewModel: menuViewModel)
    }).disposed(by: rx.disposeBag)

    /// Table view is setup and added in `viewDidLoad` call, we delay the data binding to the next runloop.
    DispatchQueue.main.async {
      self.tableView.rx.setDelegate(self).disposed(by: self.rx.disposeBag)
      output.todaySection.asObservable().bind(to: self.tableView.rx.items(dataSource: dataSource)).disposed(by: self.rx.disposeBag)
    }
  }

  private func setupTableView() {
    tableView = UITableView(frame: .zero, style: .plain)

    tableView.separatorColor = .clear
    tableView.backgroundColor = .clear
    tableView.allowsSelection = false

    tableView.registerHeaderFooter(HomeMenuView.self)
    tableView.registerCell(HomeTodayCellTimetable.self)
    tableView.registerCell(HomeTodayCellCard.self)

    view.addSubview(tableView)
    tableView.snp.makeConstraints { constraint in
      constraint.trailing.equalTo(self.view)
      constraint.leading.equalTo(self.view)
      constraint.top.equalTo(self.view.safeAreaLayoutGuide)
      constraint.bottom.equalTo(self.view.safeAreaLayoutGuide)
    }
  }

}

extension HomeViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return menuView
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    let height = menuView.getCalculatedHeight()
    return height
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 156
    } else {
      return UITableView.automaticDimension
    }
  }

}
