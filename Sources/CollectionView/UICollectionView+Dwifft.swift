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

//===

public
extension UICollectionView
{
    func update<Section: Equatable, Value: Equatable>(
        with diff: [SectionedDiffStep<Section, Value>],
        completion: ((Bool) -> Void)? = nil
        )
    {
        let updates = {
            
            for step in diff
            {
                switch step
                {
                    case let .delete(section, row, _):
                        self.deleteItems(at: [IndexPath(row: row, section: section)])
                    
                    case let .insert(section, row, _):
                        self.insertItems(at: [IndexPath(row: row, section: section)])
                    
                    case let .sectionDelete(section, _):
                        self.deleteSections(IndexSet(integer: section))
                    
                    case let .sectionInsert(section, _):
                        self.insertSections(IndexSet(integer: section))
                }
            }
        }
        
        //---
        
        self.performBatchUpdates(updates, completion: completion)
    }
}
