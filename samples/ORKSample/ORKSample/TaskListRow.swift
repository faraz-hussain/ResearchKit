/*
 Copyright (c) 2015, Apple Inc. All rights reserved.
 Copyright (c) 2015-2016, Ricardo Sánchez-Sáez.
 
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
import AudioToolbox

/**
 Wraps a SystemSoundID.
 
 A class is used in order to provide appropriate cleanup when the sound is
 no longer needed.
 */
class SystemSound {
    var soundID: SystemSoundID = 0
    
    init?(soundURL: URL) {
        if AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID) != noErr {
            return nil
        }
    }
    
    deinit {
        AudioServicesDisposeSystemSoundID(soundID)
    }
}

/**
 An enum that corresponds to a row displayed in a `TaskListViewController`.
 
 Each of the tasks is composed of one or more steps giving examples of the
 types of functionality supported by the ResearchKit framework.
 */
enum TaskListRow: Int, CustomStringConvertible {
    
    case MDQ
    case Altman
    case PHQ9
    case scaleQuestion
    
    case ReactionTime
    case SpatialSpanMemory
    case trailMaking
    
    class TaskListRowSection {
        var title: String
        var rows: [TaskListRow]
        
        init(title: String, rows: [TaskListRow]) {
            self.title = title
            self.rows = rows
        }
    }
    
    /// Returns an array of all the task list row enum cases.
    static var sections: [ TaskListRowSection ] {
        return [
            TaskListRowSection(title: "Begin here", rows:
                [
                    .MDQ,
                    ]),
            TaskListRowSection(title: "Surveys", rows:
                [
                    .Altman,
                    .PHQ9,
                    .scaleQuestion,
                    ]),
            TaskListRowSection(title: "Active tasks", rows:
                [
                    .ReactionTime,
                    .SpatialSpanMemory,
                    .trailMaking,
                    ]),
        ]}
    
    
    // MARK: CustomStringConvertible
    
    var description: String {
        switch self {
        case .MDQ:
            return NSLocalizedString("Mood Disorders Questionnaire", comment: "")
        case .Altman:
            return NSLocalizedString("Altman Self-Rating Mania Scale", comment: "")
            
        case .PHQ9:
            return NSLocalizedString("Patient Health Questionnaire-9", comment: "")
            
        case .scaleQuestion:
            return NSLocalizedString("Self-Rating Scales", comment: "")
            
        case .ReactionTime:
            return NSLocalizedString("Go/No-Go Visual Reaction Time", comment: "")
            
        case .SpatialSpanMemory:
            return NSLocalizedString("Spatial Span Memory", comment: "")
            
        case .trailMaking:
            return NSLocalizedString("Trail Making", comment: "")
        }
    }
    
    // MARK: Types
    
    /**
     Every step and task in the ResearchKit framework has to have an identifier.
     Within a task, the step identifiers should be unique.
     
     Here we use an enum to ensure that the identifiers are kept unique. Since
     the enum has a raw underlying type of a `String`, the compiler can determine
     the uniqueness of the case values at compile time.
     
     In a real application, the identifiers for your tasks and steps might
     come from a database, or in a smaller application, might have some
     human-readable meaning.
     */
    private enum Identifier {
        
        // Task with examples of questions with sliding scales.
        case scaleQuestionTask
        case discreteScaleQuestionStep1
        case discreteScaleQuestionStep2
        case discreteScaleQuestionStep3
        case discreteScaleQuestionStep4
        case discreteScaleQuestionStep5
        
        // Task with an example of a multiple choice question.
        case MDQTask
        case AltmanTask
        case PHQ9Task
        case textChoiceQuestionStep1
        case textChoiceQuestionStep2
        case textChoiceQuestionStep3
        case textChoiceQuestionStep4
        case textChoiceQuestionStep5
        case textChoiceQuestionStep6
        case textChoiceQuestionStep7
        case textChoiceQuestionStep8
        case textChoiceQuestionStep9
        case textChoiceQuestionStep10
        case textChoiceQuestionStep11
        case textChoiceQuestionStep12
        case textChoiceQuestionStep13
        case textChoiceQuestionStep14
        case textChoiceQuestionStep15
        case textChoiceQuestionStep16
        case textChoiceQuestionStep17
        
        // Active tasks.
        case reactionTime
        case spatialSpanMemoryTask
        case trailMaking
    }
    
    // MARK: Properties
    
    /// Returns a new `ORKTask` that the `TaskListRow` enumeration represents.
    var representedTask: ORKTask {
        switch self {
        case .MDQ:
            return MDQTask
            
        case .Altman:
            return AltmanTask
            
        case .PHQ9:
            return PHQ9Task
            
        case .scaleQuestion:
            return scaleQuestionTask
            
        case .ReactionTime:
            return reactionTimeTask
            
        case .SpatialSpanMemory:
            return spatialSpanMemoryTask
            
        case .trailMaking:
            return trailMaking;
        }
    }
    
