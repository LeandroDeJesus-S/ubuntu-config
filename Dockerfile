FROM ubuntu:24.04

# Install basic dependencies
RUN apt update && apt install -y \
    sudo \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy the project files
COPY . /app

# Set working directory
WORKDIR /app

# Make scripts executable
RUN chmod +x *.sh

# Run the configuration script
CMD ["./configure.sh"]
