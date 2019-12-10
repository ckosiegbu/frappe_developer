FROM python:3.7-slim-buster

RUN useradd -ms /bin/bash frappe
WORKDIR /home/frappe
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    mariadb-client \
    gettext-base \
    wget \
    # for PDF
    libxrender1 \
    libxext6 \
    libjpeg62-turbo \
    fonts-cantarell \
    xfonts-75dpi \
    xfonts-base \
    # Cron
    cron \
    # Cleanup
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Install wkhtmltox correctly
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb
RUN dpkg -i wkhtmltox_0.12.5-1.buster_amd64.deb && rm wkhtmltox_0.12.5-1.buster_amd64.deb

# Install bench
RUN git clone https://github.com/frappe/bench.git .bench \
    && pip3 install -e .bench

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN ln -s /usr/local/bin/docker-entrypoint.sh / # backwards compat

RUN chown -R frappe:frappe /home/frappe
USER frappe

# Install NodeJS
RUN /bin/bash -c "wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash \
    && source ~/.nvm/nvm.sh \
    && nvm install --lts \
    && npm install yarn -g"

# Create first bench
RUN /bin/bash -c "source ~/.nvm/nvm.sh \
    && bench init \
    --frappe-branch develop \
    --python python3 \
    --skip-redis-config-generation \
    frappe-bench"

RUN /bin/bash -c "source ~/.nvm/nvm.sh \
    && cd frappe-bench \
    && bench get-app \
    --branch develop erpnext \
    && sed -i '1,3 s/^/#/' Procfile"

VOLUME [ "/home/frappe/frappe-bench" ]

WORKDIR /home/frappe/frappe-bench

EXPOSE 8000 9000 6787

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["start"]
