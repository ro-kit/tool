FROM golang

RUN curl -sL https://deb.nodesource.com/setup_13.x | bash - && \
    apt-get update && \
    apt-get install -y php-cli nodejs && \
    rm -rf /var/lib/apt/lists/* && \
    npm install -g oas-raml-converter && sed -i.bak 's/#!\/usr\/bin\/env node --harmony/#!\/usr\/bin\/node --harmony/' /usr/lib/node_modules/oas-raml-converter/lib/bin/converter.js && \
    npm install -g swagger-markdown && \
    npm install -g asyncapi-generator && \
    npm install -g openapi3-generator --unsafe-perm=true --allow-root && \
    curl --silent -o /bin/swagger -L https://github.com/go-swagger/go-swagger/releases/download/v0.25.0/swagger_linux_amd64 && chmod +x /bin/swagger && \
    swagger version

RUN curl --silent -o /bin/json-cli -L https://github.com/swaggest/json-cli/releases/download/v1.7.10/json-cli && chmod +x /bin/json-cli && \
    json-cli --version && \
    curl --silent -o /bin/swac -L https://github.com/swaggest/swac/releases/download/v0.1.16/swac && chmod +x /bin/swac && \
    swac --version

