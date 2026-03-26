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

# التعديل هنا: بنحدد المسار النسبي من المجلد الرئيسي
COPY frontend/package*.json ./
RUN npm install

COPY frontend/ .
RUN npm run build

# المرحلة 2: تشغيل Nginx
FROM nginx:stable-alpine
# تأكدي إن ملف nginx.conf موجود جوه فولدر frontend
COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]