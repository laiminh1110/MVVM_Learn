//
//  CategoriesListVC.swift
//  Test
//
//  Created by Minh on 21/11/2022.
//

import UIKit

class CategoriesListVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var clsViewCategories: UICollectionView!
    @IBOutlet weak var heightContentView: NSLayoutConstraint!
    
    static var identifier: String {return String(describing: self)}
    var arrCategories : [Categories] = [Categories]()
    let viewModelCategories = CategoriesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelCategories.getListCategories(token: StorageUserDefaut.shared.token)
        setupBindingData()
        setupCollectionView()
    }
    
    
    private func setupCollectionView(){
        clsViewCategories.isScrollEnabled = false
        clsViewCategories.delegate = self
        clsViewCategories.dataSource = self
        clsViewCategories.register(UINib(nibName: "ItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemCollectionViewCell")
    }
    
    private func setupBindingData(){
        viewModelCategories.categoriesList.bind { [weak self] cateModel in
            print("categoriesList.bind ")

            guard let cateModel = cateModel,
                  let arr = cateModel.categories else {return}
            DispatchQueue.main.async {
                print("DispatchQueue.main.async")
                self?.arrCategories = arr 
                self?.clsViewCategories.reloadData()
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        print("viewWillLayoutSubviews")

    }
    override func viewDidLayoutSubviews() {
        print("viewDidLayoutSubviews")
        self.changeCollectionHeight()
    }
    
    func changeCollectionHeight(){
        self.heightContentView.constant = clsViewCategories.collectionViewLayout.collectionViewContentSize.height + 300
        self.view.layoutIfNeeded()
        
        print("clsViewCategories.contentSize.height:\(clsViewCategories.contentSize.height)")
        print("self.heightContentView.constant =:\(self.heightContentView.constant)")
    }
}

extension CategoriesListVC:UICollectionViewDataSource,UICollectionViewDelegate{
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell()}
        let model  = arrCategories[indexPath.row]
        cell.titleView.text = model.name
        return cell
    }
    
}


