#!/bin/sh
tar -czf backup.tar.gz $1
cp --backup=numbered backup.tar.gz $2
rm backup.tar.gz
