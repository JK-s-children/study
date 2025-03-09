//
//  MessageProdiver.swift
//  CustomCollection
//
//  Created on 3/3/25.
//

actor MessageProdiver {
    private let max = 255
    private var value = 0
    private var stride = 15
    
    func fetch(amount: Int) async -> [Message] {
        try? await Task.sleep(for: .milliseconds(500))
        return (0..<amount).map { _ in message() }
    }
    
    private func message() -> Message {
        defer { adjustValue() }
        let content = LoremIpsum.randomString
        let backgroundColor = Color(red: UInt8(value), green: UInt8(max), blue: UInt8(value))
        return Message(content: content, backgroundColor: backgroundColor)
    }
    
    func adjustValue() {
        value += stride
        switch value {
        case max, .zero:
            stride *= -1
        default:
            break
        }
    }
}

enum LoremIpsum {
    static let list = [
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        "Sed et urna tristique, interdum elit a, dignissim neque.",
        "Quisque ullamcorper magna eget libero molestie suscipit.",
    ]
    
    static var randomString: String {
        list[..<Int.random(in: 1..<list.endIndex)].joined(separator: " ")
    }
}
