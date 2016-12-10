/*
 Copyright (c) 2015, Apple Inc. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1.  Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2.  Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.
 
 3.  Neither the name of the copyright holder(s) nor the names of any contributors
 may be used to endorse or promote products derived from this software without
 specific prior written permission. No license is granted to the trademarks of
 the copyright holders even if such marks are included in this software.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import ResearchKit

class PieChartDataSource: NSObject, ORKPieChartViewDataSource {
    // MARK: Types
    
    struct Segment {
        let title: String
        let value: Float
        let color: UIColor
    }
    
    // MARK: Properties
    
    let segments = [
        Segment(title: "No usage", value: 33.0, color: UIColor(red: 102/225, green: 205/255, blue: 0/225, alpha: 1)),
        Segment(title: "Heavy usage", value: 40.0, color: UIColor(red: 255/225, green: 0/255, blue: 0/225, alpha: 1)),
        Segment(title: "Moderate usage", value: 27.0, color: UIColor(red: 255/255, green: 193/255, blue: 37/255, alpha: 1))
    ]
    
    // MARK: ORKPieChartViewDataSource
    
    func numberOfSegments(in pieChartView: ORKPieChartView ) -> Int {
        return segments.count
    }
    
    func pieChartView(_ pieChartView: ORKPieChartView, valueForSegmentAt index: Int) -> CGFloat {
        return CGFloat(segments[index].value)
    }
    
    func pieChartView(_ pieChartView: ORKPieChartView, colorForSegmentAt index: Int) -> UIColor {
        return segments[index].color
    }
    
    func pieChartView(_ pieChartView: ORKPieChartView, titleForSegmentAt index: Int) -> String {
        return segments[index].title
    }
}

class PieChartDataSource2: NSObject, ORKPieChartViewDataSource {
    // MARK: Types
    
    struct Segment {
        let title: String
        let value: Float
        let color: UIColor
    }
    
    // MARK: Properties
    
    let segments = [
        Segment(title: "No usage", value: 25.0, color: UIColor(red: 102/225, green: 205/255, blue: 0/225, alpha: 1)),
        Segment(title: "Heavy usage", value: 55.0, color: UIColor(red: 255/225, green: 0/255, blue: 0/225, alpha: 1)),
        Segment(title: "Moderate usage", value: 20.0, color: UIColor(red: 255/255, green: 193/255, blue: 37/255, alpha: 1))
    ]
    
    // MARK: ORKPieChartViewDataSource
    
    func numberOfSegments(in pieChartView2: ORKPieChartView ) -> Int {
        return segments.count
    }
    
    func pieChartView(_ pieChartView2: ORKPieChartView, valueForSegmentAt index: Int) -> CGFloat {
        return CGFloat(segments[index].value)
    }
    
    func pieChartView(_ pieChartView2: ORKPieChartView, colorForSegmentAt index: Int) -> UIColor {
        return segments[index].color
    }
    
    func pieChartView(_ pieChartView2: ORKPieChartView, titleForSegmentAt index: Int) -> String {
        return segments[index].title
    }
}
