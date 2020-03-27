---
title: "Harmonic Surface Networks"
layout: publication
categories:
  - Publications
tags:
  - Deep learning
  - Surfaces
  - Geometry processing
  - Convolutional Neural Networks
  - Rotational Equivariance
  - Machine Learning
last_modified_at: 2020-03-27T03:10:40-01:00
venue: ""
abstract: "We present a new approach for deep learning on surfaces, combining geometric convolutional networks with rotationally equivariant networks. Existing work either learns rotationally invariant filters, or learns filters in the tangent plane without correctly relating orientations between different tangent planes (orientation ambiguity). We propose a solution to both problems by applying Harmonic Networks on surfaces in the tangent plane: Harmonic Surface Networks (HSN).Harmonic Networks constrain their filters to circular harmonics, which output complexvalued, rotatable feature maps. Considering these complex features as vectors inside the tangent plane, we can use parallel transport along shortest geodesics to transport them along the surface in a natural way. Additionally, Harmonic Networks can be configured so that the output is rotationally invariant, while containing rotationally equivariant filters in hidden layers. This property solves the orientation ambiguity problem, while learning directional filters. We evaluate HSN on three different problems: classification on Rotated MNIST in a plane and mapped to a sphere, correspondence on FAUST, and shape segmentation on FAUST. The results suggest that HSN could improve on state of the art approaches."
authors: "R. Wiersma"
type: "MastersThesis"
link: ""
bib: "@MastersThesis{Wiersma2019,<br />
  &nbsp;&nbsp;author   = {Wiersma, Ruben},<br />
  &nbsp;&nbsp;school   = {Delft University of Technology},<br />
  &nbsp;&nbsp;title    = {Harmonic Surface Networks},<br />
  &nbsp;&nbsp;year     = {2019},<br />
  &nbsp;&nbsp;month    = oct,<br />
  &nbsp;&nbsp;url      = {http://resolver.tudelft.nl/uuid:931ee653-eb26-40c2-8f54-9c5835fd6fba},<br />
}"
 pdf: "http://resolver.tudelft.nl/uuid:931ee653-eb26-40c2-8f54-9c5835fd6fba" 
---