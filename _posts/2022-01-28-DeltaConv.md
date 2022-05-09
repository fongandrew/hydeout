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
  - Exterior Calculus
last_modified_at: 2022-03-06T17:55:12-01:00
venue: "SIGGRAPH 2022"
abstract: "Learning from 3D point-cloud data has rapidly gained momentum, motivated by the success of deep learning on images and the increased availability of 3D data. In this paper, we aim to construct anisotropic convolutions that work directly on the surface derived from a point cloud. This is challenging because of the lack of a global coordinate system for tangential directions on surfaces. We introduce a new convolution operator called DeltaConv, which combines geometric operators from exterior calculus to enable the construction of anisotropic filters on point clouds. Because these operators are defined on scalar- and vector-fields, we separate the network into a scalar- and a vector-stream, which are connected by the operators. The vector stream enables the network to explicitly represent, evaluate, and process directional information. Our convolutions are robust and simple to implement and show improved accuracy compared to state-of-the-art approaches on several benchmarks, while also speeding up training and inference."
authors: "R. Wiersma, A. Nasikun, E. Eisemann and K. Hildebrandt"
type: "Article"
doi: "10.1145/3528223.3530166"
pdf: "https://arxiv.org/abs/2111.08799"
img: "/assets/img/publications/deltaconv_feature.png"
bib: "@Article{WiersmaDeltaConv2022,<br />
  &nbsp;&nbsp;author    = {Ruben Wiersma, Ahmad Nasikun, Elmar Eisemann, Klaus Hildebrandt},<br />
  &nbsp;&nbsp;title     = {DeltaConv: Anisotropic Geometric Deep Learning with Exterior Calculus},<br />
  &nbsp;&nbsp;year      = {2022},<br />
  &nbsp;&nbsp;url      = {https://arxiv.org/abs/2111.08799}<br />
}"
---