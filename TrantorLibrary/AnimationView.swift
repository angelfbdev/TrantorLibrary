//
//  AnimationView.swift
//  TrantorLibrary
//
//  Created by Angel Fernandez Barrios on 2/3/23.
//

import SwiftUI

struct AnimationView: View {
    @EnvironmentObject var vm: GeneralViewModel
    @State var animation = false
    
    var body: some View {
        Image("trantor")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                    vm.screen = .login
                }
            }
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
            .environmentObject(GeneralViewModel())
    }
}
