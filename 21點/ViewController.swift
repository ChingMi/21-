//
//  ViewController.swift
//  21點
//
//  Created by 黃靖蜜 on 2022/2/20.
//

import UIKit

class ViewController: UIViewController {
    
    let suits = ["♣︎", "♦︎", "♥︎", "♠︎"]
    let ranks = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    var cards = [Card]()
    //生成卡片的function
    func createCards() {
        for suit in suits {
            for rank in ranks {
                let card = Card(suit: suit, rank: rank)
                cards.append(card)
            }
        }
    }
    //玩家的牌
    var playerCard = [Card]()
    //電腦的牌
    var pcCard = [Card]()
    //剩餘籌碼
    var restMoney = 1000
    //賭金
    var betDollars = 100
    //牌的數量
    var cardsIndex = 0
    //玩家點數
    var playerScore = 0
    //電腦點數
    var pcScore = 0
    
    @IBOutlet weak var restDollarsLabel: UILabel!
    @IBOutlet weak var betDollarsLabel: UILabel!
    //電腦的牌圖片
    @IBOutlet var pcCardsImage: [UIImageView]!
    //玩家的牌圖片
    @IBOutlet var playerCardsImage: [UIImageView]!
    //加籌碼的button
    @IBOutlet weak var addBetOutlet: UIButton!
    //開始的button
    @IBOutlet weak var startGameOutlet: UIButton!
    //發牌的button
    @IBOutlet weak var getAnotherCardOutlet: UIButton!
    //停牌的button
    @IBOutlet weak var openCardOutlet: UIButton!
    //贏或輸的outlet
    @IBOutlet weak var winOrLose: UILabel!
    //下一局的button
    @IBOutlet weak var nextGameOutlet: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        winOrLose.isHidden = true
        
    }
    //點擊一次就會+50元籌碼的button
    @IBAction func addBetDollar(_ sender: Any) {
        betDollars += 50
        betDollarsLabel.text = "\(betDollars)"
    }
    //按開始的按鈕，會發兩張牌
    @IBAction func srartGame(_ sender: Any) {
        //按開始後讓一些button出現或消失
        addBetOutlet.isHidden = true
        startGameOutlet.isHidden = true
        getAnotherCardOutlet.isHidden = false
        openCardOutlet.isHidden = false
        winOrLose.isHidden = true
        nextGameOutlet.isHidden = false
        //發兩張牌&計算點數
        createCards()
        for i in 0...1 {
            //計算現在有幾張牌
            cardsIndex += 1
            //發玩家牌
            cards.shuffle()
            playerCard.append(cards[i])
            //玩家的牌所對應的圖片
            playerCardsImage[i].image = UIImage(named: playerCard[i].suit + playerCard[i].rank)
            //玩家的點數
            playerScore += playerCard[i].number
            //發電腦牌
            cards.shuffle()
            pcCard.append(cards[i])
            //電腦的牌所對應的圖片
            pcCardsImage[i].image = UIImage(named: pcCard[i].suit + pcCard[i].rank)
            //電腦的點數
            pcScore += pcCard[i].number
        }
        //確認發牌時有沒有21點
        if playerScore == 21 {
            restDollarsLabel.text = "\(restMoney + 2 * betDollars)"
            winOrLose.isHidden = false
            winOrLose.text = "You Win!!"
            restMoney = restMoney + 2 * betDollars
        }else if pcScore == 21 {
            restDollarsLabel.text = "\(restMoney - 2 * betDollars)"
            winOrLose.isHidden = false
            winOrLose.text = "You Lose!!"
            restMoney = restMoney - 2 * betDollars
        }else if playerScore == 21 , pcScore == 21 {
            restDollarsLabel.text = "\(restMoney - betDollars)"
            winOrLose.isHidden = false
            winOrLose.text = "You Lose!!"
            restMoney -= betDollars
        }
    }
    //加牌
    @IBAction func addCard(_ sender: Any) {
        //先判斷牌數有沒有大於五張才能加牌
        if cardsIndex < 5{
            cardsIndex += 1
            cards.shuffle()
            playerCard.append(cards[cardsIndex - 1])
            playerCardsImage[cardsIndex - 1].image = UIImage(named: playerCard[cardsIndex - 1].suit + playerCard[cardsIndex - 1].rank)
            playerScore += playerCard[cardsIndex - 1].number
            print("player" ,playerScore)
            
            cards.shuffle()
            pcCard.append(cards[cardsIndex - 1])
            pcCardsImage[cardsIndex - 1].image = UIImage(named: pcCard[cardsIndex - 1].suit + pcCard[cardsIndex - 1].rank)
            pcScore += pcCard[cardsIndex - 1].number
            print("pc" ,pcScore)
        }
        //如果其中一方點數爆了就結束遊戲，或是其中一方拿了21點
        if playerScore > 21{
            restDollarsLabel.text = "\(restMoney - betDollars)"
            winOrLose.isHidden = false
            winOrLose.text = "You Lose!!"
            restMoney -= betDollars
        }else if pcScore > 21{
            restDollarsLabel.text = "\(restMoney + betDollars)"
            winOrLose.isHidden = false
            winOrLose.text = "You Win!!"
            restMoney += betDollars
        }else if playerScore > 21 && pcScore > 21 {
            winOrLose.isHidden = false
            winOrLose.text = "雙方都爆了，沒輸沒贏"
        }else if pcScore == 21 {
            restDollarsLabel.text = "\(restMoney - betDollars)"
            winOrLose.isHidden = false
            winOrLose.text = "You Lose!!"
            restMoney -= betDollars
        }else if playerScore == 21 {
            restDollarsLabel.text = "\(restMoney + betDollars)"
            winOrLose.isHidden = false
            winOrLose.text = "You Win!!"
            restMoney += betDollars
        }
        
        //如果牌數有五張，需要衡量玩家跟電腦誰的點數大
        if cardsIndex == 5 {
            if playerScore > pcScore{
                restDollarsLabel.text = "\(restMoney + betDollars)"
                winOrLose.isHidden = false
                winOrLose.text = "You Win!!"
                restMoney += betDollars
            }else if playerScore < pcScore{
                restDollarsLabel.text = "\(restMoney - betDollars)"
                winOrLose.isHidden = false
                winOrLose.text = "You Lose!!"
                restMoney -= betDollars
            }
        }
    }
    //停牌
    @IBAction func StandCard(_ sender: Any) {
        //當電腦點數小於17要繼續補牌
        if cardsIndex < 5 {
            if pcScore < 17 {
                cardsIndex += 1
                cards.shuffle()
                pcCard.append(cards[cardsIndex - 1])
                pcCardsImage[cardsIndex - 1].image = UIImage(named: pcCard[cardsIndex - 1].suit + pcCard[cardsIndex - 1].rank)
                pcScore += pcCard[cardsIndex - 1].number
                //要牌後，如果電腦點數超過21
                if pcScore > 21 {
                    restDollarsLabel.text = "\(restMoney + betDollars)"
                    winOrLose.isHidden = false
                    winOrLose.text = "You Win!!"
                    restMoney += betDollars
                }else if playerScore == 21 , pcScore == 21 {
                    winOrLose.isHidden = false
                    winOrLose.text = "平手"
                }else if pcScore == 21 {
                    restDollarsLabel.text = "\(restMoney - betDollars)"
                    winOrLose.isHidden = false
                    winOrLose.text = "You Lose!!"
                    restMoney -= betDollars
                //比大小
                }else if playerScore > pcScore {
                    restDollarsLabel.text = "\(restMoney + betDollars)"
                    winOrLose.isHidden = false
                    winOrLose.text = "You Win!!"
                    restMoney += betDollars
                }else if playerScore < pcScore {
                    restDollarsLabel.text = "\(restMoney - betDollars)"
                    winOrLose.isHidden = false
                    winOrLose.text = "You Lose!!"
                    restMoney -= betDollars
                }
        //如果電腦點數是17以上，直接比大小
            }else if pcScore > 16 {
                if playerScore > pcScore {
                restDollarsLabel.text = "\(restMoney + betDollars)"
                winOrLose.isHidden = false
                winOrLose.text = "You Win!!"
                restMoney += betDollars
                }else if playerScore < pcScore {
                restDollarsLabel.text = "\(restMoney - betDollars)"
                winOrLose.isHidden = false
                winOrLose.text = "You Lose!!"
                restMoney -= betDollars
                }else {
                winOrLose.isHidden = false
                winOrLose.text = "平手"
                }
            }
        }
    }
   //下一局
    @IBAction func nextGame(_ sender: Any) {
        //重置賭金的label跟變數
         betDollarsLabel.text = "100"
         betDollars = 100
         cardsIndex = 0
         //重置button的顯示
         addBetOutlet.isHidden = false
         startGameOutlet.isHidden = false
         nextGameOutlet.isHidden = true
         startGameOutlet.isHidden = false
         openCardOutlet.isHidden = true
         getAnotherCardOutlet.isHidden = true
         winOrLose.isHidden = true
         //重置雙方的點數
         pcScore = 0
         playerScore = 0
         //重置圖片
         for i in 0...4 {
             playerCardsImage[i].image = nil
             pcCardsImage[i].image = nil
         
         }
        pcCard.removeAll()
        playerCard.removeAll()
        cards.shuffle()
    }
    
   
    
    
}

