# squid 4.17 Docker image
Squid Proxy with ssl bump

### Usage

```bash
docker run -d -p 3128:3128  -v <configPath>/squid.conf:/etc/squid.conf:ro squid:4.17 
```