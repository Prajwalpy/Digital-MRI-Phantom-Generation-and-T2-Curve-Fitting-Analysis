## Digital MRI Phantom Generation and T2 Curve Fitting Analysis
## Overview
This repository provides MATLAB scripts to generate a digital MRI phantom simulating brain structures, create synthetic T2-weighted MRI images, and perform curve-fitting analysis to extract Proton Density (PD) and T2 relaxation maps. The goal is to validate the accuracy of parameter estimation in simulated MR imaging conditions.

## Project Workflow
- Phantom Generation: Create a brain-like digital phantom with customized Proton Density and T2 relaxation characteristics using MATLAB’s built-in phantom function.
- Synthetic MRI Image Generation: Simulate T2-weighted MRI images from PD and T2 maps across various echo times (TE).
- Noise Addition: Apply Gaussian noise to images to mimic real-world MRI signal variations.
- Curve-Fitting Analysis: Use nonlinear least-squares (lsqcurvefit) to estimate PD and T2 maps from noisy synthetic images.

## Detailed Steps

- Phantom Creation: 128x128 phantom generated with 7 ellipses based on a modified Shepp-Logan configuration.
- Customized intensities for PD and T2 maps.
- Synthetic Image Generation: Create 10 T2-weighted images based on varying echo times (TE values from 10 ms, incremented by 20 ms).
- Noise Simulation: Add Gaussian noise to each image based on predefined parameters.
- Curve-Fitting: Perform voxel-wise fitting using MATLAB's lsqcurvefit function to reconstruct PD and T2 maps from noisy data.

## Repository Structure
- scripts/: MATLAB scripts for phantom generation, image synthesis, noise addition, and curve-fitting.
- results/: Output images and calculated PD and T2 maps.

## Requirements

- MATLAB with Image Processing Toolbox and Optimization Toolbox.

## Contributions
Contributions and improvements are encouraged. Please fork the repository and open pull requests for proposed changes.
