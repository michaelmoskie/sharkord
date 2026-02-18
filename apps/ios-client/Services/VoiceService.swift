import Foundation
import AVFoundation

class VoiceService: ObservableObject {
    @Published var isConnected = false
    @Published var isMuted = false
    @Published var isDeafened = false
    @Published var participants: [VoiceParticipant] = []
    
    private var audioEngine: AVAudioEngine?
    private var inputNode: AVAudioInputNode?
    
    func connect(to channelId: String) {
        // Initialize WebRTC connection via Mediasoup
        setupAudioEngine()
        isConnected = true
    }
    
    func disconnect() {
        stopAudioEngine()
        isConnected = false
        participants.removeAll()
    }
    
    func toggleMute() {
        isMuted.toggle()
        // Mute/unmute audio track
    }
    
    func toggleDeafen() {
        isDeafened.toggle()
        // Deafen audio
    }
    
    private func setupAudioEngine() {
        audioEngine = AVAudioEngine()
        inputNode = audioEngine?.inputNode
        
        // Configure audio session
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .voiceChat, options: [.defaultToSpeaker, .allowBluetooth])
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
        
        // Start audio engine
        do {
            try audioEngine?.start()
        } catch {
            print("Failed to start audio engine: \(error)")
        }
    }
    
    private func stopAudioEngine() {
        audioEngine?.stop()
        audioEngine = nil
    }
}

struct VoiceParticipant: Identifiable {
    let id: String
    let userId: String
    var isMuted: Bool
    var isDeafened: Bool
    var isSpeaking: Bool
}
