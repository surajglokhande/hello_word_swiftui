//
//  NamespaceBootcamp.swift
//  hello_word_swiftui
//
//  Created by Suraj Lokhande2 on 08/12/25.
//

import SwiftUI

struct NamespaceBootcamp: View {
    @State var isShowingAFish = false
    @State var isShowingAnOctopus = false
    @State var isShowingAJelly = false
    @Namespace var attachmentViewerAnimation
    
    var body: some View {
        NavigationStack {
            ZStack {
                HStack {
                    VStack {
                        Spacer()
                        if !isShowingAFish {
                            Button {
                                withAnimation {
                                    isShowingAFish.toggle()
                                }
                            } label: {
                                AsyncImage(url: URL(string: fishAttachment.thumbnails.large.url)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(16)
                                } placeholder: {
                                    fishAttachment.image
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(16)
                                }
                            }
                            .matchedGeometryEffect(id: fishAttachment.id, in: attachmentViewerAnimation)
                            .frame(width: 100, height: 75)
                        }
                    }
                    
                    Spacer()
                    if !isShowingAJelly {
                        Button {
                            withAnimation {
                                isShowingAJelly.toggle()
                            }
                        } label: {
                            AsyncImage(url: URL(string: jellyAttachment.thumbnails.large.url)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(16)
                            } placeholder: {
                                jellyAttachment.image
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(16)
                            }
                        }
                        .matchedGeometryEffect(id: jellyAttachment.id, in: attachmentViewerAnimation)
                        .frame(width: 100, height: 75)
                    }
                    Spacer()
                    
                    VStack {
                        if !isShowingAnOctopus {
                            Button {
                                withAnimation {
                                    isShowingAnOctopus.toggle()
                                }
                            } label: {
                                AsyncImage(url: URL(string: octopusAttachment.thumbnails.large.url)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(16)
                                } placeholder: {
                                    octopusAttachment.image
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(16)
                                }
                            }
                            .matchedGeometryEffect(id: octopusAttachment.id, in: attachmentViewerAnimation)
                            .frame(width: 100, height: 75)
                        }
                        Spacer()
                    }
                    
                }.padding()
            }
            .overlay {
                if isShowingAFish {
                    // NOTICE: THIS IS USING THE LOCAL ONLY VIEW (NO ASYNCIMAGE)
                    EmbededImageAttachmentView(
                        attachment: fishAttachment,
                        isShowingAttachmentView: $isShowingAFish,
                        attachmentViewerAnimation: attachmentViewerAnimation
                    )
                } else if isShowingAnOctopus {
                    AttachmentInspectorView(
                        attachment: octopusAttachment,
                        isShowingAttachmentView: $isShowingAnOctopus,
                        attachmentViewerAnimation: attachmentViewerAnimation
                    )
                } else if isShowingAJelly {
                    AttachmentInspectorView(
                        attachment: jellyAttachment,
                        isShowingAttachmentView: $isShowingAJelly,
                        attachmentViewerAnimation: attachmentViewerAnimation
                    )
                }
            }
        }
    }
}

#Preview {
    NamespaceBootcamp()
}
