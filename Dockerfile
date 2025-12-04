# Use Python 3.10 because PyTorch + TensorFlow wheels are stable on this version
FROM python:3.10

# Set the working directory in the container
WORKDIR /app

# Install essential system dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    cmake \
    libssl-dev \
    libffi-dev \
    libopenblas-dev \
    python3-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Copy only the requirements file to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip setuptools wheel
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code to the working directory
COPY . .

# Expose port 8000
EXPOSE 8000

ENTRYPOINT ["python"]
CMD ["day02.py"]
