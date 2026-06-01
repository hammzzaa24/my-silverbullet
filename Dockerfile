# الخطوة الأولى: بيئة بناء كاملة تحتوي على حزم دوت نت ونظام بناء الواجهات
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# جلب ملفات السورس كود من مستودع نشط ومفتوح
RUN git clone https://github.com/mohamm4dx/SilverBullet.git .

# الانتقال إلى مجلد واجهة الويب وبناء تطبيق دوت نت مع تجميع ملفات الـ Client-Side
WORKDIR /app/SilverBullet.Web
RUN dotnet publish -c Release -o /app/out

# الخطوة الثانية: بيئة التشغيل الخفيفة والنهائية
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# فتح المنفذ الخاص بمنصة Render
EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000

ENTRYPOINT ["dotnet", "SilverBullet.Web.dll"]
