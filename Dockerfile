FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN yarn
COPY . .
RUN yarn build

# 次のFROMが始まったら、前のブロックの終わりを自動で判別する
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# 起動のコマンドは必要ない
