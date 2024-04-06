//
//  GameScreen.swift
//  MemoryGame
//
//  Created by Student on 29.03.2024.
//

import SwiftUI

struct GameScreen: View {
    @ObservedObject var viewModel : GameViewModel
    @State private var playerName: String = ""

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
                else if(viewModel.gameState == .lost || viewModel.gameState == .won){
                    Text(viewModel.gameState == .lost ? "GAME OVER" : "YOU WIN").foregroundStyle(viewModel.gameState == .lost ? ColorScheme.text.color : Color(.green) )
                    ScrollView{
                        LeaderBoard(names: viewModel.leaderBoard)
                    }
                    if(viewModel.gameState == .won && !viewModel.wasSaved){
                        HStack{
                            Text("Enter Name: ")
                                .foregroundColor(Color(.green))
                            TextField(
                                "Player name ",
                                text: $playerName

                            )
                            .autocorrectionDisabled()
                            .onSubmit {
                                viewModel.savePlayer(name: playerName)
                            }
                            .frame(minWidth: 0,maxWidth: .infinity)
                            .border(Color.primary)

                        }
                    }
                    Button {
                        viewModel.resetGameButton()
                    } label: {
                        Text("Retry")
                    }


                }
            }
        }
    }

