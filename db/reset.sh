#!/bin/bash
DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
$DIR/godmode.sh remove && $DIR/godmode.sh create && $DIR/godmode.sh seed
