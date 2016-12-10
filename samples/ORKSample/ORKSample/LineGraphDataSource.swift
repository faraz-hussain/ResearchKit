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

class LineGraphDataSource: NSObject, ORKValueRangeGraphChartViewDataSource {
    // MARK: Properties
    
    var plotPoints =
        [
            [
                ORKValueRange(value: -50),
                ORKValueRange(value: 40),
                ORKValueRange(value: -45),
                ORKValueRange(value: 60),
                ORKValueRange(value: -55),
                ORKValueRange(value: 40),
                ORKValueRange(value: -50),
                ],
            [
                ORKValueRange(value: 0),
                ORKValueRange(),
                ORKValueRange(),
                ORKValueRange(),
                ORKValueRange(),
                ORKValueRange(),
                ORKValueRange(value: 0),
                ]
    ]
    
    // MARK: ORKGraphChartViewDataSource
    
    func numberOfPlots(in graphChartView: ORKGraphChartView) -> Int {
        return plotPoints.count
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, dataPointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKValueRange {
        return plotPoints[plotIndex][pointIndex]
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, numberOfDataPointsForPlotIndex plotIndex: Int) -> Int {
        return plotPoints[plotIndex].count
    }
    
    func maximumValueForgraphChartView(_ graphChartView: ORKGraphChartView) -> Double {
        return 100
    }
    
    func minimumValueForgraphChartView(_ graphChartView: ORKGraphChartView) -> Double {
        return -100
    }
    
    func graphChartView(_ graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        switch pointIndex {
        case 0:
            return "Mon"
        case 1:
            return "Tue"
        case 2:
            return "Wed"
        case 3:
            return "Thu"
        case 4:
            return "Fri"
        case 5:
            return "Sat"
        case 6:
            return "Sun"
        default:
            return "Day \(pointIndex + 1)"
        }
    }
}

class LineGraphDataSource2: NSObject, ORKValueRangeGraphChartViewDataSource {
    // MARK: Properties
    
    var plotPoints =
        [
            [
                ORKValueRange(value: -40),
                ORKValueRange(value: 30),
                ORKValueRange(value: -35),
                ORKValueRange(value: 70),
                ORKValueRange(value: -65),
                ORKValueRange(value: 50),
                ORKValueRange(value: -60),
                ],
            [
                ORKValueRange(value: 0),
                ORKValueRange(),
                ORKValueRange(),
                ORKValueRange(),
                ORKValueRange(),
                ORKValueRange(),
                ORKValueRange(value: 0),
                ]
    ]
    
    // MARK: ORKGraphChartViewDataSource
    
    func numberOfPlots(in graphChartView2: ORKGraphChartView) -> Int {
        return plotPoints.count
    }
    
    func graphChartView(_ graphChartView2: ORKGraphChartView, dataPointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKValueRange {
        return plotPoints[plotIndex][pointIndex]
    }
    
    func graphChartView(_ graphChartView2: ORKGraphChartView, numberOfDataPointsForPlotIndex plotIndex: Int) -> Int {
        return plotPoints[plotIndex].count
    }
    
    func maximumValueForgraphChartView(_ graphChartView2: ORKGraphChartView) -> Double {
        return 100
    }
    
    func minimumValueForgraphChartView(_ graphChartView2: ORKGraphChartView) -> Double {
        return -100
    }
    
    func graphChartView(_ graphChartView2: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        switch pointIndex {
        case 0:
            return "Mon"
        case 1:
            return "Tue"
        case 2:
            return "Wed"
        case 3:
            return "Thu"
        case 4:
            return "Fri"
        case 5:
            return "Sat"
        case 6:
            return "Sun"
        default:
            return "Day \(pointIndex + 1)"
        }
    }
}

class LineGraphDataSource3: NSObject, ORKValueRangeGraphChartViewDataSource {
    // MARK: Properties
    
    var plotPoints =
        [
            [
                ORKValueRange(value: 10),
                ORKValueRange(value: 20),
                ORKValueRange(value: 25),
                ORKValueRange(value: 30),
                ORKValueRange(value: 50),
                ORKValueRange(value: 30),
                ORKValueRange(value: 40),
                ],
            [
                ORKValueRange(value: 60),
                ORKValueRange(value: 50),
                ORKValueRange(value: 45),
                ORKValueRange(value: 40),
                ORKValueRange(value: 20),
                ORKValueRange(value: 40),
                ORKValueRange(value: 30),
                ]
    ]
    
    // MARK: ORKGraphChartViewDataSource
    
    func numberOfPlots(in graphChartView3: ORKGraphChartView) -> Int {
        return plotPoints.count
    }
    
    func graphChartView(_ graphChartView3: ORKGraphChartView, dataPointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKValueRange {
        return plotPoints[plotIndex][pointIndex]
    }
    
    func graphChartView(_ graphChartView3: ORKGraphChartView, numberOfDataPointsForPlotIndex plotIndex: Int) -> Int {
        return plotPoints[plotIndex].count
    }
    
    func maximumValueForgraphChartView(_ graphChartView3: ORKGraphChartView) -> Double {
        return 70
    }
    
    func minimumValueForgraphChartView(_ graphChartView3: ORKGraphChartView) -> Double {
        return 0
    }
    
    func graphChartView(_ graphChartView3: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        switch pointIndex {
        case 0:
            return "Mon"
        case 1:
            return "Tue"
        case 2:
            return "Wed"
        case 3:
            return "Thu"
        case 4:
            return "Fri"
        case 5:
            return "Sat"
        case 6:
            return "Sun"
        default:
            return "Day \(pointIndex + 1)"
        }
    }
}

class LineGraphDataSource4: NSObject, ORKValueRangeGraphChartViewDataSource {
    // MARK: Properties
    
    var plotPoints =
        [
            [
                ORKValueRange(value: 15),
                ORKValueRange(value: 25),
                ORKValueRange(value: 30),
                ORKValueRange(value: 35),
                ORKValueRange(value: 55),
                ORKValueRange(value: 35),
                ORKValueRange(value: 45),
                ],
            [
                ORKValueRange(value: 55),
                ORKValueRange(value: 45),
                ORKValueRange(value: 40),
                ORKValueRange(value: 35),
                ORKValueRange(value: 15),
                ORKValueRange(value: 35),
                ORKValueRange(value: 25),
                ]
    ]
    
    // MARK: ORKGraphChartViewDataSource
    
    func numberOfPlots(in graphChartView4: ORKGraphChartView) -> Int {
        return plotPoints.count
    }
    
    func graphChartView(_ graphChartView4: ORKGraphChartView, dataPointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKValueRange {
        return plotPoints[plotIndex][pointIndex]
    }
    
    func graphChartView(_ graphChartView4: ORKGraphChartView, numberOfDataPointsForPlotIndex plotIndex: Int) -> Int {
        return plotPoints[plotIndex].count
    }
    
    func maximumValueForgraphChartView(_ graphChartView4: ORKGraphChartView) -> Double {
        return 70
    }
    
    func minimumValueForgraphChartView(_ graphChartView4: ORKGraphChartView) -> Double {
        return 0
    }
    
    func graphChartView(_ graphChartView4: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        switch pointIndex {
        case 0:
            return "Mon"
        case 1:
            return "Tue"
        case 2:
            return "Wed"
        case 3:
            return "Thu"
        case 4:
            return "Fri"
        case 5:
            return "Sat"
        case 6:
            return "Sun"
        default:
            return "Day \(pointIndex + 1)"
        }
    }
}
