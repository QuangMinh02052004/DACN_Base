FROM python:3.10-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies (Linux version)
RUN pip install --no-cache-dir Flask Flask-CORS Pillow numpy python-dotenv gunicorn tensorflow

# Copy application files
COPY enhanced_api.py .
COPY improved_recognition.py .
COPY class_names.json .
COPY oxford102_m2_optimized.h5 .

# Create logs directory
RUN mkdir -p /app/logs

# Expose port
EXPOSE 8001

# Environment variables
ENV FLASK_ENV=production
ENV PYTHONUNBUFFERED=1

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:8001/health')"

# Run with gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8001", "--workers", "2", "--timeout", "120", "--access-logfile", "-", "--error-logfile", "-", "enhanced_api:app"]
