import SwiftUI
import UIKit
import AVFoundation

struct ContentView: View {
    @StateObject var soundPlayer = SoundPlayer()
    @State var pokemonNameText = "ポケモン"
    @State private var ply = 0
    @State private var cmp = 0
    @State private var msg = "ポケモン!GO！"
    @State private var plyScore = 0
    @State private var cmpScore = 0
    @State private var isPokemonMaster = false
    
    var body: some View {
        ZStack {
            Image("back")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("　   @24CM0126_TAOZHEDAN")
                        .font(.custom("DotGothic16-Regular", size: 15))
                        .bold()
                        .foregroundColor(.white)
                    Spacer()
                }
                
                VStack {
                    Image("poke")
                        .resizable()
                        .frame(width: 370, height: 140)
//                        .offset(x: -5) //iphone12 preview
                }
                
                VStack {
                    HStack {
                        Spacer()
                        if cmp == 0 {
                            Image("kusa")
                                .resizable()
                                .frame(width: 170, height: 170)
                        } else if cmp == 1 {
                            Image("mizu")
                                .resizable()
                                .frame(width: 170, height: 170)
                        } else if cmp == 2 {
                            Image("houno")
                                .resizable()
                                .frame(width: 170, height: 170)
                        }
                    }
                    .offset(y: 60)
                    
                    VStack {
                        Text(msg)
                            .font(.custom("DotGothic16-Regular", size: 30))
                            .padding(.top)
                            .foregroundColor(.black)
                            .offset(y: 25)
                        
                        VStack {
                            HStack {
                                if ply == 0 {
                                    Image("kusa")
                                        .resizable()
                                        .frame(width: 170, height: 170)
                                } else if ply == 1 {
                                    Image("mizu")
                                        .resizable()
                                        .frame(width: 170, height: 170)
                                } else if ply == 2 {
                                    Image("houno")
                                        .resizable()
                                        .frame(width: 170, height: 170)
                                }
                                Spacer()
                            }
                            .offset(y: -25)
                            
                            Text(pokemonNameText)
                                .font(.custom("DotGothic16-Regular", size: 25))
                                .bold()
                                .foregroundColor(.white)
                                .offset(x: 14, y: -55)
                        }
                        
                        Group {
                            if isPokemonMaster {
                                Text("百連勝！")
                                    .foregroundColor(.red)
                                    .bold()
                                Text("ポケモンマスターに俺はなる！")
                                    .foregroundColor(.red)
                                    .bold()
                            } else {
                                Text("勝: \(plyScore)")
                                Text("敗: \(cmpScore)")
                                Text("勝負数：\(plyScore + cmpScore)")
                            }
                        }
                        .font(.custom("DotGothic16-Regular", size: 20))
                        .bold()
                        .offset(y: -5)
//                        .offset(y: -15) //iphone12 preview
                    }
                }
                .frame(width: 350, height: 450)
                .background(
                    Image("background")
                        .resizable()
                        .scaledToFit()
                        .shadow(color: .black, radius: 5, x: 0, y: 5)
                )
                .offset(y: -30)
//                .offset(x: -5,y: -30) //iphone12 preview
                
                Spacer()
                
                HStack {
                    Button(action: {
                        self.ply = 0
                        self.cmp = chooseCom()
                        let result = hantei(player: self.ply, com: self.cmp)
                        self.msg = printMessage(result: result)
                        if result == 0 {
                            self.plyScore += 1
                        } else if result == 1 {
                            self.cmpScore += 1
                        }
                        
                        if self.plyScore >= 100 {
                            self.isPokemonMaster = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.plyScore = 0
                                self.cmpScore = 0
                                self.isPokemonMaster = false
                            }
                        }
                        
                    }) {
                        Image("grass")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .shadow(color: .black, radius: 5, x: 5, y: 5)
                    }
                    
                    Button(action: {
                        self.ply = 1
                        self.cmp = chooseCom()
                        let result = hantei(player: self.ply, com: self.cmp)
                        self.msg = printMessage(result: result)
                        if result == 1 {
                            self.plyScore += 1
                        } else if result == 1 {
                            self.cmpScore += 1
                        }
                        
                        if self.plyScore >= 100 {
                            self.isPokemonMaster = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.plyScore = 0
                                self.cmpScore = 0
                                self.isPokemonMaster = false
                            }
                        }
                    }) {
                        Image("water")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .shadow(color: .black, radius: 5, x: 5, y: 5)
                    }
                    
                    Button(action: {
                        self.ply = 2
                        self.cmp = chooseCom()
                        let result = hantei(player: self.ply, com: self.cmp)
                        self.msg = printMessage(result: result)
                        if result == 2 {
                            self.plyScore += 1
                        } else if result == 1 {
                            self.cmpScore += 1
                        }
                        
                        if self.plyScore >= 100 {
                            self.isPokemonMaster = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.plyScore = 0
                                self.cmpScore = 0
                                self.isPokemonMaster = false
                            }
                        }
                    }) {
                        Image("fire")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .shadow(color: .black, radius: 5, x: 5, y: 5)
                    }
                }
            }
        }
        .onAppear {
            soundPlayer.playSound(FileName: "bgm", FileType: "wav", loop: true, volume: 1.0)
        }
    }
    
    func pokemonNameChanger(id: Int) {
        switch id {
        case 0:
            pokemonNameText = "ニャウハ"
        case 1:
            pokemonNameText = "クワっス"
        case 2:
            pokemonNameText = "ホゲータ"
        default:
            pokemonNameText = ""
        }
        
    }
    
    func hantei(player: Int, com: Int) -> Int {
        var result: Int = 0 // 0:勝ち,1:負け,2:あいこ
        
        if player == com {
            result = 2
        } else if (player == 0 && com == 1) || (player == 1 && com == 2) || (player == 2 && com == 0) {
            result = 0
        } else {
            result = 1
        }
        return result
    }
    
    func printMessage(result: Int) -> String {
        var message: String = ""
        if result == 2 {
            message = "あいこ"
        } else if result == 1 {
            message = "ちくしょう！"
        } else if result == 0 {
            message = "よっしゃー！"
        } else {
            message = "???"
        }
        return message
    }
    
    func chooseCom() -> Int {
        let num = Int.random(in: 0...2)
        pokemonNameChanger(id: num)
        return num
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
