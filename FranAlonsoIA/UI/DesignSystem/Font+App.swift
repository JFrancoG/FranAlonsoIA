//
//  Font+App.swift
//  FranAlonsoIA
//
//  Created by Jesús Franco on 17.09.2025.
//

import SwiftUI

enum FontSize: CGFloat {
    case title = 32
    case subtitle = 24
    case body = 17
    case caption = 13
    
    var size: CGFloat { rawValue }
}

extension Font {
    static var interTitle: Font { .custom("Inter-SemiBold", size: FontSize.title.size) }
    static var interSubtitle: Font { .custom("Inter-Medium", size: FontSize.subtitle.size) }
    static var interBody: Font { .custom("Inter-Regular", size: FontSize.body.size) }
    static var interCaption: Font { .custom("Inter-Regular", size: FontSize.caption.size) }
}


