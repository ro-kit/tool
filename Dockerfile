FROM golang

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs

RUN apt-get update && \
    apt-get install -y php-cli && \
    rm -rf /var/lib/apt/lists/*

RUN curl --silent -o /bin/json-cli -L https://github.com/swaggest/json-cli/releases/download/v1.6.5/json-cli && chmod +x /bin/json-cli && \
    json-cli --version && \
    curl --silent -o /bin/swac -L https://github.com/swaggest/swac/releases/download/v0.1.7/swac && chmod +x /bin/swac && \
    swac --version && \
    curl --silent -o /bin/swagger -L https://github.com/go-swagger/go-swagger/releases/download/v0.21.0/swagger_linux_amd64 && chmod +x /bin/swagger && \
    swagger version

RUN npm install -g oas-raml-converter && npm install -g swagger-markdown && npm install -g asyncapi-generator

# oas-raml-converter doesn't work on linux, because of this issue in binary declaration.
# This hack should be redundant if https://github.com/mulesoft/oas-raml-converter/issues/33 is resolved.
RUN sed -i.bak 's/#!\/usr\/bin\/env node --harmony/#!\/usr\/bin\/node --harmony/' /usr/lib/node_modules/oas-raml-converter/lib/bin/converter.js
