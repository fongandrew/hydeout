---
title: "Deep Vanishing Point Detection: Geometric priors make dataset variations vanish"
layout: publication
categories:
  - Publications
tags:
  - Vanishing Point Detection
  - Geometric Priors
  - Spherical Convolutions
  - Geometric Deep Learning
last_modified_at: 2022-03-06T17:43:47-01:00
venue: "CVPR 2022"
abstract: "Deep learning has greatly improved vanishing point detection in images. Yet, deep networks require expensive annotated datasets trained on costly hardware and do not generalize to even slightly different domains and minor problem variants. Here, we address these issues by injecting deep vanishing point detection networks with prior knowledge.  This prior knowledge no longer needs to be learned from data, saving valuable annotation efforts and compute, unlocking realistic few-sample scenarios, and reducing the impact of domain changes. Moreover, because priors are interpretable, it is easier to adapt deep networks to minor problem variations such as switching between Manhattan and non-Manhattan worlds. We incorporate two end-to-end trainable geometric priors: (i) Hough Transform -- mapping image pixels to straight lines, and (ii) Gaussian sphere -- mapping lines to great circles whose intersections denote vanishing points. Experimentally, we ablate our choices and show comparable accuracy as existing models in the large-data setting. We then validate that our model improves data efficiency, is robust to domain changes, and can easily be adapted to a non-Manhattan setting."
authors: "Y. Lin, R. Wiersma, S. L. Pintea, K. Hildebrandt, E. Eisemann and J. C. van Gemert"
type: "Article"
doi: "10.1109/CVPR52688.2022.00601"
img: "/assets/img/publications/dvpd_feature.png"
pdf: "https://arxiv.org/pdf/2203.08586.pdf"
code: "https://github.com/yanconglin/VanishingPoint_HoughTransform_GaussianSphere"
bib: "@article{lin2022vpd,
  title={Deep vanishing point detection: Geometric priors make dataset variations vanish},
  author={Lin, Yancong and Wiersma, Ruben and and Pintea, Silvia L and Hildebrandt, Klaus and Eisemann, Elmar and van Gemert, Jan C},
  booktitle={Conference on Computer Vision and Pattern Recognition},
  year={2022}
}"
---