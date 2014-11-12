import httplib
httpServ = httplib.HTTPConnection("127.0.0.1", 8080)
httpServ.connect()
text = "http://www.abc.net.au/radio/player/beta/#live/doublej"
httpServ.request('POST', '/reduce', text)
response = httpServ.getresponse()
print response.read()
httpServ.close()