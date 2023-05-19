import Foundation
import UIKit
import SwiftUI

let horPadding: CGFloat = 40
let verPadding: CGFloat = 10

let BGColor = Color(uiColor: UIColor(hex: "F4F8FE")!)
let EditorBGColor = Color(uiColor: UIColor(hex: "f5f8fc")!)

let BGEditorColor = Color(uiColor: UIColor(hex: "bfbfbf")!)


let accentColor2 = Color(uiColor: UIColor(hex: "323735")!)

let ColorPalettes = [
    // белый
    ColorPalette(paletteName: "Pure white",
                 backgroundColor: Color(uiColor: UIColor(hex: "FFFFFF")!),
                 mainColor: Color(uiColor: UIColor(hex: "2c2c2c")!),
                 secondaryColor: Color(uiColor: UIColor(hex: "464646")!),
                 additionalColor: Color(uiColor: UIColor(hex: "404040")!)) ,
    
    // серый
    ColorPalette(paletteName: "Agate grey",
                 backgroundColor: Color(uiColor: UIColor(hex: "2c2c2c")!),
                 mainColor: Color(uiColor: UIColor(hex: "FFFFFF")!),
                 secondaryColor: Color(uiColor: UIColor(hex: "FFFFFF")!),
                 additionalColor: Color(uiColor: UIColor(hex: "A5A9B3")!)) ,
    
    // черный
    ColorPalette(paletteName: "Сompletely black",
                 backgroundColor: Color(uiColor: UIColor(hex: "000000")!),
                 mainColor: Color(uiColor: UIColor(hex: "ffffff")!),
                 secondaryColor: Color(uiColor: UIColor(hex: "c7c7c7")!),
                 additionalColor: Color(uiColor: UIColor(hex: "c7c7c7")!)) ,
    
    // Фирменный цвет приложения
    ColorPalette(paletteName: "The Blue",
                 backgroundColor: Color(uiColor: UIColor(hex: "5A9CFF")!),
                 mainColor: Color(uiColor: UIColor(hex: "FFFFFF")!),
                 secondaryColor: Color(uiColor: UIColor(hex: "FFFFFF")!),
                 additionalColor: Color(uiColor: UIColor(hex: "FFFFFF")!)) ,
    
    ColorPalette(paletteName: "Soft Blossom",
    backgroundColor: Color(uiColor: UIColor(hex: "fceee3")!),
    mainColor: Color(uiColor: UIColor(hex: "604032")!),
    secondaryColor: Color(uiColor: UIColor(hex: "875d44")!),
    additionalColor: Color(uiColor: UIColor(hex: "e6b8a6")!)),

    ColorPalette(paletteName: "Morning Mist",
    backgroundColor: Color(uiColor: UIColor(hex: "e6f0f6")!),
    mainColor: Color(uiColor: UIColor(hex: "3a536f")!),
    secondaryColor: Color(uiColor: UIColor(hex: "3a536f")!),
    additionalColor: Color(uiColor: UIColor(hex: "78a5c8")!)),

    ColorPalette(paletteName: "Lilac Breeze",
    backgroundColor: Color(uiColor: UIColor(hex: "f2e8f4")!),
    mainColor: Color(uiColor: UIColor(hex: "4f3d68")!),
    secondaryColor: Color(uiColor: UIColor(hex: "4f3d68")!),
    additionalColor: Color(uiColor: UIColor(hex: "ab94c7")!)),

    ColorPalette(paletteName: "Mellow Mint",
    backgroundColor: Color(uiColor: UIColor(hex: "eaf7e9")!),
    mainColor: Color(uiColor: UIColor(hex: "3b654f")!),
    secondaryColor: Color(uiColor: UIColor(hex: "3b654f")!),
    additionalColor: Color(uiColor: UIColor(hex: "7fc99a")!)),

    ColorPalette(paletteName: "Dewy Peach",
    backgroundColor: Color(uiColor: UIColor(hex: "fff0e7")!),
    mainColor: Color(uiColor: UIColor(hex: "b5654a")!),
    secondaryColor: Color(uiColor: UIColor(hex: "b5654a")!),
    additionalColor: Color(uiColor: UIColor(hex: "f7c8a8")!)),

    ColorPalette(paletteName: "Whispering Willow",
    backgroundColor: Color(uiColor: UIColor(hex: "e8f5e5")!),
    mainColor: Color(uiColor: UIColor(hex: "2f5e3a")!),
    secondaryColor: Color(uiColor: UIColor(hex: "2f5e3a")!),
    additionalColor: Color(uiColor: UIColor(hex: "86c87a")!)),

    ColorPalette(paletteName: "Hazy Lavender",
    backgroundColor: Color(uiColor: UIColor(hex: "f0e8f6")!),
    mainColor: Color(uiColor: UIColor(hex: "6a4a7c")!),
    secondaryColor: Color(uiColor: UIColor(hex: "6a4a7c")!),
    additionalColor: Color(uiColor: UIColor(hex: "b897cf")!)),
    
    ColorPalette(paletteName: "Sunset Blush",
    backgroundColor: Color(uiColor: UIColor(hex: "fff0e6")!),
    mainColor: Color(uiColor: UIColor(hex: "b56d54")!),
    secondaryColor: Color(uiColor: UIColor(hex: "b56d54")!),
    additionalColor: Color(uiColor: UIColor(hex: "f7c3ab")!)),

    ColorPalette(paletteName: "Gentle Rain",
    backgroundColor: Color(uiColor: UIColor(hex: "eaf3f7")!),
    mainColor: Color(uiColor: UIColor(hex: "456578")!),
    secondaryColor: Color(uiColor: UIColor(hex: "456578")!),
    additionalColor: Color(uiColor: UIColor(hex: "8db1c6")!)),

    ColorPalette(paletteName: "Serene Sky",
    backgroundColor: Color(uiColor: UIColor(hex: "e9f5f9")!),
    mainColor: Color(uiColor: UIColor(hex: "3f6073")!),
    secondaryColor: Color(uiColor: UIColor(hex: "3f6073")!),
    additionalColor: Color(uiColor: UIColor(hex: "7eb0cc")!)),

    ColorPalette(paletteName: "Heavenly Rose",
    backgroundColor: Color(uiColor: UIColor(hex: "fdf1f3")!),
    mainColor: Color(uiColor: UIColor(hex: "8c424d")!),
    secondaryColor: Color(uiColor: UIColor(hex: "8c424d")!),
    additionalColor: Color(uiColor: UIColor(hex: "e7a1a9")!)),

    ColorPalette(paletteName: "Dreamy Dusk",
    backgroundColor: Color(uiColor: UIColor(hex: "f6f2ff")!),
    mainColor: Color(uiColor: UIColor(hex: "5d497a")!),
    secondaryColor: Color(uiColor: UIColor(hex: "5d497a")!),
    additionalColor: Color(uiColor: UIColor(hex: "a99cd3")!)),
    
    ColorPalette(paletteName: "Midnight Blue",
    backgroundColor: Color(uiColor: UIColor(hex: "1e2b42")!),
    mainColor: Color(uiColor: UIColor(hex: "f0e8c8")!),
    secondaryColor: Color(uiColor: UIColor(hex: "f0e8c8")!),
    additionalColor: Color(uiColor: UIColor(hex: "5681a0")!)),

    ColorPalette(paletteName: "Deep Forest",
    backgroundColor: Color(uiColor: UIColor(hex: "1c3a27")!),
    mainColor: Color(uiColor: UIColor(hex: "e6f0d8")!),
    secondaryColor: Color(uiColor: UIColor(hex: "e6f0d8")!),
    additionalColor: Color(uiColor: UIColor(hex: "559d6e")!)),

    ColorPalette(paletteName: "Shadow Wine",
    backgroundColor: Color(uiColor: UIColor(hex: "3c1d2a")!),
    mainColor: Color(uiColor: UIColor(hex: "f4e3e9")!),
    secondaryColor: Color(uiColor: UIColor(hex: "f4e3e9")!),
    additionalColor: Color(uiColor: UIColor(hex: "8a5571")!)),

    ColorPalette(paletteName: "Eclipse Gray",
    backgroundColor: Color(uiColor: UIColor(hex: "2c2c2e")!),
    mainColor: Color(uiColor: UIColor(hex: "f0f0f0")!),
    secondaryColor: Color(uiColor: UIColor(hex: "f0f0f0")!),
    additionalColor: Color(uiColor: UIColor(hex: "828282")!)),

    ColorPalette(paletteName: "Velvet Night",
    backgroundColor: Color(uiColor: UIColor(hex: "2d1f3c")!),
    mainColor: Color(uiColor: UIColor(hex: "e9e3f1")!),
    secondaryColor: Color(uiColor: UIColor(hex: "e9e3f1")!),
    additionalColor: Color(uiColor: UIColor(hex: "72628d")!)),
    
    ColorPalette(paletteName: "Starry Sky",
    backgroundColor: Color(uiColor: UIColor(hex: "1c2b3d")!),
    mainColor: Color(uiColor: UIColor(hex: "f0e9d9")!),
    secondaryColor: Color(uiColor: UIColor(hex: "f0e9d9")!),
    additionalColor: Color(uiColor: UIColor(hex: "547da2")!)),

    ColorPalette(paletteName: "Noir Night",
    backgroundColor: Color(uiColor: UIColor(hex: "1f1f1f")!),
    mainColor: Color(uiColor: UIColor(hex: "f1f1f1")!),
    secondaryColor: Color(uiColor: UIColor(hex: "f1f1f1")!),
    additionalColor: Color(uiColor: UIColor(hex: "7a7a7a")!)),

    ColorPalette(paletteName: "Twilight Teal",
    backgroundColor: Color(uiColor: UIColor(hex: "1b383a")!),
    mainColor: Color(uiColor: UIColor(hex: "e5f1ef")!),
    secondaryColor: Color(uiColor: UIColor(hex: "e5f1ef")!),
    additionalColor: Color(uiColor: UIColor(hex: "568f93")!)),

    ColorPalette(paletteName: "Mystic Maroon",
    backgroundColor: Color(uiColor: UIColor(hex: "3b1e2d")!),
    mainColor: Color(uiColor: UIColor(hex: "f3e5ea")!),
    secondaryColor: Color(uiColor: UIColor(hex: "f3e5ea")!),
    additionalColor: Color(uiColor: UIColor(hex: "8b5971")!)),

    ColorPalette(paletteName: "Obsidian Ocean",
    backgroundColor: Color(uiColor: UIColor(hex: "1d2f35")!),
    mainColor: Color(uiColor: UIColor(hex: "eef3f3")!),
    secondaryColor: Color(uiColor: UIColor(hex: "eef3f3")!),
    additionalColor: Color(uiColor: UIColor(hex: "588698")!)),
]

