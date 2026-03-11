//
//  ImageDetailView.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import SwiftUI
import Kingfisher

struct ImageDetailView: View {
    @StateObject var viewModel: ImageDetailViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            KFImage(URL(string: "https://picsum.photos/id/\(viewModel.image.id ?? "")/300"))
                .placeholder {
                    Color.gray.opacity(0.3)
                }
                .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 300, height: 300)))
                .scaleFactor(UIScreen.main.scale)
                .cacheOriginalImage()
                .fade(duration: 0.25)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .clipped()
            
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
            
            List {
                ForEach(viewModel.comments, id: \.id) { comment in
                    CommentRowView(comment: comment)
                        .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                viewModel.deleteComment(comment: comment)
                            } label: {
                                Text("Delete")
                            }
                        }
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Image Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation {
                        viewModel.addComment()
                    }
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            viewModel.getComments()
        }
    }
}

struct CommentRowView: View {
    let comment: UserComment
    
    private func relativeTime(for date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: date, relativeTo: Date())
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(Color.gray.opacity(0.8))
                .frame(width: 40, height: 40)
                .overlay(
                    Text(comment.authorInitial ?? "")
                        .font(.subheadline)
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(comment.authorFullName ?? "")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(comment.text ?? "")
                    .font(.body)
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(relativeTime(for: comment.createdAt ?? Date()))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}
