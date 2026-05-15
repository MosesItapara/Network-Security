FROM python:3.9-slim

WORKDIR /app

COPY . /app

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "app.py"]  # or however you start your app