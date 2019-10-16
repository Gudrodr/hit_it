//
//  AboutView.swift
//  Uno
//
//  Created by Everard on 16.10.2019.
//  Copyright © 2019 Untitled. All rights reserved.
//

import SwiftUI

struct AboutView: View {
  
  struct HeadStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Gill Sans", size: 30))
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
  }
  
  struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Gill Sans", size: 16))
        .padding(.leading, 60)
        .padding(.trailing, 60)
        .padding(.bottom, 20)
    }
  }
  
  var body: some View {
    Group {
      VStack {
        Text("🎯 Попади в цель 🎯").modifier(HeadStyle())
        Text("Цель игры - угадать положение бегунка на слайдере соответствующее сгенерированному числу.").modifier(TextStyle())
        Text("Чем ближе к цели удалось уставноить бегунок, тем больше начисляется очков.").modifier(TextStyle())
        Text("У игры нет логического конца.").modifier(TextStyle())
      }
      .background(Color(red: 255 / 255, green: 214 / 255, blue: 179 / 255, opacity: 1))
      .navigationBarTitle("Об игре")
    }
  .background(Image("Background"))
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
    AboutView().previewLayout(.fixed(width: 812, height: 375))
  }
}
