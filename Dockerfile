# استخدام بيئة دوت نت الرسمية للبناء والتشغيل
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# جلب ملفات السورس كود لـ SilverBullet من المستودع الرسمي وتثبيته
RUN git clone https://github.com/ArisDev/SilverBullet.git .
RUN dotnet publish -c Release -o out

# بناء الحاوية النهائية الخفيفة للتشغيل
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# فتح المنفذ الافتراضي الذي تتوقعه منصة Render
EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000

ENTRYPOINT ["dotnet", "SilverBullet.Web.dll"]
