//
//  ContentView.swift
//  FacebookUI
//
//  Created by Mauro Canhao on 23/09/2020.
//

import SwiftUI

struct ContentView: View {
    

    let posts = ["1", "2", "3"]
    let colors: [Color] = [.red, .green, .blue]
    let stories = ["1","2","3","1","2","3"]
    
    let boarStory = story(profilePic: "boarP", postPic: "boar", name: "Inounoshishi")
    let chickenStory = story(profilePic: "chickenP", postPic: "chicken", name: "Niwatori")
    let rabbitStory = story(profilePic: "rabbitP", postPic: "rabbit", name: "Usagi")
    let oxStory = story(profilePic: "oxP", postPic: "ox", name: "Ushii")
    
    let boarPost = post(profilePic: "boarP", postPic: "boar", name: "Inounoshishi", time: "8hrs", bodyText: "BOAR TEXT Post body text that supports auto sizing vertically and span multiple lines. Post body text that supports auto sizing vertically and span multiple lines")
    let rabbitPost = post(profilePic: "rabbitP", postPic: "rabbit", name: "Usagi", time: "7hrs", bodyText: "RABBIT TEXT Post body text that supports auto sizing vertically and span multiple lines")
    let chickenPost = post(profilePic: "chickenP", postPic: "chicken", name: "Niwatori", time: "6hrs", bodyText: "CHICKEN TEXT Post body text that supports auto sizing vertically and span multiple lines. Post body text that supports auto sizing ha ha")
    let oxPost = post(profilePic: "oxP", postPic: "ox", name: "Ushii", time: "5hrs", bodyText: "OX TEXT Post body text that supports auto sizing vertically and span multiple lines. Post body text that supports auto sizing vertically and span multiple lines. Post body text that supports auto sizing vertically and span multiple lines.")
    

    

    var body: some View {
        
        let postsFromStruct = [boarPost, rabbitPost, chickenPost, oxPost]
        let storiesFromStruct = [boarStory, rabbitStory, chickenStory, oxStory]
        
        NavigationView{
            
            List{
                
                ScrollView(.horizontal, showsIndicators: false){
                    VStack(alignment: .leading, spacing: 5){
                        Text("Stories")
                            .font(.headline)
                            .padding(.leading, 20)
                        HStack(spacing: 12){
                            padding(.leading, 10)
                            ForEach(storiesFromStruct, id: \.name) { story in
                                StoriesView(sto: story)
                            }
                            padding(.leading, 16)
                        }.frame(height: 90)
                    }
                   
                }.frame(height: 120, alignment: .leading)
                .padding(.leading, -20)
                .padding(.trailing, -20)
                
//                post rows
                ForEach(postsFromStruct, id: \.name) { post in
                    PostView(pos: post)
                }
            }.navigationTitle(Text("Juuni Taisen"))
        }
    }
}

struct PostView: View {
    
    let pos: post
    
    @State var liked = false
    @State var doubleTap = false
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                
                Image(pos.profilePic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .clipShape(Circle())
                    .shadow(color: .gray, radius: 3, x: 0.0, y: 0.0)
                VStack(alignment: .leading, spacing: 2){
                    Text(pos.name).font(.headline)
                    Text("Posted \(pos.time) ago").font(.subheadline).foregroundColor(.gray)
                }.padding(.leading, 8)
            }.padding(.leading)
            .padding(.top, 16)
            Text(pos.bodyText)
                .lineLimit(nil)
                .padding(.leading,16)
                .padding(.trailing,32)

            ZStack{
                Image(pos.postPic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width + 4, height: 400, alignment: .center)
                    .clipped()
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
                    .frame(width: 100, height: 100, alignment: .center)
                    .scaleEffect(doubleTap && liked ? 1.2 : 0)
                    .opacity(doubleTap && liked ? 1 : 0)
            }
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0))
            .onTapGesture(count: 2, perform: {
                doubleTap.toggle()
                liked.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.doubleTap.toggle()
                }
            })
            HStack(spacing: 20){
                Image(systemName: liked ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(liked ? .red : .gray)
                    .onTapGesture(count: 1, perform: {
                        doubleTap.toggle()
                        liked.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            self.doubleTap.toggle()
                        }
                    })
                Image(systemName: "bubble.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.gray)

            }.padding(.leading, 16)
            .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
        }
        .padding(.leading, -20)
    }
}

struct StoriesView: View {
    @State private var isPresented = false
    var sto: story
    var body: some View{
        ZStack{
            Image(sto.profilePic)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70, alignment: .center)
                .clipShape(Circle())
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .clipShape(Circle()
                            .stroke(lineWidth: 5)
                )
                .frame(width: 80, height: 80, alignment: .center)
                
            
        }.onTapGesture(count: 1, perform: {
            self.isPresented.toggle()
        })
        .fullScreenCover(isPresented: $isPresented, content: {
            FullScreenModalView.init(stor: sto)
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            
        }
    }
}

struct post{
    var profilePic = String()
    var postPic = String()
    var name = String()
    var time = String()
    var bodyText = String()
}

struct story{
    var profilePic = String()
    var postPic = String()
    var name = String()
}

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var animate = false
    
    var stor : story
    var body: some View {
        VStack(alignment: .center){
            ZStack(alignment: .top) {
                
                Image(stor.postPic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 14)
                
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.clear]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .opacity(0.5)
                VStack(alignment: .center, spacing: 20){
                    ZStack(alignment: .topLeading){
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .opacity(0.3)
                            .frame(width: 400, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .opacity(1)
                            .frame(width: animate ? 400 : 0, height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .animation(.linear(duration: 10))
                    }
                    
                HStack(alignment: .center, spacing: 15){
                    Image(stor.profilePic)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text(stor.name)
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }.background(Color.clear)
                    
            }.padding()
            .padding(.top,30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.red)
            .edgesIgnoringSafeArea(.all)
            Spacer()
        }.onAppear(perform: {
            animate=true
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                if animate {
                presentationMode.wrappedValue.dismiss()
                    animate=false
                }
            }
        })
        
        
//        .position(x: 86, y: 65)
        
//        .edgesIgnoringSafeArea(.leading)
        .gesture(DragGesture(minimumDistance: 50)
                    .onEnded({ _ in
                        print("dragged")
                        presentationMode.wrappedValue.dismiss()
                        animate=false
                    }))
    }
}
