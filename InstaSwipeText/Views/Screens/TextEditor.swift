//
//  TextEditor.swift
//  InstaSwipeText
//
//  Created by Denis Kotelnikov on 02.05.2023.
//

import SwiftUI

struct TextEditor: View {
    @EnvironmentObject var textmodel: TextFieldViewModel
    @EnvironmentObject var settings: EditorSettings

    
    @FocusState var isFocused: Bool

    @State private var keyboardHeight: CGFloat = 0

    var body: some View {
            VStack {
                
                TextField("L_EditorNavigationTitle".localized(), text: $textmodel.text, axis: .vertical)
                    .focused($isFocused)
                    .foregroundColor(.white)
                    .font(.system(size: 27, weight: .bold, design: .rounded))
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button("L_ApplyButtonText".localized()) {
                                isFocused = false
                                settings.textEditingMode = false
                            }
                        }
                    }.padding(30)
                SpacingView(side: .verical, size: keyboardHeight)
                
                
            }.background(Color.black.opacity(0.8))
        
            .onAppear {
                addObserver()
                isFocused.toggle()
                AnalyticsWrapper.onScreanAppear("Text editor")
            }
            .onDisappear {
                removeObserver()
            }
            .ignoresSafeArea(.keyboard)
        
    }
    
    private func addObserver() {
          NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
              if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                  keyboardHeight = keyboardFrame.height
              }
          }

          NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
              keyboardHeight = 0
          }
      }

      private func removeObserver() {
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
      }
}

struct TextEditor_Previews: PreviewProvider {
    static var previews: some View {
        TextEditor().environmentObject(TextFieldViewModel(text: ""))
    }
}
