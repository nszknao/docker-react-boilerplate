FROM node:alpine
WORKDIR '/app'
COPY package*.json ./
RUN yarn
COPY . .
RUN yarn build

# 次のFROMが始まったら、前のブロックの終わりを自動で判別する
FROM nginx
# Elastic BeanstalkはExposeしたポートを自動でマッピングしてくれる
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html
# 起動のコマンドは必要ない
