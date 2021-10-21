FROM python:3

# Install helpers
RUN apt-get -qq update && \
    apt-get -qq install jq vim libicu-dev python3-dev

# Change to non-root
RUN useradd -ms /bin/bash codegen && \
    mkdir -p /app && \
    chown -R codegen /app
USER codegen
WORKDIR /app

ENV PATH=$PATH:/home/codegen/.local/bin

# Install py deps and copy source
COPY requirements.txt .
RUN pip install --user -r requirements.txt 
COPY . .

# Run codegen script
CMD ["python", "/app/swagger-k8s-crd-codegen.py"]
