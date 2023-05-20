FROM node:13.12.0-alpine

WORKDIR /app/frontend

COPY package*.json /app/frontend/

RUN npm install 

RUN npm i -g react-scripts@3.4.1

COPY . /app/frontend/

EXPOSE 3000

CMD [ "npm", "start" ]
