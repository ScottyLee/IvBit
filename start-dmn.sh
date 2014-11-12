#!/bin/sh
exec erl \
	-detached \
    -pa ebin deps/*/ebin \
    -boot start_sasl \
    -sname short_url_dev \
    -s short_url \
    -s reloader