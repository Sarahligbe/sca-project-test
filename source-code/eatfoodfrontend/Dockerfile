FROM node:13.12.0-alpine

WORKDIR /app/frontend

COPY package*.json /app/frontend/

RUN npm install 

RUN npm i -g react-scripts

COPY . /app/frontend/

EXPOSE 3000

CMD [ "npm", "start" ]
