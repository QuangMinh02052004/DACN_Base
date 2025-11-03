# 🚀 Deployment Guide - Bloomie Flower Recognition API

Hướng dẫn deploy Python API lên các platforms phổ biến.

---

## 📋 Phương án 1: PythonAnywhere (MIỄN PHÍ - Khuyến nghị cho học sinh/sinh viên)

### Ưu điểm:
✅ Free tier có sẵn  
✅ Không cần credit card  
✅ Hỗ trợ Flask sẵn  
✅ Easy setup  

### Bước thực hiện:

1. **Đăng ký tài khoản**: https://www.pythonanywhere.com/registration/register/beginner/

2. **Upload files**:
```bash
# Tại PythonAnywhere Bash Console
git clone https://github.com/QuangMinh02052004/DACN_Base.git
cd DACN_Base/project_flowers
```

3. **Cài đặt dependencies**:
```bash
pip3 install --user -r requirements.txt
```

4. **Cấu hình Web App**:
   - Go to "Web" tab → "Add a new web app"
   - Choose "Flask"
   - Python version: 3.10
   - Path: `/home/yourusername/DACN_Base/project_flowers/enhanced_api.py`
   - WSGI file: Edit để point tới `app` object

5. **WSGI Configuration** (`/var/www/yourusername_pythonanywhere_com_wsgi.py`):
```python
import sys
path = '/home/yourusername/DACN_Base/project_flowers'
if path not in sys.path:
    sys.path.append(path)

from enhanced_api import app as application
```

6. **Reload** web app và truy cập: `https://yourusername.pythonanywhere.com`

7. **Update C# project**:
```json
{
  "ImageSearch": {
    "PythonApiUrl": "https://yourusername.pythonanywhere.com"
  }
}
```

---

## 📋 Phương án 2: Railway.app (Dễ nhất, có free tier)

### Ưu điểm:
✅ Auto-deploy từ GitHub  
✅ Free $5 credits/month  
✅ HTTPS tự động  
✅ Logs realtime  

### Bước thực hiện:

1. **Push code lên GitHub**:
```bash
cd /Users/lequangminh/Documents/DACN_Base-3/project_flowers
git init
git add .
git commit -m "Standalone Python API"
git remote add origin https://github.com/QuangMinh02052004/bloomie-flower-api.git
git push -u origin main
```

2. **Đăng ký Railway**: https://railway.app

3. **New Project** → **Deploy from GitHub repo**

4. **Chọn repository**: `bloomie-flower-api`

5. **Railway tự động detect**:
   - Python project
   - requirements.txt
   - Start command: `python enhanced_api.py`

6. **Add Environment Variables**:
```
FLASK_ENV=production
API_PORT=$PORT
```

7. **Deploy** → Copy URL: `https://your-app.railway.app`

8. **Update C# project**:
```json
{
  "ImageSearch": {
    "PythonApiUrl": "https://your-app.railway.app"
  }
}
```

---

## 📋 Phương án 3: Render.com (Free tier tốt)

### Ưu điểm:
✅ Free tier không giới hạn thời gian  
✅ Auto-deploy từ GitHub  
✅ HTTPS free  
✅ Dễ setup  

### Bước thực hiện:

1. **Đăng ký**: https://render.com

2. **New Web Service** → Connect GitHub repository

3. **Configuration**:
   - **Name**: bloomie-flower-api
   - **Environment**: Python 3
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `gunicorn enhanced_api:app --bind 0.0.0.0:$PORT`

4. **Environment Variables**:
```
FLASK_ENV=production
```

5. **Deploy** → URL: `https://bloomie-flower-api.onrender.com`

⚠️ **Lưu ý**: Free tier sleep sau 15 phút không dùng (first request sẽ chậm ~30s)

---

## 📋 Phương án 4: Docker (Chạy local hoặc VPS)

### Sử dụng khi:
- Có VPS riêng
- Muốn control hoàn toàn
- Production environment

### Bước thực hiện:

1. **Build Docker image**:
```bash
cd /Users/lequangminh/Documents/DACN_Base-3/project_flowers
docker build -t bloomie-flower-api .
```

2. **Run container**:
```bash
docker run -d -p 8001:8001 --name flower-api bloomie-flower-api
```

3. **Check logs**:
```bash
docker logs -f flower-api
```

4. **Deploy lên VPS**:
```bash
# Push to Docker Hub
docker tag bloomie-flower-api yourusername/bloomie-flower-api
docker push yourusername/bloomie-flower-api

# Tại VPS
docker pull yourusername/bloomie-flower-api
docker run -d -p 8001:8001 yourusername/bloomie-flower-api
```

---

## 📋 Phương án 5: Heroku (Cần credit card)

### Ưu điểm:
✅ Ổn định  
✅ Nhiều add-ons  
✅ CI/CD tốt  

### Bước thực hiện:

1. **Install Heroku CLI**: https://devcenter.heroku.com/articles/heroku-cli

2. **Login**:
```bash
heroku login
```

3. **Create app**:
```bash
cd /Users/lequangminh/Documents/DACN_Base-3/project_flowers
heroku create bloomie-flower-api
```

4. **Deploy**:
```bash
git push heroku main
```

5. **URL**: `https://bloomie-flower-api.herokuapp.com`

---

## 🎯 So sánh các phương án:

| Platform | Giá | Setup | Performance | Khuyến nghị |
|----------|-----|-------|-------------|-------------|
| **PythonAnywhere** | Free ⭐ | Dễ | Trung bình | Học sinh/SV |
| **Railway** | $5/month ⭐⭐⭐ | Rất dễ | Tốt | Development |
| **Render** | Free ⭐⭐ | Dễ | Tốt | Side projects |
| **Docker + VPS** | $5-10/month | Khó | Xuất sắc | Production |
| **Heroku** | $7/month | Trung bình | Tốt | Startup |

---

## ✅ Khuyến nghị cho bạn:

### 🎓 Nếu là đồ án / học tập:
→ **PythonAnywhere** (Free, đủ dùng)

### 💼 Nếu demo cho khách hàng:
→ **Railway** hoặc **Render** (Professional, không sleep)

### 🚀 Nếu production thật:
→ **Docker + VPS** hoặc **Railway**

---

## 🔧 Sau khi deploy, update C# project:

1. **Development** (local testing):
```json
{
  "ImageSearch": {
    "PythonApiUrl": "http://localhost:8001"
  }
}
```

2. **Production** (deployed API):
```json
{
  "ImageSearch": {
    "PythonApiUrl": "https://your-api-url.com"
  }
}
```

3. **Flexible** (switch giữa local và remote):
```json
{
  "ImageSearch": {
    "PythonApiUrl": "http://localhost:8001",
    "ProductionApiUrl": "https://your-api-url.com",
    "UseProduction": false
  }
}
```

---

## 📞 Troubleshooting

### API không response:
- Check logs trên platform
- Verify model file đã upload
- Check CORS settings

### Slow response:
- Free tier platforms thường sleep
- Consider upgrade plan
- Add warm-up endpoint

### Out of memory:
- Model file lớn (~300MB)
- Cần ít nhất 512MB RAM
- Consider upgrade instance

---

## 🎯 Next Steps:

1. Chọn platform phù hợp
2. Deploy theo hướng dẫn
3. Test API với curl/Postman
4. Update C# appsettings.json
5. Deploy C# project
6. Done! 🎉
