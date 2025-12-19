# Beejan Python Environment Bootstrapper
### Overview
Imagine you’ve just joined a data engineering team at a company that maintains multiple Python-based data pipelines and engineering projects. Excited to get started, you quickly realize that before you can even write a single line of code, you need to set up your development environment.

You spend hours creating virtual environments, upgrading pip, configuring gitignore files, and installing essential Python packages; tasks that feel repetitive and tedious for every single new project. This setup process can be very frustrating and time-consuming.

![Setup Script Demo](https://media1.tenor.com/m/GII8hx-nKnAAAAAC/ron-swanson-parks-and-recreation.gif)

#### Heck! This script has just made your life easier.

Here is how it works:

The Beejan Python Environment Bootstrapper is a Bash script that automates all these initial steps. With a single command, this Bootstrapper creates or configures a Python virtual environment, upgrades pip to the latest version, installs essential packages, configures environment files, and even writes a log of all actions - all with a single command. 

It runs identically locally, in Docker, and in CI

No more repetitive setup headaches!!

### Project Goal

The goal of this project is to practice automating repetitive Python setup tasks.

It shows how a simple bootstrap script can save time and ensure consistent environments across local, Docker, and CI workflows.

### Project Structure


### How To Run The Script ([setup_v1.1.sh](./setup_v1.1.sh.sh))

There are two ways to run the Beejan Python Environment Bootstrapper: Locally or using Docker.

#### Option 1: Docker Usage
- Pull docker image from docker hub

      docker pull toske013/beejan-setup:v1.1

- Run pulled docker image  with an interactive bash shell session

      docker run -it --rm toske013/beejan-setup:v1.1 /bin/bash

- Inspect logs (optional)

      cat /vir-env/logs/setup.log

#### Option 2: Local Usage

- Clone the repository to your local machine:

      git clone https://github.com/tos-in1/beejan_python_environment_bootstrapper.git

- Navigate to the directory below:

      cd beejan_python_environment_bootstrapper
   
- Move the `setup_v1.1.sh` to your desired directory and make `setup_v1.1.sh` an executable:
           
      mv setup_v1.1.sh  /path/to/directory && cd /path/to/directory

      chmod +x setup_v1.1.sh

- Run the setup script:

      . ./setup_v1.1.sh

### CI/CD integration

This project uses GitHub Actions to implement a CI/CD workflow that ensures the reliability of the setup process as the project evolves ([GitHub workflow](./.gitHub/workflows)).

The pipeline:

- Validates the setup script on every push and pull request to the `main` branch.
- Builds and verifies the Docker image in a clean CI environment
- Publishes Docker images manually via workflow dispatch after successful validation

This approach gives room for continuous integration as the project evolves and at the same time makes sure that the Docker image release is intentionally gated, ensuring stability and controlled upgrades over time.