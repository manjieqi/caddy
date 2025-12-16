# 构建阶段
ARG CADDY_VERSION=latest
FROM caddy:${CADDY_VERSION}-builder AS builder

# 使用 xcaddy 一次性构建包含所有所需插件的 Caddy 二进制
RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/caddy-dns/dnspod \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/fvbommel/caddy-combine-ip-ranges

# 最终运行阶段
FROM caddy:${CADDY_VERSION}

# 从构建阶段复制自定义 Caddy 二进制
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
