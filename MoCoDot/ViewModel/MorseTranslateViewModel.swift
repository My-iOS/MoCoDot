//
//  MainViewModel.swift
//  MoCoDot
//
//  Created by 준우의 MacBook 16 on 2/8/24.
//

import Combine
import Foundation

final class MorseTranslateViewModel {
    let englishTranslateService: EnglishToMorseTranslateProtocol
    let koreanTranslateService: KoreanToMorseTranslateProtocol
    let soundService: SoundServiceProtocol
    let flashService: FlashServiceProtocol

    var isTappedPublisher = CurrentValueSubject<Bool, Never>(false)
    var placeholderPublisher = CurrentValueSubject<String, Never>("English")
    var morsePlaceholderPublisher = CurrentValueSubject<String, Never>("모스코드")

    var subscriptions = Set<AnyCancellable>()

    private var isToggle: Bool = false
    private var morsePlaceholder = "모스코드"
    var placeholder = "English"

    init(englishTranslateService: EnglishToMorseTranslateProtocol, koreanTranslateService: KoreanToMorseTranslateProtocol, soundService: SoundServiceProtocol, flashService: FlashServiceProtocol) {
        self.englishTranslateService = englishTranslateService
        self.koreanTranslateService = koreanTranslateService
        self.soundService = soundService
        self.flashService = flashService
    }
}

// MARK: - EnglishToMorseTranslateProtocol Method

extension MorseTranslateViewModel {
    func requestInputTextArr(at inputText: String) -> String {
        return englishTranslateService.requestInputTextArr(at: inputText)
    }

    func englishReset() {
        englishTranslateService.reset()
    }
}

// MARK: - KoreanToMorseTranslateProtocol Method

extension MorseTranslateViewModel {
    func translateKoreanToMorse(at inputTexts: String) -> String {
        return koreanTranslateService.translateMorse(at: inputTexts)
    }

    func koreanReset() {
        koreanTranslateService.reset()
    }
}

// MARK: - SoundServiceProtocol Method

extension MorseTranslateViewModel {
    func generatingMorseCodeSounds(at message: String) {
        soundService.generatingMorseCodeSounds(at: message)
    }
}

// MARK: - FlashServiceProtocol Method

extension MorseTranslateViewModel {
    func generatingMorseCodeFlashlight(at inputTexts: String) {
        flashService.generatingMorseCodeFlashlight(at: inputTexts)
    }
}

// MARK: - ViewModel's Original Method

extension MorseTranslateViewModel {
    func changeIsToggle() {
        isToggle.toggle()
        isTappedPublisher.send(isToggle)
    }

    func changePlaceholder(at str: String) {
        placeholder = str
        placeholderPublisher.send(str)
    }
}
