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

import Foundation

//===

public
protocol SectionedDataSource: class
{
    associatedtype _Section: Equatable
    associatedtype _Item: Equatable
    
    typealias SectionWithContent = (itself: _Section, content: [_Item])
    
    var sections: [SectionWithContent] { get set }
}

// MARK: Convenience helpers

public
extension SectionedDataSource
{
    func sectionsCount() -> Int
    {
        return sections.count
    }
    
    func itemsCount(in section: Int) -> Int
    {
        return sections[section].content.count
    }
    
    subscript(sectionIndex: Int) -> _Section
    {
        get
        {
            return sections[sectionIndex].itself
        }
    }
    
    subscript(indexPath: IndexPath) -> _Item
    {
        get
        {
            return sections[indexPath.section].content[indexPath.item]
        }
    }
}