    // MARK: Task Creation Convenience
    
    /// This task presents two options for questions displaying a scale control.
    private var scaleQuestionTask: ORKTask {
        // Energy rating
        let step1AnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: exampleHighValueText, minimumValueDescription: exampleLowValueText)
        
        let questionStep1 = ORKQuestionStep(identifier: String(describing:Identifier.discreteScaleQuestionStep1), title: energyQuestionText, answer: step1AnswerFormat)
        
        questionStep1.text = exampleDetailText
        
        // Mood rating
        let step2AnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: exampleHighValueText, minimumValueDescription: exampleLowValueText)
        
        let questionStep2 = ORKQuestionStep(identifier: String(describing:Identifier.discreteScaleQuestionStep2), title: moodQuestionText, answer: step2AnswerFormat)
        
        questionStep2.text = exampleDetailText
        
        // Speed of thoughts
        let step3AnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: speedHighValueText, minimumValueDescription: speedLowValueText)
        
        let questionStep3 = ORKQuestionStep(identifier: String(describing:Identifier.discreteScaleQuestionStep3), title: speedQuestionText, answer: step3AnswerFormat)
        
        questionStep3.text = exampleDetailText
        
        // Impulsiveness of thoughts
        let step4AnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: impulsivenessHighValueText, minimumValueDescription: impulsivenessLowValueText)
        
        let questionStep4 = ORKQuestionStep(identifier: String(describing:Identifier.discreteScaleQuestionStep4), title: impulsivenessthoughtsQuestionText, answer: step4AnswerFormat)
        
        questionStep4.text = exampleDetailText
        
        // Impulsiveness of actions
        
        let step5AnswerFormat = ORKAnswerFormat.scale(withMaximumValue: 10, minimumValue: 1, defaultValue: NSIntegerMax, step: 1, vertical: false, maximumValueDescription: impulsivenessHighValueText, minimumValueDescription: impulsivenessLowValueText)
        
        let questionStep5 = ORKQuestionStep(identifier: String(describing:Identifier.discreteScaleQuestionStep5), title: impulsivenessactionsQuestionText, answer: step5AnswerFormat)
        
        questionStep5.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing:Identifier.scaleQuestionTask), steps: [
            questionStep1,
            questionStep2,
            questionStep3,
            questionStep4,
            questionStep5
            ])
    }
    
    /**
     MDQ
     */
    private var MDQTask: ORKTask {
        let textChoiceOneText1 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText1 = NSLocalizedString("No", comment: "")
        
        let textChoices1 = [
            ORKTextChoice(text: textChoiceOneText1, value: "choice_1" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText1, value: "choice_2" as NSCoding & NSCopying & NSObjectProtocol),
            ]
        
        let answerFormat1 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices1)
        
        let questionStep1 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep1), title: exampleQuestionTextb, answer: answerFormat1)
        
        questionStep1.text = exampleDetailText1b
        
        let textChoiceOneText2 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText2 = NSLocalizedString("No", comment: "")
        
        let textChoices2 = [
            ORKTextChoice(text: textChoiceOneText2, value: "choice_3" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText2, value: "choice_4" as NSCoding & NSCopying & NSObjectProtocol),
            ]
        
        let answerFormat2 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices2)
        
        let questionStep2 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep2), title: exampleQuestionTextb, answer: answerFormat2)
        
        questionStep2.text = exampleDetailText2b
        
        let textChoiceOneText3 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText3 = NSLocalizedString("No", comment: "")
        
        let textChoices3 = [
            ORKTextChoice(text: textChoiceOneText3, value: "choice_5" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText3, value: "choice_6" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat3 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices3)
        
        let questionStep3 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep3), title: exampleQuestionTextb, answer: answerFormat3)
        
        questionStep3.text = exampleDetailText3b
        
        let textChoiceOneText4 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText4 = NSLocalizedString("No", comment: "")
        
        let textChoices4 = [
            ORKTextChoice(text: textChoiceOneText4, value: "choice_7" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText4, value: "choice_8" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat4 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices4)
        
        let questionStep4 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep4), title: exampleQuestionTextb, answer: answerFormat4)
        
        questionStep4.text = exampleDetailText4b
        
        let textChoiceOneText5 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText5 = NSLocalizedString("No", comment: "")
        
        let textChoices5 = [
            ORKTextChoice(text: textChoiceOneText5, value: "choice_9" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText5, value: "choice_10" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat5 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices5)
        
        let questionStep5 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep5), title: exampleQuestionTextb, answer: answerFormat5)
        
        questionStep5.text = exampleDetailText5b
        
        let textChoiceOneText6 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText6 = NSLocalizedString("No", comment: "")
        
        let textChoices6 = [
            ORKTextChoice(text: textChoiceOneText6, value: "choice_11" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText6, value: "choice_12" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat6 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices6)
        
        let questionStep6 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep6), title: exampleQuestionTextb, answer: answerFormat6)
        
        questionStep6.text = exampleDetailText6b
        
        let textChoiceOneText7 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText7 = NSLocalizedString("No", comment: "")
        
        let textChoices7 = [
            ORKTextChoice(text: textChoiceOneText7, value: "choice_13" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText7, value: "choice_14" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat7 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices7)
        
        let questionStep7 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep7), title: exampleQuestionTextb, answer: answerFormat7)
        
        questionStep7.text = exampleDetailText7b
        
        let textChoiceOneText8 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText8 = NSLocalizedString("No", comment: "")
        
        let textChoices8 = [
            ORKTextChoice(text: textChoiceOneText8, value: "choice_15" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText8, value: "choice_16" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat8 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices8)
        
        let questionStep8 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep8), title: exampleQuestionTextb, answer: answerFormat8)
        
        questionStep8.text = exampleDetailText8b
        
        let textChoiceOneText9 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText9 = NSLocalizedString("No", comment: "")
        
        
        let textChoices9 = [
            ORKTextChoice(text: textChoiceOneText9, value: "choice_17" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText9, value: "choice_18" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat9 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices9)
        
        let questionStep9 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep9), title: exampleQuestionTextb, answer: answerFormat9)
        
        questionStep9.text = exampleDetailText9b
        
        let textChoiceOneText10 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText10 = NSLocalizedString("No", comment: "")
        
        let textChoices10 = [
            ORKTextChoice(text: textChoiceOneText10, value: "choice_19" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText10, value: "choice_20" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat10 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices10)
        
        let questionStep10 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep10), title: exampleQuestionTextb, answer: answerFormat10)
        
        questionStep10.text = exampleDetailText10b
        
        let textChoiceOneText11 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText11 = NSLocalizedString("No", comment: "")
        
        let textChoices11 = [
            ORKTextChoice(text: textChoiceOneText11, value: "choice_21" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText11, value: "choice_22" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat11 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices11)
        
        let questionStep11 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep11), title: exampleQuestionTextb, answer: answerFormat11)
        
        questionStep11.text = exampleDetailText11b
        
        let textChoiceOneText12 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText12 = NSLocalizedString("No", comment: "")
        
        let textChoices12 = [
            ORKTextChoice(text: textChoiceOneText12, value: "choice_23" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText12, value: "choice_24" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat12 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices12)
        
        let questionStep12 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep12), title: exampleQuestionTextb, answer: answerFormat12)
        
        questionStep12.text = exampleDetailText12b
        
        let textChoiceOneText13 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText13 = NSLocalizedString("No", comment: "")
        
        let textChoices13 = [
            ORKTextChoice(text: textChoiceOneText13, value: "choice_25" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText13, value: "choice_27" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat13 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices13)
        
        let questionStep13 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep13), title: exampleQuestionTextb, answer: answerFormat13)
        
        questionStep13.text = exampleDetailText13b
        
        let textChoiceOneText14 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText14 = NSLocalizedString("No", comment: "")
        
        let textChoices14 = [
            ORKTextChoice(text: textChoiceOneText14, value: "choice_28" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText14, value: "choice_29" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat14 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices14)
        
        let questionStep14 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep14), title: exampleQuestionTextb1, answer: answerFormat14)
        
        let textChoiceOneText15 = NSLocalizedString("No Problem", comment: "")
        let textChoiceTwoText15 = NSLocalizedString("Minor Problem", comment: "")
        let textChoiceThreeText15 = NSLocalizedString("Moderate Problem", comment: "")
        let textChoiceFourText15 = NSLocalizedString("Serious Problem", comment: "")
        
        let textChoices15 = [
            ORKTextChoice(text: textChoiceOneText15, value: "choice_30" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText15, value: "choice_31" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText15, value: "choice_32" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText15, value: "choice_33" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat15 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices15)
        
        let questionStep15 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep15), title: exampleQuestionTextb2, answer: answerFormat15)
        
        let textChoiceOneText16 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText16 = NSLocalizedString("No", comment: "")
        
        let textChoices16 = [
            ORKTextChoice(text: textChoiceOneText16, value: "choice_34" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText16, value: "choice_35" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat16 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices16)
        
        let questionStep16 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep16), title: exampleQuestionTextb3, answer: answerFormat16)
        
        let textChoiceOneText17 = NSLocalizedString("Yes", comment: "")
        let textChoiceTwoText17 = NSLocalizedString("No", comment: "")
        
        let textChoices17 = [
            ORKTextChoice(text: textChoiceOneText17, value: "choice_37" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText17, value: "choice_38" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat17 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices17)
        
        let questionStep17 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep17), title: exampleQuestionTextb4, answer: answerFormat17)
        
        return ORKOrderedTask(identifier: String(describing:Identifier.MDQTask), steps: [questionStep1, questionStep2, questionStep3, questionStep4, questionStep5, questionStep6, questionStep7, questionStep8, questionStep9, questionStep10, questionStep11, questionStep12, questionStep13, questionStep14, questionStep15, questionStep16, questionStep17])
    }
    
    
    
    /**
     Altman
     */
    private var AltmanTask: ORKTask {
        let textChoiceOneText1 = NSLocalizedString("I do not feel happier or more cheerful than usual.", comment: "")
        let textChoiceTwoText1 = NSLocalizedString("I occasionally feel happier or more cheerful than usual.", comment: "")
        let textChoiceThreeText1 = NSLocalizedString("I often feel happier or more cheerful than usual.", comment: "")
        let textChoiceFourText1 = NSLocalizedString("I feel happier or more cheerful than usual most of the time.", comment: "")
        let textChoiceFiveText1 = NSLocalizedString("I feel happier or more cheerful than usual all of the time.", comment: "")
        
        let textChoices1 = [
            ORKTextChoice(text: textChoiceOneText1, value: "choice_39" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText1, value: "choice_40" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText1, value: "choice_41" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText1, value: "choice_42" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFiveText1, value: "choice_43" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat1 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices1)
        
        let questionStep1 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep1), title: exampleQuestionText1, answer: answerFormat1)
        
        questionStep1.text = exampleDetailText
        
        let textChoiceOneText2 = NSLocalizedString("I do not feel more self-confident than usual.", comment: "")
        let textChoiceTwoText2 = NSLocalizedString("I occasionally feel more self-confident than usual.", comment: "")
        let textChoiceThreeText2 = NSLocalizedString("I often feel more self-confident than usual.", comment: "")
        let textChoiceFourText2 = NSLocalizedString("I feel more self-confident than usual.", comment: "")
        let textChoiceFiveText2 = NSLocalizedString("I feel extremely self-confident all of the time.", comment: "")
        
        let textChoices2 = [
            ORKTextChoice(text: textChoiceOneText2, value: "choice_44" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText2, value: "choice_45" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText2, value: "choice_46" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText2, value: "choice_47" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFiveText2, value: "choice_48" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat2 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices2)
        
        let questionStep2 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep2), title: exampleQuestionText2, answer: answerFormat2)
        
        questionStep2.text = exampleDetailText
        
        let textChoiceOneText3 = NSLocalizedString("I do not need less sleep than usual.", comment: "")
        let textChoiceTwoText3 = NSLocalizedString("I occasionally need less sleep than usual.", comment: "")
        let textChoiceThreeText3 = NSLocalizedString("I often need less sleep than usual.", comment: "")
        let textChoiceFourText3 = NSLocalizedString("I frequently need less sleep than usual.", comment: "")
        let textChoiceFiveText3 = NSLocalizedString("I can go all day and night without any sleep and still not feel tired.", comment: "")
        
        let textChoices3 = [
            ORKTextChoice(text: textChoiceOneText3, value: "choice_49" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText3, value: "choice_50" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText3, value: "choice_51" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText3, value: "choice_52" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFiveText3, value: "choice_53" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat3 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices3)
        
        let questionStep3 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep3), title: exampleQuestionText3, answer: answerFormat3)
        
        questionStep3.text = exampleDetailText
        
        let textChoiceOneText4 = NSLocalizedString("I do not talk more than usual.", comment: "")
        let textChoiceTwoText4 = NSLocalizedString("I occasionally talk more than usual.", comment: "")
        let textChoiceThreeText4 = NSLocalizedString("I often talk more than usual.", comment: "")
        let textChoiceFourText4 = NSLocalizedString("I frequently talk more than usual.", comment: "")
        let textChoiceFiveText4 = NSLocalizedString("I talk constantly and cannot be interrupted.", comment: "")
        
        let textChoices4 = [
            ORKTextChoice(text: textChoiceOneText4, value: "choice_54" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText4, value: "choice_55" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText4, value: "choice_56" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText4, value: "choice_57" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFiveText4, value: "choice_58" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat4 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices4)
        
        let questionStep4 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep4), title: exampleQuestionText4, answer: answerFormat4)
        
        questionStep4.text = exampleDetailText
        
        let textChoiceOneText5 = NSLocalizedString("I have not been more active (either socially, sexually, at work, home or school) than usual.", comment: "")
        let textChoiceTwoText5 = NSLocalizedString("I have occasionally been more active than usual.", comment: "")
        let textChoiceThreeText5 = NSLocalizedString("I have often been more active than usual.", comment: "")
        let textChoiceFourText5 = NSLocalizedString("I have frequently been more active than usual.", comment: "")
        let textChoiceFiveText5 = NSLocalizedString("I am constantly active or on the go all the time.", comment: "")
        
        let textChoices5 = [
            ORKTextChoice(text: textChoiceOneText5, value: "choice_59" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText5, value: "choice_60" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText5, value: "choice_61" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText5, value: "choice_62" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFiveText5, value: "choice_63" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat5 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices5)
        
        let questionStep5 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep5), title: exampleQuestionText5, answer: answerFormat5)
        
        questionStep5.text = exampleDetailText
        
        return ORKOrderedTask(identifier: String(describing:Identifier.AltmanTask), steps: [questionStep1, questionStep2, questionStep3, questionStep4, questionStep5])
    }
    
    /**
     PHQ-9
     */
    private var PHQ9Task: ORKTask {
        let textChoiceOneText1 = NSLocalizedString("Not at all", comment: "")
        let textChoiceTwoText1 = NSLocalizedString("Several days", comment: "")
        let textChoiceThreeText1 = NSLocalizedString("More than half the days", comment: "")
        let textChoiceFourText1 = NSLocalizedString("Nearly every day", comment: "")
        
        let textChoices1 = [
            ORKTextChoice(text: textChoiceOneText1, value: "choice_64" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText1, value: "choice_65" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText1, value: "choice_66" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText1, value: "choice_67" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat1 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices1)
        
        let questionStep1 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep1), title: exampleQuestionText1a, answer: answerFormat1)
        
        questionStep1.text = exampleDetailText1a
        
        let textChoiceOneText2 = NSLocalizedString("Not at all", comment: "")
        let textChoiceTwoText2 = NSLocalizedString("Several days", comment: "")
        let textChoiceThreeText2 = NSLocalizedString("More than half the days", comment: "")
        let textChoiceFourText2 = NSLocalizedString("Nearly every day", comment: "")
        
        let textChoices2 = [
            ORKTextChoice(text: textChoiceOneText2, value: "choice_68" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText2, value: "choice_69" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText2, value: "choice_70" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText2, value: "choice_71" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat2 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices2)
        
        let questionStep2 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep2), title: exampleQuestionText2a, answer: answerFormat2)
        
        questionStep2.text = exampleDetailText2a
        
        let textChoiceOneText3 = NSLocalizedString("Not at all", comment: "")
        let textChoiceTwoText3 = NSLocalizedString("Several days", comment: "")
        let textChoiceThreeText3 = NSLocalizedString("More than half the days", comment: "")
        let textChoiceFourText3 = NSLocalizedString("Nearly every day", comment: "")
        
        let textChoices3 = [
            ORKTextChoice(text: textChoiceOneText3, value: "choice_72" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText3, value: "choice_73" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText3, value: "choice_74" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText3, value: "choice_75" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat3 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices3)
        
        let questionStep3 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep3), title: exampleQuestionText3a, answer: answerFormat3)
        
        questionStep3.text = exampleDetailText3a
        
        let textChoiceOneText4 = NSLocalizedString("Not at all", comment: "")
        let textChoiceTwoText4 = NSLocalizedString("Several days", comment: "")
        let textChoiceThreeText4 = NSLocalizedString("More than half the days", comment: "")
        let textChoiceFourText4 = NSLocalizedString("Nearly every day", comment: "")
        
        let textChoices4 = [
            ORKTextChoice(text: textChoiceOneText4, value: "choice_76" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText4, value: "choice_77" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText4, value: "choice_78" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText4, value: "choice_79" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat4 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices4)
        
        let questionStep4 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep4), title: exampleQuestionText4a, answer: answerFormat4)
        
        questionStep4.text = exampleDetailText4a
        
        let textChoiceOneText5 = NSLocalizedString("Not at all", comment: "")
        let textChoiceTwoText5 = NSLocalizedString("Several days", comment: "")
        let textChoiceThreeText5 = NSLocalizedString("More than half the days", comment: "")
        let textChoiceFourText5 = NSLocalizedString("Nearly every day", comment: "")
        
        let textChoices5 = [
            ORKTextChoice(text: textChoiceOneText5, value: "choice_80" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText5, value: "choice_81" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText5, value: "choice_82" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText5, value: "choice_83" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat5 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices5)
        
        let questionStep5 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep5), title: exampleQuestionText5a, answer: answerFormat5)
        
        questionStep5.text = exampleDetailText5a
        
        let textChoiceOneText6 = NSLocalizedString("Not at all", comment: "")
        let textChoiceTwoText6 = NSLocalizedString("Several days", comment: "")
        let textChoiceThreeText6 = NSLocalizedString("More than half the days", comment: "")
        let textChoiceFourText6 = NSLocalizedString("Nearly every day", comment: "")
        
        let textChoices6 = [
            ORKTextChoice(text: textChoiceOneText6, value: "choice_84" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText6, value: "choice_85" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText6, value: "choice_86" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText6, value: "choice_87" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat6 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices6)
        
        let questionStep6 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep6), title: exampleQuestionText6a, answer: answerFormat6)
        
        questionStep6.text = exampleDetailText6a
        
        let textChoiceOneText7 = NSLocalizedString("Not at all", comment: "")
        let textChoiceTwoText7 = NSLocalizedString("Several days", comment: "")
        let textChoiceThreeText7 = NSLocalizedString("More than half the days", comment: "")
        let textChoiceFourText7 = NSLocalizedString("Nearly every day", comment: "")
        
        let textChoices7 = [
            ORKTextChoice(text: textChoiceOneText7, value: "choice_88" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText7, value: "choice_89" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText7, value: "choice_90" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText7, value: "choice_91" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat7 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices7)
        
        let questionStep7 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep7), title: exampleQuestionText7a, answer: answerFormat7)
        
        questionStep7.text = exampleDetailText7a
        
        let textChoiceOneText8 = NSLocalizedString("Not at all", comment: "")
        let textChoiceTwoText8 = NSLocalizedString("Several days", comment: "")
        let textChoiceThreeText8 = NSLocalizedString("More than half the days", comment: "")
        let textChoiceFourText8 = NSLocalizedString("Nearly every day", comment: "")
        
        let textChoices8 = [
            ORKTextChoice(text: textChoiceOneText8, value: "choice_92" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText8, value: "choice_93" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText8, value: "choice_94" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText8, value: "choice_95" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat8 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices8)
        
        let questionStep8 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep8), title: exampleQuestionText8a, answer: answerFormat8)
        
        questionStep8.text = exampleDetailText8a
        
        let textChoiceOneText9 = NSLocalizedString("Not at all", comment: "")
        let textChoiceTwoText9 = NSLocalizedString("Several days", comment: "")
        let textChoiceThreeText9 = NSLocalizedString("More than half the days", comment: "")
        let textChoiceFourText9 = NSLocalizedString("Nearly every day", comment: "")
        
        let textChoices9 = [
            ORKTextChoice(text: textChoiceOneText9, value: "choice_96" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText9, value: "choice_97" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText9, value: "choice_98" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText9, value: "choice_99" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat9 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices9)
        
        let questionStep9 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep9), title: exampleQuestionText9a, answer: answerFormat9)
        
        questionStep9.text = exampleDetailText9a
        
        let textChoiceOneText10 = NSLocalizedString("Not difficult at all", comment: "")
        let textChoiceTwoText10 = NSLocalizedString("Somewhat difficult", comment: "")
        let textChoiceThreeText10 = NSLocalizedString("Very difficult", comment: "")
        let textChoiceFourText10 = NSLocalizedString("Extremely difficult", comment: "")
        
        let textChoices10 = [
            ORKTextChoice(text: textChoiceOneText10, value: "choice_100" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceTwoText10, value: "choice_101" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceThreeText10, value: "choice_102" as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: textChoiceFourText10, value: "choice_103" as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let answerFormat10 = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices10)
        
        let questionStep10 = ORKQuestionStep(identifier: String(describing:Identifier.textChoiceQuestionStep10), title: exampleQuestionText10a, answer: answerFormat10)
        
        return ORKOrderedTask(identifier: String(describing:Identifier.PHQ9Task), steps: [questionStep1, questionStep2, questionStep3, questionStep4, questionStep5, questionStep6, questionStep7, questionStep8, questionStep9, questionStep10])
    }
    
    /// This task presents the Reaction Time pre-defined active task.
    private var reactionTimeTask: ORKTask {
        /// An example of a custom sound.
        let successSoundURL = Bundle.main.url(forResource:"tap", withExtension: "aif")!
        let successSound = SystemSound(soundURL: successSoundURL)!
        return ORKOrderedTask.reactionTime(withIdentifier: String(describing:Identifier.reactionTime), intendedUseDescription: exampleDescription, maximumStimulusInterval: 10, minimumStimulusInterval: 4, thresholdAcceleration: 0.5, numberOfAttempts: 3, timeout: 3, successSound: successSound.soundID, timeoutSound: 0, failureSound: UInt32(kSystemSoundID_Vibrate), options: [])
    }
    
    /// This task presents the Spatial Span Memory pre-defined active task.
    private var spatialSpanMemoryTask: ORKTask {
        return ORKOrderedTask.spatialSpanMemoryTask(withIdentifier: String(describing:Identifier.spatialSpanMemoryTask), intendedUseDescription: exampleDescription, initialSpan: 3, minimumSpan: 2, maximumSpan: 15, playSpeed: 1.0, maximumTests: 5, maximumConsecutiveFailures: 3, customTargetImage: nil, customTargetPluralName: nil, requireReversal: false, options: [])
    }
    
    /// This task presents a trail making task
    private var trailMaking: ORKTask {
        let intendedUseDescription = "Tests visual attention and task switching"
        return ORKOrderedTask.trailmakingTask(withIdentifier: String(describing: Identifier.trailMaking), intendedUseDescription: intendedUseDescription, trailmakingInstruction: nil, trailType:"B", options: [])
    }
    
    // MARK: `ORKTask` Reused Text Convenience
    
    private var exampleDescription: String {
        return NSLocalizedString("", comment: "")
    }
    
    private var exampleSpeechInstruction: String {
        return NSLocalizedString("Your more specific voice instruction goes here. For example, say 'Aaaah'.", comment: "")
    }
    
    private var exampleQuestionText: String {
        return NSLocalizedString("Your question goes here.", comment: "")
    }
    
    private var energyQuestionText: String {
        return NSLocalizedString("On a scale of 1 to 10, please rate your energy level right now.", comment: "")
    }
    private var moodQuestionText: String {
        return NSLocalizedString("On a scale of 1 to 10, please rate your mood right now.", comment: "")
    }
    
    private var speedQuestionText: String {
        return NSLocalizedString("On a scale of 1 to 10, how fast are your thoughts right now?", comment: "")
    }
    
    private var impulsivenessthoughtsQuestionText: String {
        return NSLocalizedString("On a scale of 1 to 10, how impulsive are your thoughts right now?", comment: "")
    }
    
    private var impulsivenessactionsQuestionText: String {
        return NSLocalizedString("On a scale of 1 to 10, how impulsive are your actions right now?", comment: "")
    }
    
    private var exampleQuestionText1: String {
        return NSLocalizedString("Positive Mood", comment: "")
    }
    
    private var exampleQuestionText2: String {
        return NSLocalizedString("Self-Confidence", comment: "")
    }
    
    private var exampleQuestionText3: String {
        return NSLocalizedString("Sleep Patterns", comment: "")
    }
    
    private var exampleQuestionText4: String {
        return NSLocalizedString("Speech", comment: "")
    }
    
    private var exampleQuestionText5: String {
        return NSLocalizedString("Activity Level", comment: "")
    }
    
    private var exampleQuestionTextb: String {
        return NSLocalizedString("Has there ever been a period of time when you were not your usual self and...", comment: "")
    }
    
    private var exampleQuestionTextb4: String {
        return NSLocalizedString("Has a health professional ever told you that you have manic-depressive illness or bipolar disorder?", comment: "")
    }
    
    private var exampleQuestionTextb3: String {
        return NSLocalizedString("Have any of your blood relatives (i.e. children, siblings, parents, grandparents, aunts, uncles) had manic-depressive illness or bipolar disorder?", comment: "")
    }
    
    private var exampleQuestionTextb2: String {
        return NSLocalizedString("How much of a problem did any of these cause you – like being unable to work; having family, money or legal troubles; getting into arguments or fights?", comment: "")
    }
    
    private var exampleQuestionTextb1: String {
        return NSLocalizedString("If you checked YES to more than one of the above, have several of these ever happened during the same period of time?", comment: "")
    }
    
    private var exampleQuestionText1a: String {
        return NSLocalizedString("Over the last 2 weeks, how often have you been bothered by any of the following problems?", comment: "")
    }
    
    private var exampleQuestionText2a: String {
        return NSLocalizedString("Over the last 2 weeks, how often have you been bothered by any of the following problems?", comment: "")
    }
    
    private var exampleQuestionText3a: String {
        return NSLocalizedString("Over the last 2 weeks, how often have you been bothered by any of the following problems?", comment: "")
    }
    
    private var exampleQuestionText4a: String {
        return NSLocalizedString("Over the last 2 weeks, how often have you been bothered by any of the following problems?", comment: "")
    }
    
    private var exampleQuestionText5a: String {
        return NSLocalizedString("Over the last 2 weeks, how often have you been bothered by any of the following problems?", comment: "")
    }
    
    private var exampleQuestionText6a: String {
        return NSLocalizedString("Over the last 2 weeks, how often have you been bothered by any of the following problems?", comment: "")
    }
    
    private var exampleQuestionText7a: String {
        return NSLocalizedString("Over the last 2 weeks, how often have you been bothered by any of the following problems?", comment: "")
    }
    
    private var exampleQuestionText8a: String {
        return NSLocalizedString("Over the last 2 weeks, how often have you been bothered by any of the following problems?", comment: "")
    }
    
    private var exampleQuestionText9a: String {
        return NSLocalizedString("Over the last 2 weeks, how often have you been bothered by any of the following problems?", comment: "")
    }
    
    private var exampleQuestionText10a: String {
        return NSLocalizedString("If you checked off any problems, how difficult have these problems made it for you to do your work, take care of things at home, or get along with other people?", comment: "")
    }
    
    
    private var exampleHighValueText: String {
        return NSLocalizedString("Very high", comment: "")
    }
    
    private var exampleLowValueText: String {
        return NSLocalizedString("Very low", comment: "")
    }
    
    private var speedHighValueText: String {
        return NSLocalizedString("Very fast", comment: "")
    }
    
    private var speedLowValueText: String {
        return NSLocalizedString("Very slow", comment: "")
    }
    
    private var impulsivenessHighValueText: String {
        return NSLocalizedString("Very much", comment: "")
    }
    
    private var impulsivenessLowValueText: String {
        return NSLocalizedString("Not at all", comment: "")
    }
    
    private var exampleDetailText: String {
        return NSLocalizedString("", comment: "")
    }
    
    private var exampleDetailText1b: String {
        return NSLocalizedString("...you felt so good or so hyper that other people thought you were not your normal self, or you were so hyper that you got into trouble?", comment: "")
    }
    
    private var exampleDetailText2b: String {
        return NSLocalizedString("...you were so irritable that you shouted at people or started fights or arguments?", comment: "")
    }
    
    private var exampleDetailText3b: String {
        return NSLocalizedString("...you felt much more self-confident than usual?", comment: "")
    }
    
    private var exampleDetailText4b: String {
        return NSLocalizedString("...you got much less sleep than usual and found you didn't really miss it?", comment: "")
    }
    
    private var exampleDetailText5b: String {
        return NSLocalizedString("...you were much more talkative or spoke faster than usual?", comment: "")
    }
    
    private var exampleDetailText6b: String {
        return NSLocalizedString("...thoughts raced through your head or you couldn't slow your mind down?", comment: "")
    }
    
    private var exampleDetailText7b: String {
        return NSLocalizedString("...you were so easily distracted by things around you that you had trouble concentrating or staying on track?", comment: "")
    }
    
    private var exampleDetailText8b: String {
        return NSLocalizedString("...you had much more energy than usual?", comment: "")
    }
    
    private var exampleDetailText9b: String {
        return NSLocalizedString("...you were much more active or did many more things than usual?", comment: "")
    }
    
    private var exampleDetailText10b: String {
        return NSLocalizedString("...you were much more social or outgoing than usual; for example, you telephoned friends in the middle of the night?", comment: "")
    }
    
    private var exampleDetailText11b: String {
        return NSLocalizedString("...you were much more interested in sex than usual?", comment: "")
    }
    
    private var exampleDetailText12b: String {
        return NSLocalizedString("...you did things that were unusual for you or that other people might have thought were excessive, foolish, or risky?", comment: "")
    }
    
    private var exampleDetailText13b: String {
        return NSLocalizedString("...spending money got you or your family into trouble?", comment: "")
    }
    
    private var exampleDetailText1a: String {
        return NSLocalizedString("Little interest or pleasure in doing things", comment: "")
    }
    
    private var exampleDetailText2a: String {
        return NSLocalizedString("Feeling down, depressed, or hopeless", comment: "")
    }
    
    private var exampleDetailText3a: String {
        return NSLocalizedString("Trouble falling or staying asleep, or sleeping too much", comment: "")
    }
    
    private var exampleDetailText4a: String {
        return NSLocalizedString("Feeling tired or having little energy", comment: "")
    }
    
    private var exampleDetailText5a: String {
        return NSLocalizedString("Poor appetite or overeating", comment: "")
    }
    
    private var exampleDetailText6a: String {
        return NSLocalizedString("Feeling bad about yourself—or that you are a failure or have let yourself or your family down", comment: "")
    }
    
    private var exampleDetailText7a: String {
        return NSLocalizedString("Trouble concentrating on things, such as reading the newspaper or watching television", comment: "")
    }
    
    private var exampleDetailText8a: String {
        return NSLocalizedString("Moving or speaking so slowly that other people could have noticed? Or the opposite—being so fidgety or restless that you have been moving around a lot more than usual", comment: "")
    }
    
    private var exampleDetailText9a: String {
        return NSLocalizedString("Thoughts that you would be better off dead or of hurting yourself in some way", comment: "")
    }
    
    private var exampleEmailText: String {
        return NSLocalizedString("jappleseed@example.com", comment: "")
    }
    
    private var loremIpsumText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
    
    private var loremIpsumShortText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    }
    
    private var loremIpsumMediumText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam adhuc, meo fortasse vitio, quid ego quaeram non perspicis. Plane idem, inquit, et maxima quidem, qua fieri nulla maior potest. Quonam, inquit, modo?"
    }
    
    private var loremIpsumLongText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam adhuc, meo fortasse vitio, quid ego quaeram non perspicis. Plane idem, inquit, et maxima quidem, qua fieri nulla maior potest. Quonam, inquit, modo? An potest, inquit ille, quicquam esse suavius quam nihil dolere? Cave putes quicquam esse verius. Quonam, inquit, modo?"
    }
}
