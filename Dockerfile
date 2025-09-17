FROM python:3.10-slim

WORKDIR /app

RUN apt-get update && apt-get install -y git wget curl build-essential ffmpeg && rm -rf /var/lib/apt/lists/*

# Clone ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git
WORKDIR /app/ComfyUI
RUN pip install --no-cache-dir -r requirements.txt

# Add BiRefNet custom node
WORKDIR /app/ComfyUI/custom_nodes
RUN git clone https://github.com/moon7star9/ComfyUI_BiRefNet_Universal.git BiRefNet_Universal
WORKDIR /app/ComfyUI

# Copy workflow + cached models from build context
COPY workflows /app/ComfyUI/workflows
COPY models /app/ComfyUI/models

EXPOSE 8080

CMD ["python", "main.py", "--listen", "0.0.0.0", "--port", "8080"]

