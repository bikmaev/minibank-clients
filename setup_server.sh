#!/bin/bash
USERNAME="minibank"
adduser --disabled-password --gecos "" $USERNAME

usermod -aG sudo $USERNAME
echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USERNAME

su $USERNAME << 'EOF'
cd /home/$USERNAME
mkdir -p ~/.ssh
chmod 700 ~/.ssh
#cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
PUB_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDkh6wjoTX2rpXoaw7VjUxD8UH4QJfnWo4kfuDw3h2BrCR+AZc4tNnCpwZPlOJ2c6mWl7NnYBdQBD3SVAnWu1UvKcX0LYYnV8u/c2Z/hJw2AnZhEU8qin8HimRxc/hR5sLugDL+W4l35CcWQJpvd54uAycM0RokAif2UVkEpTbow8xtEAL0i/e4OltUHOvNPDbpZdDJ0ghvR+BOnlAmIwKAogEOHFo4zgc7s8Sjg5n9N3QtrzG8eb0cAdlzVzJTWuW9EwEwdm9YEIaTvNYPS/6+4IsC593jcBIqG1y8WToMFcru/Gu6wuYemu5SRuG0100REu81wEGQoCYI1xquhpNggZv/1HXPW8KZWegoWOJ8Wcy4zHyn91xrNxyrt+EWDwmDx08MmHlV6bThyzRoT+trCeuGEalE2L2J+zIeubD62CjV+AmeyJgkb0H+GO9WVxioXhf+34ka36D8Yx4PWsUjVd/UiNm536MXbuebpvPr3SNidCOC43W/DEj/4h2NZhOWhWrTbMwczvtufA3t+AoFzC0OFCKOztC/kYegapzNOQxQjxzlJy8BD3V/bw0YHL4jTKOvpuPJHa/knIGqFGCeUjzz3keioD8nw5totr+SpRCm6F2sEwPAhZdsPWTQ6nh6ngKyJJBR8C/TFWmtgRlcQr17vP12OaPVcw/nqfsETw== fibildar@gmail.com"
echo "$PUB_KEY" >> /home/$USERNAME/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys




# Установка Git
sudo apt update
sudo apt install -y git
sudo apt install -y postgresql

# Установка Docker и Docker Compose
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USERNAME
newgrp docker
#sudo apt install -y docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.10.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
sudo apt install -y bundler

git clone https://bikmaev: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@github.com/bikmaev/minibank-clients.git
cd /home/$USERNAME/minibank-clients
echo "POSTGRES_USER=docker
POSTGRES_PASSWORD=docker
POSTGRES_DB=docker
RAILS_ENV=production
POSTGRES_PORT=5432" > .env.p
docker build -t minibank_nginx_clients  -f Dockerfile.nginx .
docker build -t minibank_postgres_clients  -f Dockerfile.postgres .
docker build -t minibank_clients_p  -f Dockerfile.clients.production .



sudo chown -R postgres:postgres /var/lib/postgresql/data
EOF

