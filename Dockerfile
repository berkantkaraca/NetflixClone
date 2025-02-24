# 1. Resmi Node.js image'ını kullan
FROM node:18-alpine AS builder

# 2. Çalışma dizinini ayarla
WORKDIR /app

# 3. Bağımlılıkları yükle
COPY package.json package-lock.json ./
RUN npm install

# 4. Uygulamayı build et
COPY . .
RUN npm run build

# 5. Yeni bir image oluştur ve sadece gerekli dosyaları kopyala
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app ./

# 6. Portu tanımla
EXPOSE 3000

# 7. Next.js uygulamasını başlat
CMD ["npm", "run", "start"]
