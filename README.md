# Relatório Técnico: Sistema Híbrido de Visão Computacional para Identificação Individual Bovina

**Nível:** Pós-Graduação em Inteligência Artificial / Visão Computacional

## 1. Resumo Executivo
Este documento detalha o desenvolvimento de um pipeline inteligente capaz de identificar vacas individualmente. O sistema utiliza uma abordagem de duas etapas: primeiro, a localização de marcos anatômicos (Keypoints) via **Deep Learning**, seguido por uma análise de **Geometria Computacional** e **Aprendizado Supervisionado** para a classificação de identidade.

---

## 2. Fase 1: Estimativa de Pose (Notebook 03)
A primeira etapa utiliza o modelo **YOLOv8-Pose**. O objetivo aqui não é apenas detectar a vaca, mas extrair sua "assinatura estrutural".

* **Configuração do Modelo:** Foi utilizado o modelo `yolov8n-pose.pt` (versão Nano), otimizado para ambientes com restrição de hardware (GTX 1650).
* **Anotações Anatômicas:** O modelo foi treinado para identificar 8 pontos-chave (Cernelha, Dorso, Lombo, Garupa, Hooks e Pins).
* **Métrica de Sucesso:** O treinamento atingiu alta precisão na localização dos pontos, permitindo que a próxima fase recebesse dados limpos.

---

## 3. Fase 2: Engenharia de Atributos Biométricos (Notebook 04)
Nesta fase, as coordenadas $(x, y)$ dos pontos são transformadas em características que não dependem do ângulo da foto.

### 3.1. Geometria Pura
Foram calculados ângulos de conformação e áreas de polígonos pélvicos. Matematicamente, utilizamos o produto escalar para extrair ângulos:
$$\theta = \cos^{-1} \left( \frac{\mathbf{u} \cdot \mathbf{v}}{\|\mathbf{u}\| \|\mathbf{v}\|} \right)$$

### 3.2. Descritores de Textura (LBP)
Além da geometria, o projeto utiliza **Local Binary Patterns (LBP)** para capturar o padrão de rugosidade ou pelagem, transformando a imagem em um histograma numérico que complementa os dados geométricos.

---

## 4. Fase 3: Modelagem e Reconhecimento (Notebooks 05 e 06)
Com os dados extraídos, foram testadas duas arquiteturas de ponta para a identificação:

### 4.1. Perceptron Multicamadas (MLP)
Uma rede neural densa foi treinada para classificar cada vetor de características em uma das identidades conhecidas.
* **Resultados:** No Cenário Híbrido (Geometria + LBP), o modelo alcançou **98% de acurácia** no conjunto de teste para as classes avaliadas, demonstrando que a união de "forma" e "textura" é superior a qualquer uma das métricas isoladas.

### 4.2. Redes Siamesas (Deep Metric Learning)
O Notebook 06 implementa uma abordagem baseada em **Similaridade**. Em vez de classificar, a rede aprende a "distância" entre duas vacas.
* **Vantagem:** Permite identificar se uma vaca é nova no sistema sem precisar retreinar todo o modelo (sistema Open-Set).
* **Função de Perda:** Utiliza similaridade de cosseno para agrupar instâncias da mesma vaca no espaço latente.

---

## 5. Resultados e Conclusão
Os experimentos demonstram que a identificação bovina por keypoints é altamente eficaz. O uso de modelos leves como YOLOv8n e MLPs estruturadas permitiu processamento em tempo real com alta confiabilidade.

**Destaques do Projeto:**
1.  Invariância a escala e rotação através de geometria.
2.  Alta acurácia (98%) com dados híbridos.
3.  Pipeline modularizado, facilitando a substituição de componentes no futuro.