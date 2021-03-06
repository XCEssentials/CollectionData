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

import Dwifft

//---

public
protocol TableViewWrapper: class
{
    var table: UITableView { get }
}

//---

public
extension Synchronizer where
    Data: UITableViewDataSource,
    Wrapper: TableViewWrapper
{
    public
    init(
        data: Data,
        wrapper: Wrapper,
        onBind: @escaping (Wrapper, Data) -> Void = { $0.table.dataSource = $1 }
        )
    {
        self.data = data
        self.wrapper = wrapper
        self.onBind = onBind
    }

    //---

    func setup(
        with initialSections: [Data.SectionWithContent]
        )
    {
        data.sections = initialSections

        // lets ensure the 'data' object is the 'dataSource' for the 'view'
        // 'lazy binding'
        onBind(wrapper, data)

        //---

        wrapper.table.reloadData()
    }

    //---

    @available(iOS 11.0, *)
    func update(
        with newSections: [Data.SectionWithContent],
        completion: ((Bool) -> Void)? = nil
        )
    {
        let diff = Dwifft.diff(
            lhs: SectionedValues(data.sections),
            rhs: SectionedValues(newSections)
        )

        //---

        data.sections = newSections

        // lets ensure the 'data' object is the 'dataSource' for the 'view'
        // 'lazy binding'
        onBind(wrapper, data)

        //---

        wrapper.table.update(with: diff, completion: completion)
    }

    func update(
        with newSections: [Data.SectionWithContent]
        )
    {
        let diff = Dwifft.diff(
            lhs: SectionedValues(data.sections),
            rhs: SectionedValues(newSections)
        )
        
        //---
        
        data.sections = newSections
        
        // lets ensure the 'data' object is the 'dataSource' for the 'view'
        // 'lazy binding'
        onBind(wrapper, data)
        
        //---
        
        wrapper.table.update(with: diff)
    }
}
