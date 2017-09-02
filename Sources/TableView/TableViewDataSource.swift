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

//===

open
class TableViewDataSource<Section: Equatable, Item: Equatable>: NSObject,
    SectionedDataSource,
    UITableViewDataSource
{
    // MARK: - Public typealiases
    
    public
    typealias CellGetter =
        (UITableView, IndexPath) -> UITableViewCell
    
    public
    typealias CellConfigurator =
        (UITableViewCell, Item) -> Void
    
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
    
    // MARK: - UITableViewDataSource support
    
    open
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return sectionsCount()
    }
    
    //===

    open
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
        ) -> Int
    {
        return itemsCount(in: section)
    }
    
    //===

    open
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
        ) -> UITableViewCell
    {
        let cell = cellGetter(tableView, indexPath)
        
        //---
        
        cellConfigurator(cell, self[indexPath])
        
        //---
        
        return cell
    }
}
