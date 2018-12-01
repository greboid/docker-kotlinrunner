#!/bin/bash
gradle jar
exec "$@"
