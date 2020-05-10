//
//  HomeMenuView.swift
//  wejh-ios
//
//  Created by Bunny Wong on 2020/5/4.
//  Copyright © 2020 Bunny Wong. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import RxDataSources
import NSObject_Rx

final class HomeMenuView: UITableViewHeaderFooterView, InstantiableIdentifiable, ViewModelBindableType {

  typealias ViewModel = HomeMenuViewModel

  var viewModel: HomeMenuViewModel?

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var menuCollectionView: UICollectionView!
  @IBOutlet weak var pageControl: UIPageControl!

  var menuItemWidth: CGFloat = 91
  var verticalGutter: CGFloat = 18
  var horizontalGutter: CGFloat = 26
  var topInset: CGFloat = 24

  override func awakeFromNib() {
    super.awakeFromNib()

    containerView.backgroundColor = UIColor.Home.backgroundElevated
    menuCollectionView.backgroundColor = .clear
    menuCollectionView.registerCell(HomeMenuItemCell.self)
    menuCollectionView.registerCell(HomeMenuItemEmptyCell.self)
    menuCollectionView.delegate = self
    menuCollectionView.showsHorizontalScrollIndicator = false
  }

  func connect(viewModel: HomeMenuViewModel?) {
    self.viewModel = viewModel
    bindToViewModel()
  }

  func bindToViewModel() {
    guard let viewModel = viewModel else {
      return
    }

    let dataSource = RxCollectionViewSectionedReloadDataSource<HomeMenuViewModel.PagedMenuItems>(configureCell: { _, collectionView, indexPath, item in
      switch item {
      case .item(let name, let imageName):
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMenuItemCell.reuseIdentifier, for: indexPath) as! HomeMenuItemCell
        cell.itemLabel.text = name + String(indexPath.row)
        cell.itemImageView.image = UIImage(named: imageName)
        return cell
      case .empty:
        return collectionView.dequeueReusableCell(withReuseIdentifier: HomeMenuItemEmptyCell.reuseIdentifier, for: indexPath)
      }
    })

    let output = viewModel.transform(input: ViewModel.Input())
    output.pagedMenuItems.bind(to: self.menuCollectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
    output.pagedMenuItems.subscribe(onNext: { [weak self] items in
      self?.pageControl.numberOfPages = items.count
    }).disposed(by: rx.disposeBag)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    menuCollectionView.collectionViewLayout.invalidateLayout()
  }

  func getCalculatedHeight() -> CGFloat{
    var height = topInset + pageControl.bounds.height
    if let itemsPerColumn = viewModel?.itemsPerColumn {
      height += CGFloat(itemsPerColumn) * menuItemWidth + CGFloat(itemsPerColumn - 1) * verticalGutter
    }
    return height
  }

}

extension HomeMenuView: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    pageControl.currentPage = indexPath.section
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: menuItemWidth, height: menuItemWidth)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    var inset: CGFloat = 0
    if let itemsPerRow = viewModel?.itemsPerRow  {
      inset = (collectionView.bounds.width - CGFloat(itemsPerRow - 1) * horizontalGutter - CGFloat(itemsPerRow) * menuItemWidth) / 2.0
    }
    return UIEdgeInsets(top: topInset, left: inset, bottom: 0, right: inset)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return horizontalGutter
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return verticalGutter
  }

}
