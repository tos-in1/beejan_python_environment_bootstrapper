# Image built from python base image
FROM python:3.12-slim

# Ensure all commands run in bash
SHELL ["/bin/bash", "-c"]

# Set working directory in the container
WORKDIR /vir-env

# Copy project file
COPY ./setup_v1.1.sh /vir-env

# Make sure script is an executable
RUN chmod +x setup_v1.1.sh
# Run the script
RUN ./setup_v1.1.sh
