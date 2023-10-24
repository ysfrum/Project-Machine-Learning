# Kartu Prakerja - Marchel Yusuf Rumlawang Arpipi

# Memanggil library yang dibutuhkan
library(ggplot2)
library(dplyr)

# Memuat dataset
dataset = read.csv('mobil_mesin_harga.csv')
summary(dataset)

# Pembagian dataset menjadi train set (80%) dan test set (20%)
# Dan melihat 10 train test data teratas dari dataset dengan fungsi head()
set.seed(04092023)
train_index = sample(0:nrow(dataset), 0.8 * nrow(dataset))
train_data = dataset[train_index, ]
test_data = dataset[-train_index, ]

head(train_data, n = 10L)
head(test_data, n = 10L)

# Membuat model "Regresi Linear Sederhana"
model = lm(Harga ~ KekuatanMesin, data = dataset)
summary(model)

# Melakukan Prediksi dengan test set lalu melihat resultnya
pred = predict(model, newdata = test_data)
result = cbind(test_data, pred)

head(result, n = 5L)


# Melakukan evalusi pada model yang telah dibangun
# Menghitung MAE, MSE, dan RMSE
MAE = mean(abs(pred - test_data$Harga))
MSE = mean((pred - test_data$Harga)^2)
RMSE = sqrt(MSE)

# Mencetak hasil evaluasi
cat("Hasil evaluasi:\n")
cat("Mean Absolute Error (MAE) = ", round(MAE * 100, 2), "%\n")
cat("Mean Squared Error (MSE) = ", round(MSE * 100, 2), "%\n")
cat("Root Mean Squared Error (RMSE) = ", round(RMSE * 100, 2), "%\n")

# Melihat Plot Data dan Garis Regresi dari model
ggplot(dataset, aes(x = KekuatanMesin, y = Harga)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(x = "Kekuatan Mesin", y = "Harga") +
  theme_minimal()