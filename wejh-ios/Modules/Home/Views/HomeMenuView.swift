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

  override func awakeFromNib() {
    super.awakeFromNib()

    containerView.backgroundColor = UIColor.Home.backgroundElevated
    menuCollectionView.backgroundColor = .clear
    menuCollectionView.registerCell(HomeMenuItemCell.self)
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
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMenuItemCell.reuseIdentifier, for: indexPath) as! HomeMenuItemCell
      cell.itemLabel.text = item.name + String(indexPath.row)
      cell.itemImageView.image = UIImage(named: item.imageName)
      return cell
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

}

extension HomeMenuView: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    pageControl.currentPage = indexPath.section
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 91, height: 91)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    guard let viewModel = viewModel else {
      return UIEdgeInsets.zero
    }
    let inset = (collectionView.bounds.width - CGFloat(viewModel.itemsPerRow - 1) * 26.0 - CGFloat(viewModel.itemsPerRow) * 91.0) / 2.0
    return UIEdgeInsets(top: 24, left: inset, bottom: 0, right: inset)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 26
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 18
  }

}
