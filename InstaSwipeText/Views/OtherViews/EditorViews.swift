//
//  EditorViews.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 10.03.2023.
//

import Foundation
import SwiftUI

// ColorPalette struct is a model that describes a color palette with a name and various color properties.
struct ColorPalette: Hashable {
    let paletteName     : String  // Name of the color palette
    let backgroundColor : Color   // Background color of the palette
    let mainColor       : Color   // Main color of the palette
    let secondaryColor  : Color   // Secondary color of the palette
    let additionalColor : Color   // Additional color of the palette
}

// PaletteView struct is a SwiftUI View that displays a color palette as a circle of color and the name of the palette.
struct PaletteView: View {
    let palette: ColorPalette  // The color palette model
    let circlesize:CGFloat = 18  // The size of the circle representing a color in the palette
    
    var body: some View {
        HStack(spacing: 15) { // Horizontal stack of views
            Circle()  // Draw a circle
                .foregroundColor(palette.backgroundColor)  // Use palette's background color as the circle color
                .frame(width: circlesize, height: circlesize)  // Set circle size
            Text(palette.paletteName).font(.system(.body, design: .rounded, weight: .bold))  // Display palette's name
        }.LightGrayViewStyle()  // Apply custom style to the view
    }
}

// PaletteBrowser struct is a SwiftUI View that displays a horizontal scrolling list of color palettes.
struct PaletteBrowser: View {
    
    @Namespace private var namespace  // Namespace for matched geometry effect
    @State var animate: Bool = false  // State variable to control animation
    
    // EnvironmentObject allows sharing of data across different views
    @EnvironmentObject var settings: EditorSettings
    let fonts: [ColorPalette] = ColorPalettes  // Array of color palettes to display
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) { // Horizontal scroll view
            HStack (spacing: 0) { // Horizontal stack of views
                SpacingView(side: .horizontal, size: horPadding)
                ForEach(self.fonts, id: \.self) { plt in // Loop over each color palette in the array
                    ZStack {  // Stack of views on top of each other
                        if settings.colors == plt {  // If the current palette is selected
                            VStack(spacing: 10) {
                                PaletteView(palette: plt)
                                    .matchedGeometryEffect(id: plt.paletteName, in: namespace) // Create a matched geometry effect
                                Circle().frame(width: 6, height: 6).foregroundColor(.textColor)
                            }
                        } else {
                            PaletteView(palette: plt).onTapGesture {
                                animate.toggle() // Toggle the animation state
                                settings.colors = plt // Update the selected palette
                            }.matchedGeometryEffect(id: plt.paletteName, in: namespace)
                        }
                    }.animation(Animation.spring(), value: animate)  // Apply spring animation
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
