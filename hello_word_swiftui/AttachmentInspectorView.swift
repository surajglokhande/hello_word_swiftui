//
//  AttachmentInspectorView.swift
//  
//
//  Created by Suraj Lokhande2 on 08/12/25.
//
import SwiftUI

struct AttachmentInspectorView: View {
    let attachment: Attachment
    @Binding var isShowingAttachmentView: Bool
    let attachmentViewerAnimation: Namespace.ID
    @State var isShowingOptions = false
    @State var image: Image? = nil
    @State var currentScaleAmount = 0.0
    @State var finalScaleAmount = 0.0
    
    var body: some View {
        ZStack {
            Rectangle()
            // Color.clear doesn't always listen or respond to a tap,
            // using a nearly clear color still allows our onTapGesture
            // to work as expected.
                .fill(isShowingOptions ? Color.white.opacity(0.001) : Color.black)
            
            AsyncImage(url: URL(string: attachment.url)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .onAppear {
                            self.image = image
                        }
                } else if phase.error != nil {
                    // an error occured
                    attachment.image
                        .resizable()
                        .scaledToFit()
                        .onAppear {
                            self.image = image
                        }
                } else {
                    Color.black // Acts as a placeholder.
                }
            }
            .matchedGeometryEffect(id: attachment.id, in: attachmentViewerAnimation)
            .panToMove()
            .pinchToZoom()
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
        AttachmentInspectorView(
            attachment: octopusAttachment,
            isShowingAttachmentView: .constant(true),
            attachmentViewerAnimation: attachmentViewerAnimation
        )
    }
}

