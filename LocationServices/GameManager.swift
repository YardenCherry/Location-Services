

import Foundation

func extractFirstNumber(from input: String) -> Int? {
    let pattern = "\\d+"
    if let range = input.range(of: pattern, options: .regularExpression) {
        let numberString = input[range]
        return Int(numberString)
    }
    return nil
}

class GameManager {
    static let cardNames = [
        "10_of_clubs", "10_of_diamonds", "10_of_hearts", "10_of_spades",
        "2_of_clubs", "2_of_diamonds", "2_of_hearts", "2_of_spades",
        "3_of_clubs", "3_of_diamonds", "3_of_hearts", "3_of_spades",
        "4_of_clubs", "4_of_diamonds", "4_of_hearts", "4_of_spades",
        "5_of_clubs", "5_of_diamonds", "5_of_hearts", "5_of_spades",
        "6_of_clubs", "6_of_diamonds", "6_of_hearts", "6_of_spades",
        "7_of_clubs", "7_of_diamonds", "7_of_hearts", "7_of_spades",
        "8_of_clubs", "8_of_diamonds", "8_of_hearts", "8_of_spades",
        "9_of_clubs", "9_of_diamonds", "9_of_hearts", "9_of_spades",
        "ace_of_clubs", "ace_of_diamonds", "ace_of_hearts", "ace_of_spades", "ace_of_spades2",
        "jack_of_clubs", "jack_of_clubs2", "jack_of_diamonds", "jack_of_diamonds2",
        "jack_of_hearts", "jack_of_hearts2", "jack_of_spades", "jack_of_spades2",
        "king_of_clubs", "king_of_clubs2", "king_of_diamonds", "king_of_diamonds2",
        "king_of_hearts", "king_of_hearts2", "king_of_spades", "king_of_spades2",
        "queen_of_clubs", "queen_of_clubs2", "queen_of_diamonds", "queen_of_diamonds2",
        "queen_of_hearts", "queen_of_hearts2", "queen_of_spades", "queen_of_spades2",
    ]
    static let cardBacks = [ "card back black", "card back red" ]
    
    
    func randomCardPair() -> [String] {
        if let c1 = GameManager.cardNames.randomElement(),
           let c2 = GameManager.cardNames.randomElement() {
            return [c1,c2]
        }
        return []
    }
    
    func compare(card1: String, card2: String) -> Int {
          if card1.contains("ace") {
              return card2.contains("ace") ? 0 : 1
          } else if card2.contains("ace") {
              return card1.contains("ace") ? 0 : -1
          }
          
          if card1.contains("king") {
              return card2.contains("king") ? 0 : 1
          } else if card2.contains("king") {
              return card1.contains("king") ? 0 : -1
          }
          
          if card1.contains("queen") {
              return card2.contains("queen") ? 0 : 1
          } else if card2.contains("queen") {
              return card1.contains("queen") ? 0 : -1
          }
          
          if card1.contains("jack") {
              return card2.contains("jack") ? 0 : 1
          } else if card2.contains("jack") {
              return card1.contains("jack") ? 0 : -1
          }
        
          if let num1 = extractFirstNumber(from: card1),
             let num2 = extractFirstNumber(from: card2) {
              return num1 == num2 ? 0 : (num1 > num2) ? 1 : -1;
          }
        return 0;
    }
}
