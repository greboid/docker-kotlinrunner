#!/bin/sh
gradle jar
exec "$@"
