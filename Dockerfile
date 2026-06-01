# استخدام بيئة تشغيل دوت نت الصافية والخفيفة مباشرة لتقليل استهلاك الرام
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app

# تثبيت أداة wget والـ unzip لجلب وفك حزمة سيلفر بولت الرسمية الجاهزة بالكامل
RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

# تحميل النسخة المجمعة الجاهزة من المطور مباشرة (تحتوي على مجلد wwwroot وكل شيء)
RUN wget https://github.com/mohamm4dx/SilverBullet/releases/download/v0.3.2/SilverBullet.Web.zip -O silverbullet.zip \
    && unzip silverbullet.zip -d . \
    && rm silverbullet.zip

# فتح المنفذ الذي تتوقعه منصة Render
EXPOSE 5000
ENV ASPNETCORE_URLS=http://+:5000

# أمر الإقلاع المباشر للملف التنفيذي الأساسي
ENTRYPOINT ["dotnet", "SilverBullet.Web.dll"]
