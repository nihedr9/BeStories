//
//  StoryDetailsView.swift
//  BeStories
//
//  Created by Nihed Majdoub on 27/03/2025.
//

import SwiftUI
import Kingfisher

struct StoryDetailsView: View {
  
  let viewModel: StoriesDetailsViewModel
  
  @Environment(\.dismiss) private var dismiss
  
  private var isLiked: Bool {
    viewModel.story.isLiked
  }
  
  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      
      GeometryReader { geo in
        
        KFImage(viewModel.story.mediaUrl)
          .resizable()
          .fade(duration: 0.2)
          .aspectRatio(contentMode: .fill)
          .frame(width: geo.size.width)
          .ignoresSafeArea()
          .overlay(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
              ProgressView(
                timerInterval: viewModel.progressInterval,
                countsDown: false,
                label: EmptyView.init,
                currentValueLabel: EmptyView.init
              )
              .tint(.white)
              .progressViewStyle(.linear)
              
              HStack {
                KFImage(.init(string: viewModel.story.user.avatar))
                  .resizable()
                  .fade(duration: 0.2)
                  .scaledToFill()
                  .frame(width: 40, height: 40)
                  .clipShape(Circle())
                
                Text(viewModel.story.user.name)
                  .font(.callout)
                
                Button {
                  viewModel.toggleIsLiked()
                } label: {
                  Image(systemName: isLiked ? "heart.fill" :  "heart")
                    .font(.title3)
                    .foregroundStyle(isLiked ? .red : .white)
                }
                
                Spacer()
                
                Button {
                  dismissView()
                } label: {
                  Image(systemName: "xmark")
                    .font(.title)
                }
              }
              .foregroundStyle(.white)
            }
            .padding()
          }
        
      }
    }
    .onAppear { viewModel.scheduleTimer(action: dismissView) }
    .onDisappear { viewModel.invalidateTimer() }
  }
  
  private func dismissView() {
    dismiss.callAsFunction()
  }
}
