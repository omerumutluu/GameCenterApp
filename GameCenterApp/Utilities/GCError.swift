//
//  GCError.swift
//  GameCenterApp
//
//  Created by Ömer Umutlu on 25.02.2024.
//

import Foundation

enum GCError: String, Error {
    
    case getError = "Veri alınırken bilinmeyen bir hata ile karşılaşıldı. Lütfen tekrar deneyiniz."
    case addError = "Veri eklenirken bilinmeyen bir hata ile karşılaşıldı. Lütfen tekrar deneyiniz."
    case updateError = "Veri güncellenirken bilinmeyen bir hata ile karşılaşıldı. Lütfen tekrar deneyiniz."
    case deleteError = "Veri silinirken bilinmeyen bir hata ile karşılaşıldı. Lütfen tekrar deneyiniz."
    case jsonError = "Veri işleme hatası. Lütfen tekrar deneyiniz."
    case relatedObjectGetError = "Veri alınırken bir hata ile karşılaşıldı. Lütfen tekrar deneyiniz."
    case invalidUsernameOrPassword = "Kullanıcı adı ve parolayı tekrar kontrol ediniz."
    case signUpError = "Kayıt olma işlemi sırasında bir hata ile karşılaşıldı."
    case uploadImageError = "İlan Resmi sunucuya yüklenirken bir hata ile karşılaşıldı. Lütfen daha sonra tekrar deneyiniz."
    case sendMessageError = "Mesaj gönderilirken bir hata oluştu. Lütfen tekrar deneyiniz."
}

enum GCValidationError: String, Error {
    
    case advertisementTitleLengthError = "İlan başlığı en az 3 karakterden oluşmalıdır."
    case advertisementTitleJustNumericError = "İlan başlığı sadece rakamlardan oluşamaz."
    case gameNilError = "Lütfen oyun kategorisini seçiniz."
    case descriptionTitleLengthError = "İlan açıklaması en az 10 karakterden oluşmalıdır."
    case descriptionTitleJustNumericError = "İlan açıklaması sadece rakamlardan oluşamaz."
    case imageURLNilError = "Resim alanı boş geçilemez."
    case maximumDeliveryTimeNilError = "Maksimum teslimat süresini seçiniz."
    case priceNilError = "Fiyat alanı boş geçilemez."
    case priceValidError = "Fiyat alanı geçerli bir ondalıklı sayı olmak zorundadır."
}
