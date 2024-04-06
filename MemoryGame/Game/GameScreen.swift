//
//  GameScreen.swift
//  MemoryGame
//
//  Created by Student on 29.03.2024.
//

import SwiftUI

struct GameScreen: View {
    @ObservedObject var viewModel : GameViewModel
    var body: some View {
        VStack{
            Text(viewModel.title)
                .frame(maxWidth: .infinity, alignment: .leading).font(.title.bold())
            Text("Score:\(viewModel.score)")
                .fontWeight(.bold)
        
            if(viewModel.gameState == .in_progress || viewModel.gameState == .not_started){
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65, maximum: 150))], content: {
                        ForEach(viewModel.cardsList, content: {card in
                            CardUi(color: viewModel.cardsColor, text: card.data, match: card.isMatched, 
                                   cardSymbol: viewModel.cardsSymbol,
                                face: card.isVisible ).onTapGesture {
                                withAnimation(.easeInOut(duration : 1), {
                                    viewModel.chooseCard(card)
                                })
                               
                            }.aspectRatio(2/3, contentMode: .fit)
                        })
                    })
                }
            }
            else{
                Spacer()
                if(viewModel.gameState == .won){
                    Text("You won!!!").foregroundColor(ColorScheme.text.color)
                }
                else{
                    Text("You lost!").foregroundColor(ColorScheme.text.color)
                }
                Spacer()
            }
            if (viewModel.gameState == .not_started) {
                Button(action: {
                    withAnimation{
                        viewModel.shuffleButton()
                    }}, label: {
                    Text("Start").foregroundColor(ColorScheme.text.color)
                })
            } else if (viewModel.gameState == .in_progress) {
                Text("Lives: \(viewModel.model.attemptsLeft)❤️").foregroundColor(ColorScheme.text.color)

                Spacer()
                
                ProgressView(value: viewModel.remainingTime).onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        viewModel.updateTime()
                    }
                }
            }
        }.padding()
    }
}
