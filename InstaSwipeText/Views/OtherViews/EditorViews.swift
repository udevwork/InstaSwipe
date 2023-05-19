//
//  EditorViews.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 10.03.2023.
//

import Foundation
import SwiftUI

struct ColorPalette: Hashable {
    let paletteName     : String
    let backgroundColor : Color
    let mainColor       : Color
    let secondaryColor  : Color
    let additionalColor : Color
}

struct PaletteView: View {
    let palette: ColorPalette
    let circlesize:CGFloat = 18
    var body: some View {
        HStack(spacing: 15) {
            Circle()
                .foregroundColor(palette.backgroundColor)
                .frame(width: circlesize, height: circlesize)
            Text(palette.paletteName).font(.system(.body, design: .rounded, weight: .bold))
        }.LightGrayViewStyle()
    }
}

struct PaletteBrowser: View {
    
    @Namespace private var namespace
    @State var animate: Bool = false
    
    @EnvironmentObject var settings: EditorSettings
    let fonts: [ColorPalette] = ColorPalettes
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 0) {
                SpacingView(side: .horizontal, size: horPadding)
                ForEach(self.fonts, id: \.self) { plt in
                    ZStack {
                        if settings.colors == plt {
                            VStack(spacing: 10) {
                                PaletteView(palette: plt)
                                    .matchedGeometryEffect(id: plt.paletteName, in: namespace)
                                Circle().frame(width: 6, height: 6).foregroundColor(.textColor)
                            }
                        } else {
                            PaletteView(palette: plt).onTapGesture {
                                animate.toggle()
                                settings.colors = plt
                            }.matchedGeometryEffect(id: plt.paletteName, in: namespace)
                        }
                    }.animation(Animation.spring(), value: animate)
                    SpacingView(side: .horizontal, size: 20)
                }.padding(1)
                
            }
        }
    }
}

struct FontPalette: Hashable {
    let paletteName         : String
    let titleFontDesign     : Font.Design
    let titleFontWeight     : Font.Weight
    let articleFontDesign   : Font.Design
    let articleFontWeight   : Font.Weight
}

struct FontView: View {
    let font: FontPalette
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(font.paletteName)
                .font(.system(.body, design: font.titleFontDesign, weight: font.titleFontWeight))
        }
    }
}

struct FontBrowser: View {
    
    @Namespace private var namespace
    @State var animate: Bool = false
    @EnvironmentObject var settings: EditorSettings
    let fonts: [FontPalette] = FontPalettes
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 0) {
                SpacingView(side: .horizontal, size: horPadding)
                ForEach(self.fonts, id: \.self) { font in
                    ZStack {
                        if settings.fonts == font {
                            VStack(spacing: 10) {
                                FontView(font: font)
                                    .LightGrayViewStyle()
                                    .matchedGeometryEffect(id: font.paletteName, in: namespace)
                                Circle().frame(width: 6, height: 6).foregroundColor(.textColor)
                            }//.frame(height: 30)
                        } else {
                            
                            FontView(font: font).onTapGesture {
                                animate.toggle()
                                settings.fonts = font
                            }.LightGrayViewStyle()
                                .matchedGeometryEffect(id: font.paletteName, in: namespace)
                            
                        }
                    }.animation(Animation.spring(), value: animate)
                    SpacingView(side: .horizontal, size: 20)
                }.padding(1)
                
            }
        }
    }
}


struct EditorMenuView_Previews: PreviewProvider {
    
    @State static var item: TemplateProtocol? = MenuWithImageTemplate()
    @Namespace static var namespace
    static var screenHeight = UIScreen.main.bounds.height

    static var previews: some View {
      
        NavigationStack {
            VStack {
                ScreenContentView {
                    
                 
                    
                    VStack {
                        SectionTitleView(text: "L_ChooseFontButtonText".localized()).padding(.horizontal, horPadding)
                        FontBrowser().environmentObject(EditorSettings())
                        Spacer()
                    }
                    
                    
                }.frame(height: screenHeight/3)
                
                ScreenContentView {
                    
                    
                    
                    
                    
                    VStack {
                        SectionTitleView(text: "L_SelectColorButtonText".localized()).padding(.horizontal, horPadding)
                        PaletteBrowser().environmentObject(EditorSettings())
                        Spacer()
                    }
                    

                    
                }.frame(height: screenHeight/3)
                
            }
        }.preferredColorScheme(.light)

        
    }
}
