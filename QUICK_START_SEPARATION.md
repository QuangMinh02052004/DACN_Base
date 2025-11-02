# 🎯 Quick Start Guide - Tách Python API riêng

Hướng dẫn nhanh để sử dụng Python API như một project độc lập.

---

## 📁 Project Structure

```
DACN_Base-3/
├── project_flowers/           ← Python API (Standalone project)
│   ├── enhanced_api.py       ← Main API server
│   ├── improved_recognition.py
│   ├── requirements.txt      ← Python dependencies
│   ├── oxford102_m2_optimized.h5
│   ├── class_names.json
│   ├── .env.example          ← Environment config template
│   ├── Dockerfile            ← Docker deployment
│   ├── Procfile              ← Heroku deployment
│   ├── README_STANDALONE.md  ← API documentation
│   └── DEPLOYMENT_GUIDE.md   ← Deploy instructions
│
├── Controllers/              ← C# Web Application
├── Services/
│   └── Implementations/
│       └── ImageSearchService.cs  ← Calls Python API
├── appsettings.json         ← API URL configuration
└── appsettings.Production.json
```

---

## 🚀 Cách sử dụng

### Option 1: Chạy local (Development)

**Terminal 1 - Python API:**
```bash
cd project_flowers
python enhanced_api.py
```
→ API chạy trên: `http://localhost:8001`

**Terminal 2 - C# Web:**
```bash
cd /Users/lequangminh/Documents/DACN_Base-3
dotnet run
```
→ Website chạy trên: `http://localhost:5187`

**Configuration** (`appsettings.json`):
```json
{
  "ImageSearch": {
    "UseProduction": false  // Dùng local API
  }
}
```

---

### Option 2: Deploy Python API riêng

#### Bước 1: Deploy Python API

Chọn một platform (xem chi tiết trong `DEPLOYMENT_GUIDE.md`):

**Khuyến nghị cho học sinh/SV:**
- **PythonAnywhere** (Free) → https://pythonanywhere.com
- **Railway** ($5/month) → https://railway.app  
- **Render** (Free tier) → https://render.com

**Sau khi deploy, bạn sẽ có URL:**
```
https://yourusername.pythonanywhere.com
hoặc
https://your-app.railway.app
```

#### Bước 2: Update C# Project

**Production config** (`appsettings.Production.json`):
```json
{
  "ImageSearch": {
    "ProductionApiUrl": "https://your-deployed-api-url.com",
    "UseProduction": true  // ← Bật để dùng production API
  }
}
```

Hoặc update trực tiếp trong `appsettings.json`:
```json
{
  "ImageSearch": {
    "PythonApiUrl": "http://localhost:8001",
    "ProductionApiUrl": "https://your-api.railway.app",
    "UseProduction": true  // false = local, true = production
  }
}
```

#### Bước 3: Run C# project
```bash
dotnet run --environment Production
# hoặc chỉ
dotnet run
```

---

## 🔧 Switch giữa Local và Production

### Development (dùng local API):
```json
"UseProduction": false
```
```bash
# Start local Python API
cd project_flowers && python enhanced_api.py

# Start C# web
dotnet run
```

### Production (dùng deployed API):
```json
"UseProduction": true
```
```bash
# Chỉ cần chạy C# web
dotnet run
# Python API đang chạy trên server remote
```

---

## ✅ Verify Setup

### Test Python API:
```bash
# Health check
curl http://localhost:8001/health

# hoặc production
curl https://your-api.railway.app/health

# Response:
{
  "status": "healthy",
  "model_loaded": true
}
```

### Test từ C# web:
1. Truy cập: http://localhost:5187/Product/ImageSearch
2. Upload ảnh hoa
3. Xem kết quả nhận diện

### Check logs:
```bash
# Python API logs
cd project_flowers
tail -f api.log

# C# logs
# Xem trong console khi chạy dotnet run
```

---

## 📊 Comparison: Local vs Production

| Tiêu chí | Local (UseProduction: false) | Production (UseProduction: true) |
|----------|------------------------------|----------------------------------|
| **Python API** | Chạy localhost:8001 | Deployed trên server remote |
| **Setup** | Cần 2 terminals | Chỉ cần 1 terminal (C#) |
| **Speed** | Nhanh hơn (no network latency) | Phụ thuộc mạng |
| **Development** | ✅ Dễ debug, modify code | ❌ Khó debug |
| **Demo/Production** | ❌ Cần máy local chạy | ✅ Chạy mọi nơi |
| **Cost** | Free | Free - $5/month |

---

## 🎯 Khuyến nghị

### Khi nào dùng Local:
- ✅ Development và testing
- ✅ Modify AI model hoặc enhancement rules
- ✅ Debug issues
- ✅ Không có internet ổn định

### Khi nào dùng Production:
- ✅ Demo cho giáo viên/khách hàng
- ✅ Deploy project thật
- ✅ Team collaboration
- ✅ Mobile app integration

---

## 🆘 Troubleshooting

### C# không connect được Python API:

**Local:**
```bash
# Check Python API đang chạy
curl http://localhost:8001/health

# Check port
lsof -i :8001
```

**Production:**
```bash
# Check API deployed
curl https://your-api-url.com/health

# Check C# config
cat appsettings.json | grep ProductionApiUrl
```

### API response chậm:
- Local: Check model file đã load chưa
- Production: Free tier platforms có thể sleep (first request chậm)

---

## 📞 Next Steps

1. ✅ Đọc `README_STANDALONE.md` - Chi tiết về API
2. ✅ Đọc `DEPLOYMENT_GUIDE.md` - Hướng dẫn deploy
3. 🚀 Deploy Python API lên platform yêu thích
4. 🔧 Update `appsettings.json` với production URL
5. ✅ Test và enjoy!

---

## 💡 Tips

### Tip 1: Development workflow
```bash
# Terminal 1
cd project_flowers && python enhanced_api.py

# Terminal 2  
dotnet watch run  # Auto-reload khi code C# thay đổi
```

### Tip 2: Quick switch environments
```bash
# Switch to production
dotnet run --environment Production

# Switch to development
dotnet run --environment Development
```

### Tip 3: Test API trước khi integrate
```bash
cd project_flowers
python test_enhanced_api.py  # Test local API
```

---

Chúc bạn thành công! 🎉
