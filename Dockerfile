# استخدام بيئة تشغيل دوت نت الرسمية والمباشرة
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# سحب كود OpenBullet 2 المستقر والمفتوح للجميع علنياً
RUN git clone https://github.com/openbullet/openbullet2.git .

# الانتقال للمجلد الأساسي وبناء نسخة الويب
WORKDIR /app/OpenBullet2.Web
RUN dotnet publish -c Release -o /app/out

# بناء الحاوية النهائية الخفيفة للتشغيل
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# فتح المنفذ الافتراضي الذي تتوقعه منصة Render للـ Web UIs
EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000

ENTRYPOINT ["dotnet", "OpenBullet2.Web.dll"]
