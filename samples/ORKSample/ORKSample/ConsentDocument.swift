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

class ConsentDocument: ORKConsentDocument {
    // MARK: Properties
    
    let consent = [
        "How can we better understand the mood fluctuations and subtle cognitive changes in people with bipolar disorder together? \n \n People with bipolar disorder can have very different and more or less severe mood symptoms day to day. This affects quality of life and makes managing treatment difficult. Moreover, recent scientific studies have shown that people with bipolar disorder often have subtle but distinct difficulties with cognition, such as inability to focus, during both depression and mania.  Some people notice that these difficulties do not completely go away even after they fully recover from their mood symptoms. It has been hypothesized that these cognitive difficulties in bipolar disorder strongly predict level of functioning in the future. In this study, we would like to understand the relationship between mood and neurocognitive functioning in bipolar disorder using keystroke dynamics (such as typing speed and typing errors) and other passive sensor information (such as the accelerometer). \n \n Currently, diagnosis and treatment of bipolar disorder rely on careful history taking and mental status examination by an experienced clinician, at times aided by self-report or caretaker-informed questionnaires. In general, these reports have to be interpreted by providers in order to extract patterns that could indicate an imminent change in mood. Moreover, they do not necessarily represent objective psycho-physiological markers. \n \n On the other hand, the pervasive use of mobile wireless devices has significantly shaped interpersonal communications in modern life. Indeed, as personal smartphone technology advances, people are increasingly interacting with one another via typed (rather than oral) communications. For this reason, we want to investigate if keyboard dynamics and sensor data from iPhone serve as more objective biomarkers or “virtual mental-health footprints” of bipolar disorder. \n \n If you decide to join the study you will need to download the study application on your mobile device. This application will install a custom-built keyboard that replaces the standard default iPhone keyboard in order for the researchers to better understand keyboard dynamics metadata (but not to track the actual words). Then periodically we will ask you to answer questions and perform some activities via your mobile phone. These survey questions may be about your health, exercise, diet, sleep, medicines, etc. or about how you are feeling in general. In addition to surveys, the activities will be some brief tasks that you perform while holding your phone for a short period of time. Your study data will include your responses to surveys and the measurements from the phone itself when you perform an activity.",
        "How is your data collected and maintained? \n \n Your data, without your name, will be added to the data of other study participants and analyzed by the study team. You will have a unique account that you can use to review your own data. \n \n We will electronically process your data and separate your account information (name, email, contact information, etc.) from your study data (your responses to surveys and the measurements from the phone itself when you perform activities). We will combine your coded study data (without your name or other identifying information) with those of other study participants. The combined data will be encrypted and transferred electronically to secure servers at Sage Bionetworks (sagebase.org) for storage, and will be accessible by researchers at the University of Illinois at Chicago (www.uic.edu).",
        "How will the information I provide be kept confidential? \n \n We are committed to protect your information and keep your identity as confidential as possible, however total confidentiality cannot be guaranteed. Except as required by law, you will not be identified by name or by any other direct personal identifier. The data collected through the app will be encrypted on the smartphone, transferred electronically and stored securely on the data repository and analysis platform using cloud services at Sage Bionetworks. Your contact information, including your name and e-mail address will be stored separately from the study data. We will use a random code number instead of your name on all your study data. This code cannot be used to directly identify you. Information about the code will be kept in a secure system. \n \n We will not access your personal contacts, other applications, text or email message content, or websites visited. We will never sell, rent or lease your contact information.",
        "How will the data collected be utilized? \n \n The research team will analyze the combined data and report findings back to the community through blogs or scientific publications. Your data, without your name, will be added to the data of other study participants and may be analyzed by the study team. You will have a unique account that you can use to review your own data.",
        "How much time will study activities require? \n \n This study should take you about 10 minutes each week. We will send notices on your phone asking you to complete these activities and surveys. You may choose to act at your convenience, (either then or later) and you may choose to participate in all or only in some parts of the study. You can adjust the app settings to turn on and off sending data at any time.",
        "What kinds of questions will the surveys ask? \n \n We will periodically ask you to answer questions about yourself, your medical history, and your current health and symptoms to track changes. You may skip any questions that you do not wish to answer.",
        "What kinds of tasks need to be performed? \n \n We will ask you to perform specific tasks weekly while holding or using your mobile phone and record sensor data directly from your phone. ",
        "How can I withdraw from this study? \n \n Your participation in this study is voluntary. You do not have to sign this consent form. But if you do not, you will not be able to participate in this research study. You may decide not to participate or you may leave the study at any time. Your decision will not result in any penalty or loss of benefits to which you are entitled. \n \n Although you can withdraw from the study at any time, you cannot withdraw the coded study data that have already been distributed. If you withdraw from the study, we will stop collecting new data but the coded data that you have already provided will not be able to be destroyed or deleted. \n \n The Study Principal Investigator or the sponsor may also withdraw you from the study without your consent at any time for any reason, including if it is in your best interest, you do not consent to continue in the study after being told of changes in the research that may affect you, or if the study is cancelled."
    ]
    
    // MARK: Initialization
    
    override init() {
        super.init()
        
        title = NSLocalizedString("BiAffect Study Consent Form", comment: "")
        
        let sectionTypes: [ORKConsentSectionType] = [
            .overview,
            .dataGathering,
            .privacy,
            .dataUse,
            .timeCommitment,
            .studySurvey,
            .studyTasks,
            .withdrawing
        ]
        
        sections = zip(sectionTypes, consent).map { sectionType, consent in
            let section = ORKConsentSection(type: sectionType)
            
            let localizedConsent = NSLocalizedString(consent, comment: "")
            let localizedSummary = localizedConsent.components(separatedBy: ".")[0] + "."
            
            section.summary = localizedSummary
            section.content = localizedConsent
            
            return section
        }
        
        let signature = ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature")
        addSignature(signature)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ORKConsentSectionType: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .overview:
            return "Overview"
            
        case .dataGathering:
            return "DataGathering"
            
        case .privacy:
            return "Privacy"
            
        case .dataUse:
            return "DataUse"
            
        case .timeCommitment:
            return "TimeCommitment"
            
        case .studySurvey:
            return "StudySurvey"
            
        case .studyTasks:
            return "StudyTasks"
            
        case .withdrawing:
            return "Withdrawing"
            
        case .custom:
            return "Custom"
            
        case .onlyInDocument:
            return "OnlyInDocument"
        }
    }
}
