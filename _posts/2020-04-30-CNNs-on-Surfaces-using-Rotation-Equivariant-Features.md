---
title: "CNNs on Surfaces using Rotation-Equivariant Features"
layout: publication
categories:
  - Publications
tags:
  - Geometric Deep Learning
  - CNNs on Surfaces
  - Surface Networks
  - Rotation-Equivariance
  - Circular Harmonic Filters
  - Shape Classification
  - Shape Segmentation
  - Shape Correspondence
last_modified_at: 2020-05-06T11:29:17-01:00
venue: "SIGGRAPH 2020"
abstract: "This paper is concerned with a fundamental problem in geometric deep learning that arises in the construction of convolutional neural networks on surfaces. Due to curvature, the transport of filter kernels on surfaces results in a rotational ambiguity, which prevents a uniform alignment of these kernels on the surface. We propose a network architecture for surfaces that consists of vector-valued, rotation-equivariant features. The equivariance property makes it possible to locally align features, which were computed in arbitrary coordinate systems, when aggregating features in a convolution layer. The resulting network is agnostic to the choices of coordinate systems for the tangent spaces on the surface. We implement our approach for triangle meshes. Based on circular harmonic functions, we introduce convolution filters for meshes that are rotation-equivariant at the discrete level. We evaluate the resulting networks on shape correspondence and shape classifications tasks and compare their performance to other approaches."
authors: "R. Wiersma, E. Eisemann and K. Hildebrandt"
type: "Article"
doi: "{10.1145/3386569.3392437}" 
pdf: "/pdf/CNNs_Surfaces_Rotation_Equivariant_Features.pdf"
projectpage: "/hsn"
code: "https://github.com/rubenwiersma/hsn"

bib: "@Article{Wiersma2020,<br />
  &nbsp;&nbsp;author    = {Ruben Wiersma, Elmar Eisemann, Klaus Hildebrandt},<br />
  &nbsp;&nbsp;journal   = {Transactions on Graphics},<br />
  &nbsp;&nbsp;title     = {CNNs on Surfaces using Rotation-Equivariant Features},<br />
  &nbsp;&nbsp;year      = {2020},<br />
  &nbsp;&nbsp;month     = {July},<br />
  &nbsp;&nbsp;number    = {4},<br />
  &nbsp;&nbsp;volume    = {39},<br />
  &nbsp;&nbsp;publisher = {ACM},<br />
  &nbsp;&nbsp;doi       = {10.1145/3386569.3392437},<br />
}"
---