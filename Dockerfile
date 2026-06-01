FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# نسخ الملفات المرفوعة مباشرة من مستودعك دون الحاجة لروابط خارجية
COPY . .

WORKDIR /app/SilverBullet.Web
RUN dotnet publish -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000

ENTRYPOINT ["dotnet", "SilverBullet.Web.dll"]
