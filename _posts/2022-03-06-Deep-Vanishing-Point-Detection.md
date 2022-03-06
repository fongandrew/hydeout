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
img: "/assets/img/publications/dvpd_feature.jpg"
bib: "@Article{LinDVPD2022,<br />
  &nbsp;&nbsp;author    = {Yancong Lin, Ruben Wiersma, Silvia L. Pintea, Klaus Hildebrandt, Elmar Eisemann, Jan C. van Gemert},<br />
  &nbsp;&nbsp;booktitle = {},<br />
  &nbsp;&nbsp;title     = {Deep Vanishing Point Detection: Geometric priors make dataset variations vanish},<br />
  &nbsp;&nbsp;year      = {2022},<br />
  &nbsp;&nbsp;month     = {},<br />
  &nbsp;&nbsp;pages     = {},<br />
  &nbsp;&nbsp;publisher = {},<br />
  &nbsp;&nbsp;series    = {},<br />
  &nbsp;&nbsp;doi       = {},<br />
  &nbsp;&nbsp;isbn      = {},<br />
}"
---