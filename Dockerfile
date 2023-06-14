# 使用官方的 Dart 镜像作为基础镜像
# FROM google/dart
FROM cirrusci/flutter

# 设置工作目录
WORKDIR /app

# 拷贝你的 Dart 代码到容器中
COPY . /app

# 获取依赖并构建应用
RUN dart pub get

ENV PORT 80
EXPOSE 80

# 运行应用
CMD ["dart", "main.dart"]
