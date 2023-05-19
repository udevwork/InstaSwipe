import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Text("Winst")
                .font(.system(size: 60, weight: .black, design: .rounded))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .foregroundColor(.textColor)
    
        }.background {
            Image("LounchScreenBG").resizable().aspectRatio(contentMode: .fill)
        }
    }
}


struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
