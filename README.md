

Bu proje, MATLAB kullanılarak Türkiye’deki şehirlerin öğrenci grubu dağılımlarını analiz etmek amacıyla K-Means kümeleme algoritması uygulanarak geliştirilmiştir.
Şehirler, öğrenci sayılarındaki benzerliklerine göre kümelendirilmiş ve sonuçlar hem 3B grafik hem de Türkiye haritası üzerinde görselleştirilmiştir.

# 🧠 Proje Amacı
Bu çalışmanın temel amacı:
Şehirleri öğrenci dağılımlarına göre gruplamak
K-Means algoritmasının uygulanışını göstermek
Elbow (Dirsek) yöntemi ile en uygun küme sayısını (k) belirlemek
Sonuçları görsel ve yorumlanabilir hale getirmektir

# Veri Seti (kMeans.csv)
CSV dosyası aşağıdaki sütunları içermelidir:

<img width="709" height="379" alt="image" src="https://github.com/user-attachments/assets/a936950d-98c2-4648-8076-f461b127045e" />## Türkiye Şehirleri İçin K-Means Kümeleme Analizi (MATLAB)

# Kullanılan Yöntemler
🔹 Normalizasyon
Veriler, farklı ölçeklerin kümelemeyi etkilememesi için 0–1 aralığına normalize edilmiştir:
  normalizedData = normalize(studentCounts, "range");
  
🔹 Elbow (Dirsek) Yöntemi
k = 1 ile k = 10 arasındaki değerler için WCSS (küme içi hata) hesaplanmış ve en uygun küme sayısı grafik üzerinden belirlenmiştir.
📈 Dirsek noktasının olduğu k değeri optimum küme sayısı olarak seçilir.

🔹 K-Means Kümeleme
K-Means algoritması aşağıdaki ayarlarla uygulanmıştır:
K-Means++ başlangıcı
20 tekrar (Replicates) ile kararlı sonuç
En iyi kümeleme sonucu seçilmiştir
  kmeans(normalizedData, k, 'Replicates', 20, 'Start', 'plus');

# 📊 Görselleştirmeler

🧊 3 Boyutlu Küme Grafiği
Grup1, Grup2 ve Grup3 eksenleri kullanılmıştır
Her şehir ait olduğu kümeye göre renklendirilmiştir

🗺️ Türkiye Haritası Üzerinde Kümeleme
Şehirler, coğrafi koordinatlarıyla harita üzerinde gösterilmiştir
Renkler şehirlerin ait olduğu kümeleri temsil eder 


# 🚀 Çalıştırma Adımları

kMeans.csv dosyasını MATLAB kodu ile aynı klasöre koyun
MATLAB’i açın
Script’i çalıştırın
Elbow grafiğine bakarak k değerini girin

