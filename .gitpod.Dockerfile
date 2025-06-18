# .gitpod.Dockerfile — Real-Time DevOps Setup
FROM gitpod/workspace-full:latest
 
USER root
 
# Essential tools for DevOps engineers
RUN apt-get update && apt-get install -y \
    default-jdk \
    maven \
docker.io \
    curl \
    unzip \
    gnupg \
    lsb-release \
    software-properties-common \
    python3-pip \
    jq \
    net-tools
 
# Install Terraform (IaC for AWS)
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y terraform
 
# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \
    ./aws/install && \
rm -rf aws awscliv2.zip
 
# Download Jenkins (Run with java -jar jenkins.war)
RUN curl -fsSL https://get.jenkins.io/war-stable/2.426.1/jenkins.war -o /usr/local/bin/jenkins.war
 
# Install kubectl (for Kubernetes)
RUN curl -LO "https://dl.k8s.io/release/v1.32.0/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    rm kubectl
 
# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
 
USER gitpod
