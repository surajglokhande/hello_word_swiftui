//
//  EmbededImageAttachmentView.swift
//  
//
//  Created by Suraj Lokhande2 on 08/12/25.
//
import SwiftUI

struct EmbededImageAttachmentView: View {
    let attachment: Attachment
    let imageName = "image"
    @Binding var isShowingAttachmentView: Bool
    let attachmentViewerAnimation: Namespace.ID
    @State var isShowingOptions = false
    
    var body: some View {
        ZStack {
            Rectangle()
            // Color.clear doesn't always listen or respond to a tap,
            // using a nearly clear color still allows our onTapGesture
            // to work as expected.
                .fill(isShowingOptions ? Color.white.opacity(0.001) : Color.black)
            
            attachment.image
                .resizable()
                .scaledToFit()
                .panToMove()
                .pinchToZoom()
                .matchedGeometryEffect(id: attachment.id, in: attachmentViewerAnimation)
        }
        .background()
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            withAnimation {
                isShowingOptions.toggle()
            }
        }
        .swipeToDismiss($isShowingAttachmentView)
        .overlay(alignment: .bottom) {
            if isShowingOptions {
                HStack {
                    ShareLink(item: attachment.image, preview: SharePreview(attachment.fileName, image: attachment.image)) {
                        Image(systemName: "square.and.arrow.up")
                    }
                    Spacer()
                    Button {
                        // launch reactions
                    } label: {
                        Image(systemName: "plus.message")
                    }
                    Spacer()
                    Button {
                        // launch reply
                    } label: {
                        Image(systemName: "arrowshape.turn.up.backward")
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(attachment.fileName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarVisibility(isShowingOptions ? .visible : .hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem {
                Button("Done") {
                    withAnimation {
                        isShowingAttachmentView.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @Namespace var attachmentViewerAnimation
    
    NavigationStack {
        EmbededImageAttachmentView(
            attachment: octopusAttachment,
            isShowingAttachmentView: .constant(true),
            attachmentViewerAnimation: attachmentViewerAnimation
        )
    }
}
