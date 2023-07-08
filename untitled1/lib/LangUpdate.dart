import 'dart:ui';

import 'package:get/get.dart';

class Lang extends Translations {
  static final putative = Locale("tr", "TR");
  static final languages = [
    Locale("tr", "TR"),
    Locale("en", "US")
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'name': 'Name - Surname',
      'phone' : 'Phone Number' ,
      'id' : 'T.C. Identification number',
      'address' : 'Address',
      'settings' : 'Settings',
      'security' : 'Security' ,
      'psw' : 'Password, security, personal details' ,
      'pay' : 'Payment Methods',
      'lang' : 'Language',
      'help' : 'Help',
      'about' : 'About',
      'exit' : 'Log out',
      'btprofile' : 'Back To Profile',
      'btsettings' : 'Back To Settings',
      'support' : 'To Get Support',
      'info' : 'You can contact via jetilac@gmail.com or help.jetilac.com.',
      'about the app' : 'About the App',
      'big About' : 'Jetilac is an innovative mobile application developed to make healthcare services more accessible. Jetilac allows patients to easily order medicines from their homes. This application is used to securely transmit prescriptions to pharmacists and deliver medicines to your homes via couriers, while increasing patient satisfaction. Jetilaçs user-friendly interface and security measures ensure the protection of patients personal information and health data. All transactions are protected by encryption protocols and performed in accordance with privacy policies. Jetilaç provides great convenience for many patients, such as the elderly, those with limited mobility or those who cannot spare time for pharmacies due to intense work schedule. It can also handle special requests such as emergencies or regular drug deliveries for a predetermined time frame. Jetilac provides a safe, fast and user-friendly service to patients by bridging modern technology and the needs of the healthcare industry. Thanks to Jetilac, it is now much easier and safer to order medicines and forward prescriptions to pharmacists.',

    },
    'tr_TR': {
      'name': 'Ad - Soyad',
      'phone' : 'Telefon Numarası' ,
      'id' : 'T.C. Kimlik Numarası',
      'address' : 'Adres',
      'settings' : 'Ayarlar',
      'security' : 'Güvenlik' ,
      'psw' : 'Şifre, güvenlik, kişisel detaylar' ,
      'pay' : 'Ödeme Yöntemleri',
      'lang' : 'Dil',
      'help' : 'Yardım',
      'about' : 'Hakkında',
      'exit' : 'Çıkış Yap',
      'btprofile' : 'Profile Dön',
      'btsettings' : 'Ayarlara Dön',
      'support' : 'Destek Almak İçin',
      'info' : 'jetilac@gmail.com veya help.jetilac.com üzerinden iletişime geçebilirsiniz.',
      'about the app' : 'Uygulama Hakkında',
      'big About' : 'Jetilaç, sağlık hizmetlerini daha erişilebilir hale getirmek amacıyla geliştirilmiş yenilikçi bir mobil uygulamadır. Jetilaç, hastaların kolaylıkla evlerinden ilaç siparişi verebilmesine olanak sağlar. Bu uygulama, hasta memnuniyetini artırırken, reçeteleri güvenli bir şekilde eczacılara iletmek ve kuryeler aracılığıyla ilaçları evlerinize teslim etmek için kullanılır. Jetilaç’ın kullanıcı dostu arayüzü ve güvenlik önlemleri, hastaların kişisel bilgilerinin ve sağlık verilerinin korunmasını sağlar. Tüm işlemler şifreleme protokolleriyle korunur ve gizlilik politikalarına uygun olarak gerçekleştirilir. Jetilaç, yaşlılar, hareket kısıtlılığı olanlar veya yoğun iş temposu nedeniyle eczanelere zaman ayıramayanlar gibi birçok hasta için büyük bir kolaylık sağlar. Aynı zamanda acil durumlar veya önceden belirlenmiş bir zaman dilimi için düzenli ilaç teslimatları gibi özel talepleri de karşılayabilir. Jetilaç, çağdaş teknoloji ve sağlık sektöründeki ihtiyaçlar arasında köprü kurarak hastalara güvenli, hızlı ve kullanıcı dostu bir hizmet sunar. Jetilaç sayesinde, ilaç siparişi vermek ve reçeteleri eczacılara iletmek artık çok daha kolay ve güvenlidir.',


    }
  };


}