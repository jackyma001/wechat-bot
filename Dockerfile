FROM node:lts-alpine
ENV OPENAI_API_KEY=$OPENAI_API_KEY
RUN mkdir -p /app
WORKDIR /app

COPY package.json ./
RUN npm i

COPY *.js ./
COPY src/ ./src/
COPY .env ./

CMD ["npm", "run", "dev"]
