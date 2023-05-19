//
//  TemplateMenuItemView.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 19.03.2023.
//

import SwiftUI

struct TemplateMenuItemView: View {
    
    @State private var isPressed = false
    
    @Binding var topitem: TemplateProtocol?
    @Binding var animate: Bool
    @Binding var needSubscribe: Bool
    
    var namespace: Namespace.ID
    var item: TemplateProtocol
    var index: Int
    var bgColor: Color
    
    var editbleImage: AnyView
    var editble: TemplateProtocol
    
    init(needSubscribe: Binding<Bool>,
         animate: Binding<Bool>,
         topitem: Binding<TemplateProtocol?>,
         namespace: Namespace.ID,
         item: TemplateProtocol,
         index: Int,
         bgColor: Color) {
        self.item = item
        self.index = index
        self.bgColor = bgColor
        editbleImage = AnyView((item as! (any View)))
        editble = item
        _topitem = topitem
        _animate = animate
        _needSubscribe = needSubscribe
        self.namespace = namespace
    }
    
    var body: some View {
        
        Button {
            if editble.avalableOnlyInPro && User.shared.isProUser == false {
                needSubscribe = true
            } else {
                topitem = item
                animate = true
                AnalyticsWrapper.OnSelectTemplate(item.blockNameInMenu)
            }
        } label: {
            
            VStack(alignment: .leading, spacing: 30) {
                
                VStack(spacing: 30) {
                    
                    HStack(spacing: 0) {
                        SubSectionTitleView(text: (item as TemplateProtocol).blockNameInMenu)
                        Spacer()
//                        if editble.avalableOnlyInPro && User.shared.isProUser == false {
//                            Text("PRO").ProButtonStyle()
//                        }
                    }
                    
                    HStack(alignment:.top, spacing: 20) {
                    
                            Image(editble.blockIconImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .matchedGeometryEffect(id: editble.blockNameInMenu, in: namespace)
                                .clipShape(RoundedRectangle(cornerRadius: 10 , style: .continuous))
                                .disabled(true)
                                .lightShadow()
                                .padding(10)
                                .frame(width: UIScreen.main.bounds.width / 4,
                                       height: UIScreen.main.bounds.width / 4)
                                .background {
                                    Color.lightGray
                                    
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 20 , style: .continuous))
                                
                        
                        Text((item as TemplateProtocol).blockDescription)
                            .lineLimit(8)
                            .multilineTextAlignment(.leading)
                            .font(.system(.footnote, design: .rounded, weight: .medium))
                            .foregroundColor(.secondaryTextColor)
                        
                    }
                }
                
             
                
            }
            
            .foregroundColor(.black)
            .padding(.vertical,30)
            .padding(.horizontal, 40)
            .background(bgColor)
            .clipShape(RoundedRectangle(cornerRadius: 34 , style: .continuous))
            
            
        }
            .buttonStyle(PlainButtonStyle())
            .lightShadow()
    }
}

struct TemplateMenuView: View {
    @Binding var animate: Bool
    var namespace: Namespace.ID
    @Binding var topitem: TemplateProtocol?
    @Binding var needSubscribe: Bool
    
    let items: [Any] = [TextBlockView(),
                        ImageWithMenuTemplate(),
                        MenuWithImageTemplate(),
                        LargeMenuWithTemplate(),
                        ImageWithLargeMenuTemplate(),
                        StoriesTextBlockView()]
    
    var body: some View {

            
            VStack(spacing: 20) {

                ForEach(0 ..< items.count, id: \.self) { index in
                    
                    if let item = (items[index] as? TextBlockView) {
                        TemplateMenuItemView(needSubscribe: $needSubscribe,
                                             animate: $animate,
                                             topitem: $topitem,
                                             namespace: namespace,
                                             item: item,
                                             index: index+1,
                                             bgColor: .white )
                    }
                    
                    else if let item = (items[index] as? ImageWithMenuTemplate) {
                        TemplateMenuItemView(needSubscribe: $needSubscribe,
                                             animate: $animate,
                                             topitem: $topitem,
                                             namespace: namespace,
                                             item: item,
                                             index: index+1,
                                             bgColor: .white)
                    }

                    else if let item = (items[index] as? MenuWithImageTemplate) {
                        TemplateMenuItemView(needSubscribe: $needSubscribe,
                                             animate: $animate,
                                             topitem: $topitem,
                                             namespace: namespace,
                                             item: item,
                                             index: index+1,
                                             bgColor: .white)
                    }

                    else if let item = (items[index] as? LargeMenuWithTemplate) {
                        TemplateMenuItemView(needSubscribe: $needSubscribe,
                                             animate: $animate,
                                             topitem: $topitem,
                                             namespace: namespace,
                                             item: item,
                                             index: index+1,
                                             bgColor: .white)
                    }

                    else if let item = (items[index] as? ImageWithLargeMenuTemplate) {
                        TemplateMenuItemView(needSubscribe: $needSubscribe,
                                             animate: $animate,
                                             topitem: $topitem,
                                             namespace: namespace,
                                             item: item,
                                             index: index+1,
                                             bgColor: .white)
                    }
                    
                    else  if let item = (items[index] as? StoriesTextBlockView) {
                        TemplateMenuItemView(needSubscribe: $needSubscribe,
                                             animate: $animate,
                                             topitem: $topitem,
                                             namespace: namespace,
                                             item: item,
                                             index: index+1,
                                             bgColor: .white)
                    }
                    
                    else {
                        EmptyView()
                    }

                }

            }
        
    }
}
