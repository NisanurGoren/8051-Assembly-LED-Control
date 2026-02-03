ORG 0000H

MAIN:
    ; P2.7 Buton Kontrolü (Buton Basiliysa P2.7 = 0)
    JNB P2.7, CLEAR         ; Butona basilmissa (P2.7=0), CLEAR etiketine git

    MOV A, P1               ; P1'den girisi oku (Giris degeri Aktif Yüksek olarak okunacak)
    
    ; 1. Sart: P1 = 30d
    CJNE A, #30, CHECK128
    ; Yanacak LED'ler: LED7, LED5, LED4, LED3, LED0
    ; Aktif YÜKSEK çikis degeri: 10111001b (0xB9)
    MOV P0, #0B9H           ; LED'leri yak (Aktif Yüksek)
    SJMP MAIN

CHECK128:
    ; 2. Sart: P1 = 128d
    CJNE A, #128, CHECK255
    ; Yanacak LED'ler: LED7, LED5, LED3, LED1
    ; Aktif YÜKSEK çikis degeri: 10101010b (0xAA)
    MOV P0, #0AAH           ; LED'leri yak (Aktif Yüksek)
    SJMP MAIN

CHECK255:
    ; 3. Sart: P1 = 255d
    CJNE A, #255, ALL_OFF
    ; Yanacak LED'ler: LED7, LED6, LED5, LED4
    ; Aktif YÜKSEK çikis degeri: 11110000b (0xF0)
    MOV P0, #0F0H           ; LED'leri yak (Aktif Yüksek)
    SJMP MAIN

ALL_OFF:
    ; Hiçbir sart saglanmazsa: Tüm LED'ler Sönük
    MOV P0, #00H            ; Tüm P0 pinlerine '0' gönder -> LED'ler Sönük
    SJMP MAIN
    
CLEAR:
    ; Butona Basildiginda: Hepsi sifir (Tüm LED'ler SÖNÜK)
    MOV P0, #00H            ; Tüm LED'leri SÖNDÜR (Aktif Yüksek mantigiyla)
    
WAIT_FOR_RELEASE:
    JNB P2.7, WAIT_FOR_RELEASE ; Buton birakilana kadar bekle
    SJMP MAIN

END