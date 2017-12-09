/*
 
 MIT License
 
 Copyright (c) 2016 Maxim Khatskevich (maxim@khatskevi.ch)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
 */

import UIKit

//---

open
class CollectionViewDataSource<Section: Equatable, Item: Equatable>: NSObject,
    SectionedDataSource,
    UICollectionViewDataSource
{
    // MARK: - Public typealiases
    
    public
    typealias CellGetter =
        (UICollectionView, IndexPath) -> UICollectionViewCell
    
    public
    typealias CellConfigurator =
        (UICollectionViewCell, Item) -> Void
    
    // MARK: - Public Members
    
    public
    let cellGetter: CellGetter
    
    public
    let cellConfigurator: CellConfigurator
    
    // MARK: - Initializers
    
    public
    required
    init(
        cellGetter: @escaping CellGetter,
        cellConfigurator: @escaping CellConfigurator
        )
    {
        self.cellGetter = cellGetter
        self.cellConfigurator = cellConfigurator
    }
    
    // MARK: - SectionedDataSource support
    
    public
    typealias _Section = Section
    
    public
    typealias _Item = Item
    
    public
    var sections: [SectionWithContent] = []
    
    // MARK: - UICollectionViewDataSource support

    open
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return sectionsCount()
    }
    
    //===

    open
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
        ) -> Int
    {
        return itemsCount(in: section)
    }
    
    //===

    open
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell
    {
        let cell = cellGetter(collectionView, indexPath)
        
        //---
        
        cellConfigurator(cell, self[indexPath])
        
        //---
        
        return cell
    }
}
