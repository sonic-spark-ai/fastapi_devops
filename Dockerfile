# Dockerfile
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Copy the dependencies file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the FastAPI app code into the container
COPY . .

# Expose the FastAPI port
EXPOSE 8000

# Run FastAPI server
CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "8000"]
