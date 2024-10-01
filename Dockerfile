# Use a smaller Python base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install virtualenv for creating isolated environments
RUN python3 -m venv /app/venv

# Copy the requirements file and install dependencies inside the virtual environment
COPY requirements.txt .
RUN /app/venv/bin/pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the required port
EXPOSE 8000

# Run the app using the virtual environment
CMD ["/app/venv/bin/uvicorn", "router.main:app", "--host", "0.0.0.0", "--port", "8000"]
