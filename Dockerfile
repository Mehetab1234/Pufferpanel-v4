# Use an official Python image as a base
FROM python:3.9

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install dependencies
RUN apt update && apt upgrade -y && \
    apt install -y curl sudo

# Add PufferPanel repository
RUN curl -fsSL https://package.pufferpanel.com/GPG-Key | sudo gpg --dearmor -o /usr/share/keyrings/pufferpanel.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/pufferpanel.gpg] https://package.pufferpanel.com/repository/ubuntu all main" | sudo tee /etc/apt/sources.list.d/pufferpanel.list

# Install PufferPanel
RUN apt update && apt install -y pufferpanel

# Enable PufferPanel service
RUN systemctl enable pufferpanel

# Expose PufferPanel port
EXPOSE 8080

# Start PufferPanel on container run
CMD ["sh", "-c", "systemctl start pufferpanel && tail -f /dev/null"]
