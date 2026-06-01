# استخدام بيئة بناء دوت نت
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# جلب ملفات السورس كود من مستودع SilverBullet الرسمي النشط علناً
RUN git clone https://github.com/mohamm4dx/SilverBullet.git .

# بناء نسخة الويب الخاصة بالبرنامج
WORKDIR /app/SilverBullet.Web
RUN dotnet publish -c Release -o /app/out

# بناء الحاوية النهائية للتشغيل
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# فتح المنفذ الذي تتوقعه منصة Render
EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000

ENTRYPOINT ["dotnet", "SilverBullet.Web.dll"]
