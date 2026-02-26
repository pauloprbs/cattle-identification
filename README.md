# Relatório Técnico: Identificação Biométrica Individual de Bovinos
**Disciplina:** Visão Computacional
**Instituição:** IFG (Instituto Federal de Goiás)
**Autor:** Paulo

---

## 1. Introdução e Objetivos
Este projeto apresenta uma solução de **Metric Learning** para a identificação individual de gado bovino. O objetivo central é superar a limitação de classificadores tradicionais, permitindo a identificação de novos animais sem a necessidade de retreinamento do modelo, utilizando para isso uma arquitetura de **Rede Siamesa**.

## 2. Metodologia e Pipeline de Execução

O projeto está estruturado em um pipeline de 6 etapas, organizadas por notebooks:

1.  **Extração e Organização (`01_extracao_dados.ipynb`)**: Consolidação do dataset de imagens originais organizadas por ID.
2.  **Análise Exploratória (`02_analise_exploratoria.ipynb`)**: Verificação da distribuição de classes e qualidade das amostras.
3.  **Treinamento YOLOv8-Pose (`03_treinamento.ipynb`)**: Treinamento de um modelo de detecção de pose para localizar 8 pontos anatômicos (withers, hooks, pins, etc.).
4.  **Extração Biométrica (`04_extração_biometrica.ipynb`)**: Geração do vetor de características híbrido.
5.  **Baseline Clássico (`05_reconhecimento_de_bovinos.ipynb`)**: Avaliação inicial usando SVM e XGBoost.
6.  **Rede Siamesa (`06_siamese_network.ipynb`)**: Implementação do modelo de verificação de similaridade.

## 3. Engenharia de Características (Feature Engineering)

O sucesso do modelo baseia-se na fusão de três tipos de descritores extraídos no Notebook 04:

* **Geometria (28 Variáveis)**: Distâncias Euclidianas calculadas entre os keypoints anatômicos detectados. Estas métricas capturam as proporções ósseas únicas de cada animal.
* **Textura (Descritores SIFT)**: Identificação de padrões únicos na pelagem através de transformações de características invariantes à escala, binarizadas para compor o vetor.
* **Cromatismo (RGB/HSV)**: Médias e desvios padrões de cor, auxiliando na distinção por tonalidade estrutural da mancha.

## 4. Resultados Alcançados

Os modelos foram avaliados quanto à sua capacidade de distinguir entre animais do mesmo ID (pares positivos) e animais diferentes (pares negativos):

* **YOLOv8-Pose**: Obteve **91.1% de Pose mAP 50-95**, garantindo a precisão das medidas geométricas extraídas.
* **Classificadores Clássicos (SVM)**: Atingiram aproximadamente **61% de acurácia** na identificação direta.
* **Rede Siamesa (Metric Learning)**: Atingiu acurácia superior a **70%** no conjunto de validação. 
    * **Diferencial**: O modelo gera *embeddings* (assinaturas digitais) que permitem o cadastro (*enrollment*) de novas vacas no sistema sem necessidade de novos ciclos de treinamento.

## 5. Como Reproduzir (Ambiente Docker)

O projeto é 100% conteinerizado para garantir a reprodutibilidade.

```bash
# Clone o repositório
git clone [URL_DO_REPOSITORIO]
cd cattle-identification

# Suba o ambiente (Jupyter iniciará automaticamente na porta 8888)
docker compose up --build