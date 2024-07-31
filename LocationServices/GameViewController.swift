

import UIKit


enum Side {
    case West, East
}


class GameViewController: UIViewController {


    let manager = GameManager()
    var gameTimer: Timer?
    var timeElapsed: TimeInterval = 0
    var lastCardFlipTick: TimeInterval = Date.now.timeIntervalSince1970

    var scorePc: Int = 0
    var scorePlayer: Int = 0
    var eastSideCard: String?
    var westSideCard: String?
    
    var side: Side?
    var userName: String?
    
    var isRunning = true
    
    var winScore = 3
    
    @IBOutlet weak var pWestNameLabel: UILabel!
    
    @IBOutlet weak var pWestScoreLabel: UILabel!
    
    @IBOutlet weak var pEastNameLabel: UILabel!
    
    @IBOutlet weak var pEastScoreLabel: UILabel!
    
    
    @IBOutlet weak var pWestCardImage: UIImageView!
    @IBOutlet weak var pEastCardImage: UIImageView!
    
    @IBOutlet weak var stopBtn: UIImageView!
    
    @IBOutlet weak var clockImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clockImage.image = UIImage(named: "alarm")
        
        if let side = side, let name = userName {
            switch side {
                case .West:
                self.pWestNameLabel.text = name
                self.pEastNameLabel.text = "PC"
            case .East:
                self.pEastNameLabel.text = name
                self.pWestNameLabel.text = "PC"
            }
        }
        self.timeLabel.text = "00:00"
        self.nextRound()
        startGame()
        self.stopBtn.isUserInteractionEnabled = true

        self.stopBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pauseStartButtonAction)))
   
    }
    
    @objc func pauseStartButtonAction() {
        if isRunning {
            stopGame()
            self.stopBtn.image = UIImage(systemName: "restart.circle.fill")
        }
        else {
            startGame()
            self.stopBtn.image = UIImage(systemName: "stop.circle.fill")
        }
        isRunning = !isRunning
    }
    
    func startGame() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            [weak self] t in
            if let strongSelf = self {

                let currentTime = Date.now.timeIntervalSince1970
                let elapsedLastFlipTick = Int((currentTime - strongSelf.lastCardFlipTick))
    
                
                if elapsedLastFlipTick >= 5 {
                    DispatchQueue.main.async {
                        strongSelf.checkRoundWinner()
                        strongSelf.flipBack()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            strongSelf.nextRound()
                    }
                    strongSelf.lastCardFlipTick = currentTime

                }
                strongSelf.timeElapsed += 1
                strongSelf.updateTimer()
            }
        }
    }
    
    func stopGame() {
        gameTimer?.invalidate()
        gameTimer = nil
    }
    
    func updateTimer() {
        
        let min = Int(timeElapsed / 60)
        let sec = Int(timeElapsed) % 60
        let minString = min < 10 ? "0\(min)" : "\(min)'"
        let secString = sec < 10 ? "0\(sec)" : "\(sec)'"

        self.timeLabel.text = "\(minString):\(secString)"
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopGame()
    }
    
    
    func checkRoundWinner() {
        if let pcCard = side == .West ? eastSideCard : westSideCard,
           let ourCard = side == .West ? westSideCard : eastSideCard {
            let comparison = manager.compare(card1: pcCard, card2: ourCard)
            switch comparison {
                case 0: // tie
                    print("Tie")
                case 1: // pc wins
                    scorePc += 1
                case -1:
                    scorePlayer += 1
                default:
                    print("Should not reach here!")
            }
        }
        if side == .West {
            self.pWestScoreLabel.text = "\(scorePlayer)"
            self.pEastScoreLabel.text = "\(scorePc)"
        }
        else {
            self.pWestScoreLabel.text = "\(scorePc)"
            self.pEastScoreLabel.text = "\(scorePlayer)"
        }
        
        if scorePc == winScore {
            finishGame(winner: "PC")
        }
        else if scorePlayer == winScore {
            finishGame(winner: userName!)
        }
    }
    
    
    func finishGame(winner: String) {
        if let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "FinishVc") as? FinishViewController {
            vc.winner = winner
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    func flipBack() {
        self.pWestCardImage.image = UIImage(named: GameManager.cardBacks[0])
        self.pEastCardImage.image = UIImage(named: GameManager.cardBacks[0])
    }
    
    
    func nextRound() {
        let cards = manager.randomCardPair()

        eastSideCard = cards[1]
        westSideCard = cards[0]
        self.pWestCardImage.image = UIImage(named: cards[0])
        self.pEastCardImage.image = UIImage(named: cards[1])
    }
    
    
}
