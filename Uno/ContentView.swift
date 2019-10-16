//
//  ContentView.swift
//  Uno
//
//  Created by Everard on 14.10.2019.
//  Copyright © 2019 Untitled. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State var alertVisibility = false
  @State var sliderValue = 50.0
  @State var target = Int.random(in: 1...100)
  @State var totalScore = 0
  @State var currentRound = 1
  
  struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.white)
        .modifier(Shadow())
        .font(Font.custom("Gill Sans", size: 18))
    }
  }
  
  struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.yellow)
        .modifier(Shadow())
        .font(Font.custom("Gill Sans", size: 24))
    }
  }
  
  struct Shadow: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .shadow(color: Color.black, radius: 5, x: 2, y: 2)
    }
  }
  
  struct ButtonText: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Gill Sans", size: 18))
        .padding(.vertical, 8)
        .padding(.horizontal, 18)
        .shadow(color: Color.gray, radius: 5, x: 2, y: 2)
    }
  }
  
  struct SecondaryButtonText: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Gill Sans", size: 14))
        .padding(.vertical, 8)
        .padding(.horizontal, 18)
        .shadow(color: Color.gray, radius: 5, x: 2, y: 2)
    }
  }
  
  struct ButtonShape: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .background(LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(6)
        .modifier(Shadow())
    }
  }
  
  func sliderValueRounded() -> Int {
    Int(sliderValue.rounded())
  }
  
  func currentRoundPoints() -> Int {
    let points = 100 - abs(sliderValueRounded() - target)
    if points == 100 {
      return 200
    } else if points == 99 {
      return 150
    }
    return points
  }
  
  func toNextRound() -> Void {
    totalScore += currentRoundPoints()
    target = Int.random(in: 1...100)
    currentRound += 1
  }
  
  func alertTitle() -> String {
    let difference = abs(sliderValueRounded() - target)
    if difference == 0 {
      return "Идеально! *_*"
    } else if difference < 5 {
      return "Горячо >_<"
    } else if difference <= 10 {
      return "Тепло o_o"
    } else {
      return "Прохладно... -_-"
    }
  }
  
  func reset() -> Void {
    sliderValue = 50.0
    totalScore = 0
    currentRound = 1
    target = Int.random(in: 1...100)
  }

  var body: some View {
    VStack {
      Spacer()
      HStack {
        Text("Размести бегунок как можно ближе к числу").modifier(LabelStyle())
        Text("\(target)").modifier(ValueStyle())
      }
      Spacer()
      HStack {
        Text("1").modifier(LabelStyle())
        Slider(value: $sliderValue, in: 1...100).accentColor(.green)
        Text("100").modifier(LabelStyle())
      }
      Spacer()
      
      Button(action: {
        self.alertVisibility = true
      }) {
        Text("Жмяк!")
          .modifier(ButtonText())
      }
      .alert(isPresented: $alertVisibility) { () -> Alert in
        return Alert(
          title: Text(alertTitle()),
          message: Text(
            "The slider's value is \(sliderValueRounded()). \n" +
            "You scored \(currentRoundPoints()) points this round."
          ),
          dismissButton: .default(Text("Ok")) {
            self.toNextRound()
          }
        )
      }
      .modifier(ButtonShape())
      
      Spacer()
      HStack {
        Button(action: {
          self.reset()
        }) {
          HStack {
            Image("StartOverIcon")
            Text("Новая игра")
          }
          .modifier(SecondaryButtonText())
        }
        .modifier(ButtonShape())
        
        Spacer()
        Text("Очки:").modifier(LabelStyle())
        Text("\(totalScore)").modifier(ValueStyle())
        Spacer()
        Text("Раунд:").modifier(LabelStyle())
        Text("\(currentRound)").modifier(ValueStyle())
        Spacer()
        NavigationLink(destination: AboutView()) {
          HStack {
            Image("InfoIcon")
            Text("Информация")
          }
          .modifier(SecondaryButtonText())
        }
        .modifier(ButtonShape())
      }
      .padding(.bottom, 20)
    }
    .background(Image("Background"))
    .navigationBarTitle("Попади в цель")
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView().previewLayout(.fixed(width: 812, height: 375))
    }
}
