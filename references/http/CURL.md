Curl
====


### Options

```
-o <file>    # --output: write to file
-u user:pass # --user: Authentication
-v           # --verbose
-vv          # Even more verbose
-I           # --head: headers only
```


### Request

```
-X POST          # --request
```


### Data

```
-d 'data'    # --data: HTTP post data, URL encoded (eg, status="Hello")
-d @file     # --data via file
-G           # --get: send -d data via get
```

### Headers

```
-A <str>         # --user-agent
-b name=val      # --cookie
-b FILE          # --cookie
-H "X-Foo: y"    # --header
--compressed     # use deflate/gzip
```

### SSL

```
   --cacert <file>
   --capath <dir>
   -E, --ecrt <cert>     # --ecrt: Client cert file
   --cert-type       # der/pem/eng
   -k, --insecure        # for self-signed certs
```

### Examples

```
# Post data:
curl -d password=x http://x.com/y

# Auth/data:
curl -u user:pass -d status="Hello" http://twitter.com/statuses/update.xml

# multipart file upload
curl -v -include --form key1=value1 --form upload=@localfilename URL

# save output to a file
curl -o mygettext.html http://www.gnu.org/software/gettext/manual/gettext.html

# upload file to a ftp server
curl -u ftpuser:ftppass -T myfile.txt ftp://ftp.testserver.com

# get HTTP header
curl -I http://domain.com

```


## Advanced

* https://www.thegeekstuff.com/2012/04/curl-examples/
* https://curl.haxx.se/docs/httpscripting.html
