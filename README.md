# BC-TRUST

### The Interactive Interval Dataset contains from_ Address, to_ Address and all interaction records.

### CertificateContract is a smart contract for PN certificates.

### # DBSCAN-based Node Distinction on Ethereum Telemetry (BC-TRUST Experiment)

This repository provides a reproducible pipeline (Jupyter Notebook) to preprocess an Ethereum on-chain interaction dataset, derive delay-related telemetry features using a **Historical Processing Delay (HPD)** algorithm, and distinguish node behavior patterns via **DBSCAN** clustering.

The resulting visualization corresponds to the “distinctions” figure used in our paper.

---

## Contents

- `DBSCAN.ipynb` — End-to-end notebook:
  - Load dataset
  - Filter insufficient interactions
  - Compute **interval** feature
  - Compute **delay** feature (HPD-based)
  - Run **DBSCAN** clustering
  - Plot clustered results (Dense cluster vs outliers / anomalous patterns)

- `Interactive Interval Dataset.csv` — Input dataset (place in the same folder as the notebook)

> **Note:** The dataset is published in our paper’s GitHub link. This repo contains the code to reproduce the clustering and figure.

---

## Environment

Tested with **Python 3.8+**.

### Dependencies

- `pandas`
- `numpy`
- `matplotlib`
- `scikit-learn`

Install:

```bash
pip install pandas numpy matplotlib scikit-learn
