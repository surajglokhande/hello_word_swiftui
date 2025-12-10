//
//  Models.swift
//  
//
//  Created by Suraj Lokhande2 on 08/12/25.
//
import SwiftUI

struct Attachment: Identifiable {
    let id: String
    let width: Int
    let height: Int
    let url: String
    let fileName: String
    let size: Int
    let type: String
    let thumbnails: Thumbnails
    // THIS FIELD IS NOT PART OF THE AIRTABLE API, AND IS ONLY REQUIRED
    // BECAUSE THE PUBLIC AIRTABLE LINKS DON'T LIVE VERY LONG. THIS PARAMETER
    // HAS BEEN ADDED SO YOU CAN RUN THE PROJECT LOCALLY
    let image: Image
}

struct Thumbnails {
    let small: Thumbnail
    let large: Thumbnail
    let full: Thumbnail
}

struct Thumbnail {
    let width: Int
    let height: Int
    let url: String
}

let fishAttachment = Attachment(
    id: "attjJfN3YHRBYqGVr",
    width: 2144,
    height: 1206,
    url: "https://v5.airtableusercontent.com/v3/u/35/35/1732766400000/g3FklMKr1YrwGPNKQTv09Q/6XpEr8ts8tlprzhrYVqxav7WmNHByEBFXj9LttXcGs-7u8_ONBQ9y4aUHyV-FUaIJnU42iPR-k_48wqvCAUqg0FxDIkkC6nuKudc2MP3bGRU2vw6Iq8uUO6UwEF0pN-OTsN5MWAzbFjFWkFxS4h0vxNFMSBb7LCHOuyfVhicZV8/83kjSrINy4pLFfAQM_QFjDH-OyGyY5qR1vefXSrKeD4",
    fileName: "IMG_9069.jpeg",
    size: 2271233,
    type: "image/jpeg",
    thumbnails: Thumbnails(
        small: Thumbnail(
            width: 64,
            height: 36,
            url: "https://v5.airtableusercontent.com/v3/u/35/35/1732766400000/DwmGd7M5LptzqPbq6q-52Q/07UZDPlkMkZBIADZSFOOGxwRHkQelN3aDHx-MstjgbeOlyRZFcTwF8Mlex4hhU3Wm3w3K4H9kunRbo4s53II2Alr-8tUv0YQ9Ek_EvCbR_dt3Svvjx7qgulwIS776xVkRcYLgQJVfNLtQwSARf57nw/zcv3u_-3Sgmf-y_Ig6cumYoX-1zilPOwbZACMm1jj0w"
        ),
        large: Thumbnail(
            width: 910,
            height: 512,
            url: "https://v5.airtableusercontent.com/v3/u/35/35/1732766400000/-EL3QIvBtvJwmu9fX9ueQA/y-adfjK-0Nl6IV0d1fn-6b8xf7WGJAQBEqnr9ziHFWowW63GQF-h7FlpeBGZWbOjG9EqfSX3Y4WVsxwW445GP_hwLgD82dU94xy1-pEJaGRu97QR2HoM8BFG9Od00ONdsfbwin5ElFEjR5cQDZ1ZQQ/LZgnIdbvejYl81hd9lbx9aRVOIeegVqSohnDvV_ethg"
        ),
        full: Thumbnail(
            width: 2144,
            height: 1206,
            url: "https://v5.airtableusercontent.com/v3/u/35/35/1732766400000/6dRWe7EqtJWLFvTZYQnfZA/x235vMu5Kdu_gyZtgXiG2RusxeJf0uzm6raTNW1fVOsFq-9KszCP5ECf8GkiAGlHT979D6BEVqlbY90RenTl-noq5e-15-Qp9KT_K27V-tfGPGv8NiMFOyK-vV9h9ZZ9zWU0zZ3HuW-hNuC9pK4vxA/CLrWQeIht2lWhGttLrx0cFMtbInjEgo1aMlXarjxzS8"
        )
    ),
    // BE SURE TO ADD THE IMAGES TO YOUR LOCAL PROJECT
//    image: Image(systemName: "square.and.arrow.up")
    image: Image(uiImage: .actions)
    
)
let octopusAttachment = Attachment(
    id: "attqlpLp8WCZvQ93O",
    width: 2142,
    height: 1206,
    url: "https://v5.airtableusercontent.com/v3/u/35/35/1732744800000/KpRfepHeXSLMM_O6nKRCKA/sANRwNYtZxb609mhOIfC45k3nLlEp__Son3RcDKYlR45VsM7ZCKEszQapeMGobeluR-c0jS9PdAwVXKwGOo0Y8l6vT3mTRSl7_x9icBhuynrCAnkCUvCO3FlsZfo969uPR4Kbgff1ndpWEsI3CpNEgj9so2rvPWcGjnD_4EoGLw/y2S8ZPCuxa59Lw8aw1ED97JzwgkPs--fgP5BbQ2yt_c",
    fileName: "IMG_9070.jpeg",
    size: 2414463,
    type: "image/jpeg",
    thumbnails: Thumbnails(
        small: Thumbnail(
            width: 64,
            height: 36,
            url: "https://v5.airtableusercontent.com/v3/u/35/35/1732744800000/myXBZ8uNXJ2Lem2N74JchA/jPJP9BKW1mg79ZRRhojzV_Cmlt-0tLzlFqIhHNvAhKSanHa0kLtHY6TE25UTTHXJx9qP1OMbEuQdZHsoRdLd9n6O-zGpItfG1-4oGF4-gyolkGZvuSmb1Jhn_-h6XHbnY0uhBhYgcqKoauLEc2Rz4g/y-3u8wfe-lzik3HUJLivJlMwZOd3py8dn5_o5BnYtOE"
        ),
        large: Thumbnail(
            width: 909,
            height: 512,
            url: "https://v5.airtableusercontent.com/v3/u/35/35/1732744800000/BAvLzuXDOT542--_xyuJkA/nLlTNKi-xnaENw14Vs0t0ypxLrQtvelK6PqYx0Wz0hMo9mI8YD6VJ2UTtIY3wAcRuVreLHS0TPHnttNeYRtVkIIqu8TYTm3JcksMJOCWVPOWh3tIDqc79rLD1yttwrLuUFV1Y1YTq91fb6WmqkY1Vg/OP97NWYEkCklufldEIAe99AXbgnSSa77yWtydABiQw8"
        ),
        full: Thumbnail(
            width: 2142,
            height: 1206,
            url: "https://v5.airtableusercontent.com/v3/u/35/35/1732744800000/Blh8SeDymXmfTqT-P8JRVQ/F2Mc_2npa623KvgdjUkcRqFTMt-w9yVApfVLv9Q579kso1Ndkhm8YBbF9PBGrxEVqjFOkGMCrLq58ryY96cjeFnq6nxN2SnoRQrZUXloR2sUC2akuj5iShxiQZbUM-CgRrGw0W7ZoL3RvRGLxdr4nw/lTcVCKJIKFQs8Ay2YPF9a1BytQ1ZTlboM9wd4M9hXXU"
        )
    ),
    image: Image(uiImage: .add)
)
let jellyAttachment = Attachment(
    id: "attj09i7JvaSYyzTL",
    width: 2126,
    height: 1204,
    url: "https://v5.airtableusercontent.com/v3/u/35/35/1732744800000/SFr4JwOm4owy8j5RT0Qrbg/Ar22Pq6l56Pz4kiiqxniB2kjR2YPIIooBNUhv6qqK1CFrLoFVy_qytsi2LvKz2onECCbR-jmm6xJ_e1mIifza9rU1a0dO95Ai6gpD7A8v1JR5wCPjar0qZznZHaYhHj_VOioqAVJ3WqqX1vGK2krnDUXjWiHmi3HumXw4yFnhAw/1ajFLN6uM6YlgPyqVyaIcyi5lXsr9E1ht9AkT5GX1z4",
    fileName: "IMG_9072.jpeg",
    size: 518453,
    type: "image/jpeg",
    thumbnails: Thumbnails(
        small: Thumbnail(
            width: 63,
            height: 36,
            url: "https://v5.airtableusercontent.com/v3/u/35/35/1732744800000/_OH4kAXKvLwFx9uyCdG24g/qu0rkpNw4JqFQe3wYcSHssh0rzt1FcSGLd31MbIQ-GWlPqs7pd6AxH2BVspiFKQmego7FGrdq8BvZtKqgyegwrz65i2FQqI9o86akVj7fVoFTZwBFcRhV_zL7SO-EQ2kQSY8ZP_Gnf1iiRoYtXQaxQ/BxCTjQisGK8ZXNER8kxPabso8uT6KWK54dPIAwyEXFY"
        ),
        large: Thumbnail(
            width: 904,
            height: 512,
            url: "https://v5.airtableusercontent.com/v3/u/35/35/1732744800000/xzBkcRjEJg8aOcWa08H49A/_TZ0fMT343TXKWLowdye-YAJXlOdLJweUjHu8OuTBsRh1HR2ul_EZdUXL5FsYFMP55cPdDIL7940oi9AqsKC7FNXHymtoeYgAKWUZJY3u6Ei8N5y5Vvu9bBuEcWQU_j1Y7ZyOeqJ6XHENx9tRwxLpA/fslKo1_aoa809YxmUOZjmeu4VHQuLw2Dvuu_r72osDw"
        ),
        full: Thumbnail(
            width: 2126,
            height: 1204,
            url: "https://v5.airtableusercontent.com/v3/u/35/35/1732744800000/H-6mrIonhCN-nkK-8l9FSw/RtGsSmZhllsGxzIyeQJokerRtPAKv3nUUd0Fmqr4hvJkDawM_DsRvasW2Dl9rNqf5CCm1gxL9A4S6kK51zTKBzgpzrKphyhcCRYf6eeTwTeOJ3lCtxzD__0No7F5fkfECG1YrVi6dz032h4CftINaQ/repFdtaW4YanbtRfp1nP6Fl9H_Vat-fDU8RUKDFYTwY"
        )
    ),
    image: Image(uiImage: .checkmark)
)
