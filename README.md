# An Introduction to 
# Generative Adversarial Networks

[![LaTeX](https://img.shields.io/badge/LaTeX-008080.svg)](https://www.latex-project.org/)
[![R](https://img.shields.io/badge/R-276DC3.svg)](https://www.r-project.org/)

This thesis provides a comprehensive survey of the mathematical theory underlying Generative Adversarial Networks (GANs), exploring the algorithm through three complementary theoretical frameworks: game theory, information theory, and optimal transport theory.

## Overview

Generative Adversarial Networks have revolutionized the field of machine learning since their introduction in 2014, enabling unprecedented advances in synthetic media generation, data augmentation, and representation learning. Despite their empirical success, the theoretical foundations of GANs remain complex and multifaceted.

This thesis aims to bridge rigorous mathematical theory with intuitive understanding, making the theoretical underpinnings of GANs accessible to researchers and practitioners alike. By synthesizing concepts from game theory, information theory, and optimal transport, we provide both depth and breadth in analyzing the GAN framework.

## Thesis Structure

The thesis is organized into three main theoretical sections:

### 1. Game Theory
- **Nash equilibrium and strategic interactions** in adversarial training
- **Minimax formulation** of the GAN objective function
- **Challenges in finding stable equilibria** during training
- **Algorithmic implementation** and strategic analysis

### 2. Information Theory
- **Entropy, divergences, and mutual information** in machine learning
- **Information-theoretic perspective** on the value function
- **Step-by-step optimization dynamics** vs. limiting behavior
- **Rigorous proofs** connecting GAN training to Jensen-Shannon divergence minimization

### 3. Optimal Transport
- **Historical context** of Monge and Kantorovich's transportation problem
- **Wasserstein distances** and their topological properties
- **Wasserstein GAN (WGAN)** and its advantages over the original formulation
- **Kantorovich-Rubinstein duality** and practical implementation

## Key Contributions

- A unified framework integrating three mathematical perspectives on GANs
- Detailed derivations of the GAN value function from both discriminator and generator perspectives
- Rigorous proofs establishing the relationship between GAN optimization and divergence minimization
- Critical analysis of limitations in the original GAN formulation and how optimal transport addresses these issues
- Pedagogical examples and visualizations that make complex mathematical concepts accessible

## Building the Thesis

The thesis is written in LaTeX and requires the following to build:

### Prerequisites
- A LaTeX distribution (TeX Live, MiKTeX, etc.)
- R (for generating plots and simulations)
- Required LaTeX packages: `amsmath`, `amssymb`, `amsthm`, `graphicx`, `tikz`, `algorithm`, `algorithmicx`, `algpseudocode`

### Build Instructions
```bash
# Clone the repository
git clone https://github.com/bryanpaget/gan.git
cd gan

# Build the PDF
pdflatex thesis.tex
bibtex thesis
pdflatex thesis.tex
pdflatex thesis.tex
```

Alternatively, use `latexmk` for automated building:
```bash
latexmk -pdf thesis
```

## Citation

If you use this work in your research, please cite it as:

```bibtex
@mastersthesis{paget2019gan,
  author  = {Paget, Bryan},
  title   = {An Introduction to Generative Adversarial Networks},
  school  = {University of Ottawa},
  year    = {2019},
  month   = {August}
}
```
## Acknowledgments

I would like to thank my supervisors, Dr. Maia Fraser and Dr. Vadim Kaimanovich, for their guidance and support throughout this research. I am also grateful to the University of Ottawa and the Department of Mathematics and Statistics for providing an excellent research environment.
