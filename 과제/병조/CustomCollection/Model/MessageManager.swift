//
//  MessageManager.swift
//  CustomCollection
//
//  Created on 3/2/25.
//

@MainActor
final class MessageManager {
    private let messageProvider: MessageProdiver
    
    private var onMessagesUpdated: (([Message]) -> ())?
    private var requestTask: Task<Void, Never>?
    
    init() {
        messageProvider = MessageProdiver()
    }
    
    var messagesStream: AsyncStream<[Message]> {
        AsyncStream { continuation in
            continuation.onTermination = { [weak self] _ in
                Task {
                    await self?.requestTask?.cancel()
                }
            }
            onMessagesUpdated = { messages in
                continuation.yield(messages)
            }
        }
    }
    
    func requestMessages() {
        guard requestTask == nil else { return }
        
        requestTask = Task {
            guard let onMessagesUpdated else { return }
            
            let newMessages = await messageProvider.fetch(amount: 20)
            onMessagesUpdated(newMessages)
            requestTask = nil
        }
    }
}
