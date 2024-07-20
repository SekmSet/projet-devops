FROM node:18-alpine as builder

WORKDIR /devops
COPY ./client /devops

RUN npm install -g next@latest sass
RUN npm install
RUN npm run build

FROM node:18-alpine as starter

WORKDIR /devops

RUN npm install -g next@latest

COPY --from=builder /devops/public /devops/public
COPY --from=builder /devops/package.json /devops/package.json
COPY --from=builder /devops/.next /devops/.next
COPY --from=builder /devops/node_modules /devops/node_modules

EXPOSE 3000
ENV PORT 3000

CMD ["next", "start"]