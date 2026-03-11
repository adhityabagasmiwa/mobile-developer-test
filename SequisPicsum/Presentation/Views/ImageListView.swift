//
//  ImageListView.swift
//  SequisPicsum
//
//  Created by Adhitya Bagasmiwa Permana on 10/03/26.
//

import SwiftUI
import Kingfisher

struct ImageListView: View {
    @StateObject var viewModel: ImageListViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            customHeaderView
            contentScrollView
        }
        .navigationTitle("Image List")
        .toolbar(.hidden, for: .navigationBar)
        .background(Color.white.ignoresSafeArea(edges: .top))
        .onAppear {
            if viewModel.images.isEmpty {
                viewModel.getImages()
            }
        }
    }
    
    private var contentScrollView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                imageRowView
                loadingIndicatorView
            }
            .padding(.top, 16)
            .padding(.bottom, 24)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .refreshable {
            viewModel.getImages(isRefresh: true)
        }
    }
    
    private var imageRowView: some View {
        ForEach(viewModel.images) { image in
            Button(action: {
                viewModel.navigateToDetail(image: image)
            }) {
                ImagePicsumView(image: image)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, 16)
            .onAppear {
                if image == viewModel.images.last {
                    viewModel.getImages()
                }
            }
        }
    }
    
    @ViewBuilder
    private var loadingIndicatorView: some View {
        if viewModel.isLoading {
            ProgressView()
                .padding()
        }
    }
    
    private var customHeaderView: some View {
        VStack(spacing: 0) {
            Text("Image List")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(Color.white)
            Divider()
        }
    }
}

struct ImagePicsumView: View {
    let image: ImagePicsum
    
    var body: some View {
        HStack(spacing: 0) {
            KFImage(URL(string: "https://picsum.photos/id/\(image.id ?? "")/200"))
                .placeholder {
                    Color.gray.opacity(0.3)
                }
                .setProcessor(DownsamplingImageProcessor(size: CGSize(width: 200, height: 200)))
                .scaleFactor(UIScreen.main.scale)
                .cacheOriginalImage()
                .fade(duration: 0.25)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 120)
                .clipped()
            
            VStack(spacing: 4) {
                Text("Author:")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text(image.author ?? "")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 8)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    ImageListView(
        viewModel: ImageListViewModel(
            coordinator: AppCoordinator(),
            getImagesUseCase: GetImagesPicsumUseCase(
                repository: ImagePicsumRepositoryImpl()
            )
        )
    )
}
