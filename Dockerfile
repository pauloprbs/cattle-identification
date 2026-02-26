FROM tensorflow/tensorflow:latest-gpu-jupyter

# Evita prompts interativos durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependências de sistema para OpenCV e processamento de imagem
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /tf/notebooks

# Instalar requisitos do Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Expõe a porta do Jupyter
EXPOSE 8888