HTTP
====

## Basics


HTTP is the protocol used to fetch data from web servers. It is a very simple
protocol that is built upon TCP/IP. The protocol also allows information to get
sent to the server from the client using a few different methods, as will be
shown here.

HTTP is plain ASCII text lines being sent by the client to a server to request a
particular action, and then the server replies a few text lines before the
actual requested content is sent to the client.

The client, curl, sends a HTTP request. The request contains a method (like GET,
POST, HEAD etc), a number of request headers and sometimes a request body. The
HTTP server responds with a status line (indicating if things went well),
response headers and most often also a response body. The "body" part is the
plain data you requested, like the actual HTML or the image etc.

To see the protocol, with time tracing:

```
curl --trace-ascii dump.txt --trace-time http://example.com/
```

See below the possible codes HTTPs requests can answer you:

![](http-headers-status-v3.png)


## Advanced

* https://curl.haxx.se/docs/httpscripting.html#The_HTTP_Protocol
