# Imagem oficial do TensorFlow com suporte a GPU e Jupyter
FROM tensorflow/tensorflow:latest-gpu-jupyter

# Instalar dependências do sistema para OpenCV
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

# Instalar bibliotecas adicionais
RUN pip install pandas scikit-learn opencv-python matplotlib seaborn tqdm scipy optuna

# Definir diretório de trabalho
WORKDIR /tf/notebooks

# Comando para iniciar o Jupyter (já vem na imagem base, mas garantimos aqui)
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--no-browser", "--allow-root"]