let FontPalettes = [
    
    FontPalette(paletteName: "Regular",
                titleFontDesign:    .serif,
                titleFontWeight:    .ultraLight,
                articleFontDesign:  .serif,
                articleFontWeight:  .regular),
    
    FontPalette(paletteName: "Bold",
                titleFontDesign:    .serif,
                titleFontWeight:    .bold,
                articleFontDesign:  .default,
                articleFontWeight:  .regular),
    
    FontPalette(paletteName: "Rounded",
                titleFontDesign:    .serif,
                titleFontWeight:    .bold,
                articleFontDesign:  .rounded,
                articleFontWeight:  .regular),

    FontPalette(paletteName: "Monospaced",
                titleFontDesign:    .monospaced,
                titleFontWeight:    .bold,
                articleFontDesign:  .monospaced,
                articleFontWeight:  .regular),
    
    FontPalette(paletteName: "Ultra-Light",
                titleFontDesign:    .rounded,
                titleFontWeight:    .light,
                articleFontDesign:  .rounded,
                articleFontWeight:  .ultraLight),
    
    
    FontPalette(paletteName: "Elegant Harmony",
    titleFontDesign: .serif,
    titleFontWeight: .bold,
    articleFontDesign: .default,
    articleFontWeight: .regular),

    FontPalette(paletteName: "Sophisticated Duo",
    titleFontDesign: .rounded,
    titleFontWeight: .black,
    articleFontDesign: .serif,
    articleFontWeight: .medium),

    FontPalette(paletteName: "Modern Chic",
    titleFontDesign: .default,
    titleFontWeight: .heavy,
    articleFontDesign: .monospaced,
    articleFontWeight: .light),

    FontPalette(paletteName: "Classic Allure",
    titleFontDesign: .serif,
    titleFontWeight: .medium,
    articleFontDesign: .default,
    articleFontWeight: .semibold),

    FontPalette(paletteName: "Contemporary Contrast",
    titleFontDesign: .rounded,
    titleFontWeight: .thin,
    articleFontDesign: .monospaced,
    articleFontWeight: .bold),
    
    FontPalette(paletteName: "Timeless Grace",
    titleFontDesign: .serif,
    titleFontWeight: .ultraLight,
    articleFontDesign: .default,
    articleFontWeight: .bold),

    FontPalette(paletteName: "Retro Fusion",
    titleFontDesign: .rounded,
    titleFontWeight: .medium,
    articleFontDesign: .default,
    articleFontWeight: .thin),

    FontPalette(paletteName: "Sleek Simplicity",
    titleFontDesign: .default,
    titleFontWeight: .regular,
    articleFontDesign: .monospaced,
    articleFontWeight: .medium),

    FontPalette(paletteName: "Artistic Edge",
    titleFontDesign: .serif,
    titleFontWeight: .light,
    articleFontDesign: .rounded,
    articleFontWeight: .semibold),

    FontPalette(paletteName: "Urban Rhythm",
    titleFontDesign: .monospaced,
    titleFontWeight: .bold,
    articleFontDesign: .default,
    articleFontWeight: .light),

    FontPalette(paletteName: "Bold Elegance",
    titleFontDesign: .serif,
    titleFontWeight: .heavy,
    articleFontDesign: .rounded,
    articleFontWeight: .regular),

    FontPalette(paletteName: "Clean Minimalism",
    titleFontDesign: .default,
    titleFontWeight: .thin,
    articleFontDesign: .monospaced,
    articleFontWeight: .heavy),

    FontPalette(paletteName: "Whimsical Charm",
    titleFontDesign: .rounded,
    titleFontWeight: .semibold,
    articleFontDesign: .serif,
    articleFontWeight: .light),

    FontPalette(paletteName: "Effortless Elegance",
    titleFontDesign: .serif,
    titleFontWeight: .regular,
    articleFontDesign: .default,
    articleFontWeight: .medium),

    FontPalette(paletteName: "Dynamic Duo",
    titleFontDesign: .rounded,
    titleFontWeight: .ultraLight,
    articleFontDesign: .monospaced,
    articleFontWeight: .semibold)
]
