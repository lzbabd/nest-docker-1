# 选择一个体积小的镜像 (~5MB)
FROM node:14-alpine as builder

# 环境变量设置为生产环境
ENV NODE_ENV production

# 更好的根据 Image Layer 利用缓存
ADD package.json pnpm-lock.yaml ./
RUN npm i -g pnpm
RUN pnpm install


# 多阶段构建之第二阶段
FROM node:14-alpine

WORKDIR /code
ENV NODE_ENV production

ADD . .
COPY --from=builder node_modules node_modules

EXPOSE 3000
CMD pnpm start:prod
