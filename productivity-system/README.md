# 🎯 نظام الإنجاز الذكي — دليل النشر الكامل

## الملفات
```
productivity-system/
├── index.html          ← الداشبورد الكامل
├── supabase_schema.sql ← قاعدة البيانات
├── vercel.json         ← إعدادات النشر
└── README.md           ← هذا الملف
```

---

## الخطوة ١ — إنشاء قاعدة البيانات (Supabase)

1. اذهب إلى https://supabase.com وسجّل دخولاً
2. اضغط **New Project** واختر اسماً ومنطقة (مثلاً eu-central-1)
3. انتظر إنشاء المشروع (دقيقة تقريباً)
4. اذهب إلى **SQL Editor** (القائمة الجانبية)
5. انسخ محتوى ملف `supabase_schema.sql` بالكامل والصقه
6. اضغط **Run** — ستظهر رسالة "Success"
7. اذهب إلى **Settings → API** واحفظ:
   - **Project URL** (مثلاً: `https://abcdefgh.supabase.co`)
   - **anon public key** (مفتاح طويل يبدأ بـ eyJ...)

---

## الخطوة ٢ — نشر على Vercel

### الطريقة السريعة (بدون GitHub):
1. اذهب إلى https://vercel.com وسجّل دخولاً
2. اضغط **Add New → Project**
3. اختر **Upload** وارفع مجلد `productivity-system` كاملاً
4. اضغط **Deploy** — سينتهي في ثوانٍ
5. ستحصل على رابط مثل: `https://productivity-system-xyz.vercel.app`

### الطريقة المفضّلة (GitHub):
1. أنشئ repository جديد على https://github.com
2. ارفع الملفات الثلاثة (index.html, supabase_schema.sql, vercel.json)
3. في Vercel: **Import Git Repository** واختر الـ repo
4. عند أي تعديل على GitHub، Vercel يُحدّث النشر تلقائياً

---

## الخطوة ٣ — تشغيل النظام

1. افتح الرابط الذي أعطاك إياه Vercel
2. ستظهر شاشة الإعداد — أدخل:
   - **Project URL** من Supabase
   - **Anon Key** من Supabase
   - **Claude API Key** من console.anthropic.com (اختياري)
3. اضغط **اتصال وبدء النظام**
4. احفظ الرابط في المتصفح — هذا رابطك الدائم

---

## الخطوة ٤ — الوصول من أي جهاز

- **موبايل**: افتح الرابط وأضفه إلى الشاشة الرئيسية (Add to Home Screen)
- **جهاز ثانٍ**: افتح نفس الرابط وأدخل نفس بيانات Supabase
- **البيانات مزامنة لحظياً** بين جميع الأجهزة

---

## ربط n8n (للأتمتة — اختياري)

### متى تحتاجه؟
- إرسال تقرير أسبوعي بالبريد
- تنبيه واتساب/تيليجرام عند التكاسل
- مزامنة مع Google Calendar
- تذكير يومي صباحي

### كيف تربطه؟
1. في n8n أضف Node من نوع **Supabase**
2. أدخل نفس URL و Service Role Key (من Supabase → Settings → API → service_role)
3. يمكنك قراءة المهام وإرسال تنبيهات بناءً عليها

### مثال Webhook جاهز:
```
POST https://your-n8n.com/webhook/tasks-review
Body: { "check_streak": true, "send_report": true }
```

---

## الدعم الفني
إذا واجهت أي مشكلة، شارك رسالة الخطأ وسنحلها.
