# 🔐 Network Security — ML-Powered Threat Detection

An end-to-end machine learning pipeline for network intrusion and threat detection, built with FastAPI, MLflow, and DagsHub — containerized with Docker and deployed on Railway.

---

## 📌 Overview

This project trains a machine learning model on network traffic data to detect security threats. It exposes a REST API for triggering training runs and serving predictions, with full experiment tracking via MLflow and DagsHub.

---

## 🧱 Architecture

```
Request → FastAPI → Training Pipeline → MLflow (DagsHub)
                  ↘ Prediction Pipeline → Model Artifacts
```

**Pipeline stages:**

1. **Data Ingestion** — Loads raw network traffic data into the pipeline
2. **Data Validation** — Validates schema, detects drift and anomalies
3. **Data Transformation** — Feature engineering, preprocessing (saved as `preprocessing.pkl`)
4. **Model Training** — Trains classifier, logs metrics and model to MLflow/DagsHub

---

## 🛠️ Tech Stack

| Layer | Tool |
|---|---|
| API | FastAPI + Uvicorn |
| ML Pipeline | Scikit-learn |
| Experiment Tracking | MLflow + DagsHub |
| Containerization | Docker |
| Deployment | Railway |
| Language | Python 3.10+ |

---

## 🚀 Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/haggaimoses19/Network-Security.git
cd Network-Security
```

### 2. Create and activate a virtual environment

```bash
python -m venv venv

# Windows
venv\Scripts\activate

# macOS/Linux
source venv/bin/activate
```

### 3. Install dependencies

```bash
pip install -r requirements.txt
```

### 4. Set environment variables

Create a `.env` file in the root directory:

```env
DAGSHUB_TOKEN=your_dagshub_token
MLFLOW_TRACKING_URI=https://dagshub.com/haggaimoses19/Network-Security.mlflow
MLFLOW_TRACKING_USERNAME=haggaimoses19
MLFLOW_TRACKING_PASSWORD=your_dagshub_token
```

### 5. Run the app

```bash
python app.py
```

The API will be available at `http://localhost:8000`.  
Interactive docs: `http://localhost:8000/docs`

---

## 🐳 Docker

### Build the image

```bash
docker build -t networksecurity .
```

### Run the container

```bash
docker run -p 8000:8000 \
  -e DAGSHUB_TOKEN=your_token \
  -e MLFLOW_TRACKING_USERNAME=haggaimoses19 \
  -e MLFLOW_TRACKING_PASSWORD=your_token \
  networksecurity
```

---

## 🌐 API Endpoints

| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/` | Redirects to `/docs` |
| `GET` | `/train` | Triggers the full training pipeline |
| `POST` | `/predict` | Upload a CSV file and get predictions |

### Example — trigger training

```bash
curl http://localhost:8000/train
```

### Example — get predictions

```bash
curl -X POST http://localhost:8000/predict \
  -F "file=@network_data.csv"
```

---

## 📊 Experiment Tracking

All training runs are tracked on DagsHub via MLflow:

🔗 [https://dagshub.com/haggaimoses19/Network-Security](https://dagshub.com/haggaimoses19/Network-Security)

Tracked per run:
- Model metrics (accuracy, F1, etc.)
- Preprocessing artifact (`preprocessing.pkl`)
- Trained model artifact

---

## 📁 Project Structure

```
NETWORKSECURITY/
├── app.py                          # FastAPI entrypoint
├── Dockerfile
├── requirements.txt
├── Artifacts/                      # Pipeline outputs (gitignored)
│   └── <timestamp>/
│       ├── data_ingestion/
│       ├── data_validation/
│       ├── data_transformation/
│       │   └── transformed_object/
│       │       └── preprocessing.pkl
│       └── model_trainer/
├── networksecurity/
│   ├── components/
│   │   ├── data_ingestion.py
│   │   ├── data_validation.py
│   │   ├── data_transformation.py
│   │   └── model_trainer.py
│   ├── entity/
│   │   ├── config_entity.py
│   │   └── artifact_entity.py
│   ├── pipeline/
│   │   └── training_pipeline.py
│   ├── exception/
│   │   └── exception.py
│   └── logging/
│       └── logger.py
```

---

## ☁️ Deployment (Railway)

This project is deployed on Railway. Set the following environment variables in your Railway project dashboard:

- `DAGSHUB_TOKEN`
- `MLFLOW_TRACKING_USERNAME`
- `MLFLOW_TRACKING_PASSWORD`
- `MLFLOW_TRACKING_URI`

Railway auto-detects the `Dockerfile` and builds on push.

---

## 👤 Author

**Moise Haggai**  
[DagsHub](https://dagshub.com/haggaimoses19) · [GitHub](https://github.com/haggaimoses19)
