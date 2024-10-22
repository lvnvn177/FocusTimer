//
//  MyConfig.swift
//  FocusTimer
//
//  Created by 이영호 on 10/22/24.
//

import Foundation


struct MyConfig {
    static let bannerAdUnitID: String = Bundle.main.object(forInfoDictionaryKey: "GAD_UNIT_ID_BANNER") as? String ?? ""
}
