# Use the Python 3.9-buster base image
FROM python:3.9-buster

# Set the working directory
WORKDIR /app

# Upgrade pip to a stable version
RUN python3 -m ensurepip --upgrade && \
    python3 -m pip install --upgrade pip==22.3

# Create a virtual environment
RUN python3 -m venv venv

# Set the virtual environment's bin directory in the PATH
ENV PATH="/app/venv/bin:$PATH"

# Copy only the requirements file first to leverage Docker cache
COPY requirements.txt .

# Upgrade pip inside the virtual environment and install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir --retries=10 -r requirements.txt --timeout=180

# Now copy the rest of the application code into the container
COPY . .

# Expose the application port
EXPOSE 8000

# Command to start the FastAPI application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
