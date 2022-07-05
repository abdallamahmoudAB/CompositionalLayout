//
//  ViewController.swift
//  AppStoreCompositionalLayout
//
//  Created by abdalla mahmoud on 03/07/2022.
//

import UIKit


typealias LayoutSectionItemsTuple = (title: String, layout: SectionLayout, items: [Item])

class AppStoreController: UIViewController {
    
    let backingStore: [LayoutSectionItemsTuple] = [
        ("Stories", .storiesCarousel, Item.storiesCarouselItems),
        ("Featured", .bannerCarousel, Item.bannerCarouselItems),
        ("Column", .columnCarousel, Item.columnItems),
        ("List", .list, Item.listItems),
        ("Grid", .grid, Item.gridItems)
    ]
    
    var dataSource: UICollectionViewDiffableDataSource<SectionLayout, Item>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Compositional Layout"
        configureCollectionView()
        setupCellAndSupplementaryRegistrations()
        configureDataSource()
    }
    
    var bannerCellRegistration: UICollectionView.CellRegistration<BannerCell, Item>!
    var listCellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, Item>!
    var columnCellRegistration: UICollectionView.CellRegistration<ColumnCell, Item>!
    var avatarCellRegistration: UICollectionView.CellRegistration<AvatarCell, Item>!
    var headerRegistration: UICollectionView.SupplementaryRegistration<SectionHeaderTextReusableView>!
    var footerRegistration: UICollectionView.SupplementaryRegistration<SeparatorCollectionReusableView>!
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    
    func setupCellAndSupplementaryRegistrations() {
        bannerCellRegistration = .init(cellNib: BannerCell.nib, handler: { (cell, _, item) in
            cell.setup(item)
        })
        
        listCellRegistration = .init(handler: { (cell, indexPath, item) in
            cell.setup(item: item)
        })
        
        columnCellRegistration = .init(cellNib: ColumnCell.nib, handler: { (cell, _, item) in
            cell.setup(item)
        })
        
        avatarCellRegistration = .init(cellNib: AvatarCell.nib, handler: { (cell, indexPath, item) in
            let sectionIdentifier = self.dataSource.snapshot().sectionIdentifiers[indexPath.section]
            switch sectionIdentifier {
            case .storiesCarousel:
                cell.textLabel.isHidden = true
            default:
                cell.textLabel.isHidden = false
            }
            cell.setup(item: item)
        })
        
        headerRegistration = .init(supplementaryNib: SectionHeaderTextReusableView.nib, elementKind: UICollectionView.elementKindSectionHeader, handler: { (header, _, indexPath) in
            let title = self.backingStore[indexPath.section].title
            header.titleLabel.text = title
        })
        
        footerRegistration = .init(elementKind: UICollectionView.elementKindSectionFooter, handler: { (_, _, _) in })
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvirontment in
            let sectionIdentifier = self.dataSource.snapshot().sectionIdentifiers[sectionIndex]
            switch sectionIdentifier {
            case .storiesCarousel:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(70), heightDimension: .estimated(1)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 14
                section.contentInsets = .init(top: 0, leading: 14, bottom: 14, trailing: 14)
                section.orthogonalScrollingBehavior = .continuous
                section.supplementariesFollowContentInsets = false
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem(), self.supplementarySeparatorFooterItem()]
                return section
                
            case .bannerCarousel:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.75), heightDimension: .estimated(1)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 14
                section.contentInsets = .init(top: 0, leading: 14, bottom: 14, trailing: 14)
                section.supplementariesFollowContentInsets = false
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem(), self.supplementarySeparatorFooterItem()]
                return section
                
            case .columnCarousel:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])
                let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(0.80), heightDimension: .estimated(1)), subitems: Array(repeating: group, count: 3))
                containerGroup.interItemSpacing = .fixed(14)
                
                let section = NSCollectionLayoutSection(group: containerGroup)
                section.contentInsets = .init(top: 0, leading: 14, bottom: 14, trailing: 14)
                section.interGroupSpacing = 14
                section.supplementariesFollowContentInsets = false
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem(), self.supplementarySeparatorFooterItem()]
                section.orthogonalScrollingBehavior = .groupPaging
                return section
                
            case .list:
                var listConfig = UICollectionLayoutListConfiguration(appearance: .grouped)
                listConfig.headerMode = .supplementary
                listConfig.footerMode = .supplementary
                return NSCollectionLayoutSection.list(using: listConfig, layoutEnvironment: layoutEnvirontment)
                
            case .grid:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))
                
                let columnsCount = layoutEnvirontment.traitCollection.horizontalSizeClass == .compact ? 4 : 8
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)), subitem: item, count: columnsCount)
                group.interItemSpacing = .fixed(14)
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 14
                section.contentInsets = .init(top: 0, leading: 14, bottom: 14, trailing: 14)
                section.supplementariesFollowContentInsets = false
                section.boundarySupplementaryItems = [self.supplementaryHeaderItem(), self.supplementarySeparatorFooterItem()]
                return section
                
            }
        }
        return layout
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    private func supplementarySeparatorFooterItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(1)), elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionLayout, Item>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell? in
            guard let sectionIdentifier = self.dataSource.snapshot().sectionIdentifier(containingItem: item) else {
                return nil
            }
            switch sectionIdentifier {
            case .bannerCarousel:
                return collectionView.dequeueConfiguredReusableCell(using: self.bannerCellRegistration, for: indexPath, item: item)
            case .storiesCarousel, .grid:
                return collectionView.dequeueConfiguredReusableCell(using: self.avatarCellRegistration, for: indexPath, item: item)
            case .list:
                return collectionView.dequeueConfiguredReusableCell(using: self.listCellRegistration, for: indexPath, item: item)
            case .columnCarousel:
                return collectionView.dequeueConfiguredReusableCell(using: self.columnCellRegistration, for: indexPath, item: item)
            }
        }
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            if kind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.headerRegistration, for: indexPath)
            } else {
                return collectionView.dequeueConfiguredReusableSupplementary(using: self.footerRegistration, for: indexPath)
            }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<SectionLayout, Item>()
        backingStore.forEach { section in
            snapshot.appendSections([section.layout])
            snapshot.appendItems(section.items)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}


