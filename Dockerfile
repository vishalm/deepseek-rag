FROM python:3.10

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.ai/install.sh | bash

# Install Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Expose Streamlit default port
EXPOSE 8501

# Start Ollama in the background, ensure model is downloaded, and run the app
CMD ollama serve & sleep 5 && ollama pull deepseek-r1:1.5b && streamlit run app.py --server.port=8501 --server.address=0.0.0.0
