# Cytomine Fallback

## Overview

This repository contains the code and resources for the Cytomine Fallback project. The project aims to deliver a service where users can log in using LS Login and access the Cytomine service. Once authorized, users can launch a Cytomine instance on Kubernetes to perform collaborative analysis of very large bio-medical images. Our service integrates with backend systems such as the Bigpicture archive.

## Features

- **LS Login Integration:** Allows users to sign in using home organisation credentials, community identities, or social accounts (e.g., Google, LinkedIn).
- **Cytomine Service:** Facilitates the on-demand launching of a Cytomine instance on a Kubernetes namespace or a VM as an alternative.
- **Dataset Handling:** Uses a non-sensitive mock dataset, stored and managed efficiently.
- **Filesystem Wrapper:** Provides an interface for the Bigpicture archive, potentially compatible with existing tools like sda-download or CSC Data Gateway.

## Getting Started

1. Ensure you have Kubernetes or VM infrastructure ready for deploying the Cytomine application.
2. Set up your environment according to the requirements specified in the `environment.md` file.
3. Follow the installation instructions laid out in the `installation.md` to configure and deploy the Cytomine service.

## Usage

Once set up, users can:

1. Log in through the user page using the LS Login method.
2. Initiate the Cytomine service through a simple selection process.
3. Conduct collaborative image analysis and annotations with an easy-to-use interface.
4. Leverage machine learning algorithms for semi-automatic image processing.

## Dependencies

- Kubernetes/VM platform
- LS Login service
- Bigpicture archive or a mock version for non-sensitive data
- Sensitive Data Archive (SDA) tools for data management (if real dataset is to be used)

## Security

The service uses LS Login for secure authentication and ensures that user credentials are handled according to best practices to maintain the integrity and confidentiality of sensitive data.

## Contributing

Contributions are welcome. Please submit a pull request or raise an issue for any bugs, feature requests, or enhancements.

## Contact

For any questions or support, please open an issue in the repository, and a maintainer will respond as soon as possible.
