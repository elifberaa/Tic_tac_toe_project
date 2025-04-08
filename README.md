# XOX (Tic Tac Toe) Oyunu - Flutter Okul Projesi

Bu proje, Flutter kullanılarak geliştirilmiş bir XOX (Tic Tac Toe) oyunudur. Okul projesi gereksinimlerini karşılamak üzere tasarlanmıştır. Uygulama, bir giriş ekranı, iki oyunculu oyun mantığı, sonuç ekranı ve API'dan logo çeken bir drawer menü içerir.

## Proje Amacı

Bu projenin temel amacı, Flutter kullanarak temel bir mobil uygulama geliştirmektir. Proje, state management, widget kullanımı, sayfa yönlendirme (routing), API entegrasyonu (logo için) ve kullanıcı arayüzü tasarımı gibi Flutter konseptlerini uygulamayı hedefler. Aynı zamanda temiz kod, modüler yapı ve kullanıcı deneyimi prensiplerine uygun bir uygulama oluşturmaktır.

## Özellikler

-   **Giriş Ekranı:** Kullanıcı adı ve şifre ile basit giriş. (Gerçek kimlik doğrulama eklenmemiştir).
-   **Oyun Ekranı:**
    -   İki oyunculu (X ve O) oyun akışı.
    -   3x3 oyun tahtası.
    -   Sırayla hamle yapma.
    -   Kazanan (yatay, dikey, çapraz 3'lü) veya berabere bitiş kontrolü.
-   **Sonuç Ekranı:** Oyun sonucunu (Kazanan X/O veya Berabere) net bir şekilde gösterir. "Tekrar Oyna" butonu ile yeni oyuna başlama imkanı sunar.
-   **Drawer Menü:**
    -   Üst kısımda API üzerinden çekilen dinamik logo.
    -   Menü öğeleri: "Yeni Oyun" (mevcut oyunu sıfırlar), "Skorlar" (gelecekte eklenebilir), Proje sahibinin GitHub linki.
-   **Sayfa Yönlendirme:** `main.dart` içinde tanımlanmış rotalar (`/`, `/game`, `/results`).
-   **Kod Kalitesi:** Anlaşılır değişken isimleri, widget'lara ayrılmış yapı.
-   **UI/UX:** Basit, kullanıcı dostu ve sezgisel arayüz.

## Sayfaların Görevleri ve İçerikleri

-   **`Tic-Tac-Toe/lib/ui/login_screen.dart` (Giriş Sayfası - `/`)**:
    -   **Görev:** Uygulamanın başlangıç ekranı. Kullanıcıdan giriş bilgilerini alır.
    -   **İçerik:** E-posta ve şifre için `TextField`, "Giriş" butonu. Başarılı girişte Oyun Ekranı'na yönlendirir.
-   **`Tic-Tac-Toe/lib/ui/game_screen.dart` (Oyun Ekranı - `/game`)**:
    -   **Görev:** XOX oyununun oynandığı ana ekran.
    -   **İçerik:** 3x3 oyun tahtası (`GridView`), oyuncuların hamle yapabileceği tıklanabilir kareler, sıra bilgisini gösteren metin, "Yeniden Oyna" butonu, Drawer menü butonu. Oyun bitince Sonuç Ekranı'na yönlendirir.
-   **`Tic-Tac-Toe/lib/ui/results_screen.dart` (Sonuç Ekranı - `/results`)**:
    -   **Görev:** Tamamlanan oyunun sonucunu göstermek.
    -   **İçerik:** Kazanan oyuncuyu veya beraberlik durumunu belirten büyük bir metin, "Tekrar Oyna" butonu (Oyun Ekranı'na geri döner).

## Drawer Menü Logo API Bilgileri

Drawer menüsünün üst kısmında gösterilen logo, [DiceBear Avatars API](https://www.dicebear.com/) kullanılarak dinamik olarak çekilmektedir.
Kullanılan API endpoint'i: `https://api.dicebear.com/7.x/bottts/png?seed=xoxo&size=128`
-   `bottts`: Kullanılan avatar stili.
-   `seed=xoxo`: Logoyu belirleyen rastgele metin (her zaman aynı logoyu üretir). Farklı `seed` değerleri farklı logolar üretir.
-   `size=128`: Logonun piksel cinsinden boyutu.

## Login Bilgileri Saklama

Mevcut durumda, girilen login bilgileri (e-posta ve şifre) **saklanmamaktadır**. Giriş işlemi sadece alanların boş olup olmadığını kontrol eder ve doğrudan oyun ekranına yönlendirir.

Gerçek bir uygulamada login bilgilerini güvenli bir şekilde saklamak için aşağıdaki yöntemler kullanılabilir:
-   **`shared_preferences`:** Basit anahtar-değer çiftlerini cihazda saklamak için (örneğin "beni hatırla" özelliği için token saklama).
-   **`flutter_secure_storage`:** Daha hassas verileri (şifreler, API anahtarları) iOS Keychain ve Android Keystore kullanarak güvenli bir şekilde saklamak için.
-   **Backend Entegrasyonu:** Kullanıcı bilgilerini bir veritabanında saklayan ve kimlik doğrulamayı yöneten bir backend servisi (Firebase Authentication, kendi API'nız vb.) kullanmak.

Bu proje basitlik amacıyla bu yöntemleri içermemektedir.

## Grup Üyelerinin Projeye Katkısı

*Bu bölümü kendi grup bilgilerinize göre doldurunuz.*

-   **[Üye Adı Soyadı]:** [Katkıları - Örn: Login ekranı tasarımı, Oyun mantığı geliştirme]
-   **[Üye Adı Soyadı]:** [Katkıları - Örn: Sonuç ekranı, Drawer menü entegrasyonu, README]
-   ...

*(Eğer proje bireysel ise bu bölümü kaldırabilir veya kendinizi yazabilirsiniz.)*

## Özgünlük ve Karmaşıklık

Bu proje, standart bir Tic-Tac-Toe oyununun Flutter ile temel özelliklerini içermektedir. Özgünlük ve karmaşıklık katabilecek potansiyel geliştirmeler şunlar olabilir:

-   **Skor Takibi:** Oyun skorlarını (kazanma/kaybetme/beraberlik) cihazda saklama (`shared_preferences` veya `sqflite`).
-   **Tek Oyuncu Modu:** Basit bir yapay zeka rakip eklemek.
-   **Zorluk Seviyeleri:** Yapay zeka için farklı zorluk seviyeleri.
-   **Online Multiplayer:** Firebase Realtime Database veya Firestore kullanarak iki oyuncunun farklı cihazlardan oynamasını sağlama.
-   **Gelişmiş Animasyonlar:** Oyun geçişleri, kazanan çizgi animasyonu gibi görsel iyileştirmeler.
-   **Tema Seçenekleri:** Kullanıcının farklı renk temaları seçebilmesi.

## Diğer Anlatmak İstedikleriniz

*Bu bölüme proje hakkında eklemek istediğiniz diğer notları, karşılaştığınız zorlukları veya öğrendiklerinizi ekleyebilirsiniz.*

## Kullanılan Paketler

-   `flutter/material.dart`: Temel Flutter UI bileşenleri.
-   `url_launcher`: Drawer menüsündeki dış bağlantıları açmak için.
-   `http` (dolaylı): `Image.network` tarafından logo çekmek için kullanılır (pubspec.yaml'da belirtilmese de Flutter SDK ile gelir).

## Nasıl Çalıştırılır?

1.  Flutter SDK'nın bilgisayarınızda kurulu olduğundan emin olun ([flutter.dev](https://flutter.dev)).
2.  Projeyi bilgisayarınıza klonlayın veya indirin.
3.  Proje ana dizinindeyken (`Tic-Tac-Toe` klasörü) terminal veya komut istemcisini açın.
4.  Bağımlılıkları yüklemek için şu komutu çalıştırın:
    ```bash
    flutter pub get
    ```
5.  Uygulamayı bir emülatörde veya fiziksel cihazda çalıştırmak için şu komutu kullanın:
    ```bash
    flutter run
    ```
