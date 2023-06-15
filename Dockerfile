# 使用官方的 Dart 镜像作为基础镜像
FROM google/dart
# FROM cirrusci/flutter

RUN apt -y update && apt -y upgrade
RUN apt -y install nginx

# 设置工作目录
WORKDIR /app

# 拷贝你的 Dart 代码到容器中
COPY . /app

COPY nginx.conf /etc/nginx/nginx.conf
# RUN cd && cd /usr/sbin && ./nginx

# 获取依赖并构建应用
RUN dart pub get

# ENV PORT 8080
EXPOSE 8080

# 运行应用
# CMD ["dart", "main.dart"]
CMD ["sh","/app/start_project.sh"]
