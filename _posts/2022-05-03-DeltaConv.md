---
title: "DeltaConv: Anisotropic Operators for Geometric Deep Learning on Point Clouds"
layout: publication
categories:
  - Publications
tags:
  - Geometric Deep Learning
  - Point Clouds
  - Surface Networks
  - Rotation-Equivariance
  - Shape Classification
  - Shape Segmentation
  - Vector Calculus
last_modified_at: 2022-05-10T10:21:00-01:00
venue: "SIGGRAPH 2022"
abstract: "Learning from 3D point-cloud data has rapidly gained momentum, motivated by the success of deep learning on images and the increased availability of 3D~data. In this paper, we aim to construct anisotropic convolution layers that work directly on the surface derived from a point cloud. This is challenging because of the lack of a global coordinate system for tangential directions on surfaces. We introduce DeltaConv, a convolution layer that combines geometric operators from vector calculus to enable the construction of anisotropic filters on point clouds. Because these operators are defined on scalar- and vector-fields, we separate the network into a scalar- and a vector-stream, which are connected by the operators. The vector stream enables the network to explicitly represent, evaluate, and process directional information. Our convolutions are robust and simple to implement and match or improve on state-of-the-art approaches on several benchmarks, while also speeding up training and inference."
authors: "R. Wiersma, A. Nasikun, E. Eisemann and K. Hildebrandt"
type: "Article"
doi: "10.1145/3528223.3530166"
pdf: "https://arxiv.org/abs/2111.08799"
projectpage: "/deltaconv"
code: "https://github.com/rubenwiersma/deltaconv"
img: "/assets/img/publications/deltaconv/deltaconv.png"
bib: "@Article{Wiersma2022DeltaConv,<br />
  author    = {Ruben Wiersma, Ahmad Nasikun, Elmar Eisemann, Klaus Hildebrandt},<br />
  journal   = {Transactions on Graphics},<br />
  title     = {DeltaConv: Anisotropic Operators for Geometric Deep Learning on Point Clouds},<br />
  year      = {2022},<br />
  month     = jul,<br />
  number    = {4},<br />
  volume    = {41},<br />
  doi       = {10.1145/3528223.3530166},<br />
  publisher = {ACM},<br />
}"
---