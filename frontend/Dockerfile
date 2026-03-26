# # المرحلة 1: بناء تطبيق React/Vite
# FROM node:18-alpine AS build
# WORKDIR /app
# COPY package*.json ./
# RUN npm install
# COPY . .
# RUN npm run build

# # المرحلة 2: تشغيل Nginx
# FROM nginx:stable-alpine
# # نسخ إعدادات Nginx التي وجهت فيها الـ proxy إلى backend:3000
# COPY nginx.conf /etc/nginx/conf.d/default.conf
# # نسخ ملفات البناء النهائية (dist)
# COPY --from=build /app/dist /usr/share/nginx/html
# EXPOSE 80
# CMD ["nginx", "-g", "daemon off;"]

# المرحلة 1: بناء تطبيق React/Vite
FROM node:18-alpine AS build
WORKDIR /app

# التعديل هنا: بنقوله الملفات موجودة جوه فولدر frontend
# COPY [المسار على الجهاز] [المسار جوه الحاوية]
COPY frontend/package*.json ./
RUN npm install

# بننسخ كل حاجة تخص الفرونت إند جوه الحاوية
COPY frontend/ .
RUN npm run build

# المرحلة 2: تشغيل Nginx
FROM nginx:stable-alpine
# بنحدد مسار ملف nginx.conf الصح برضه
COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]