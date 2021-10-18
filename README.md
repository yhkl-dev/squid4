# squid5
Squid Proxy with ssl bump

### Usage

```
docker run -d -p 3128:3128  -v <configPath>/squid.conf:/etc/squid.conf:ro squid:4.17 
```