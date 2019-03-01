#!/bin/bash
set -o pipefail

function ok()
{
	echo "  OK"
}

function fail()
{
	echo "  FAIL"
	exit 1
}

echo "Checking whether all services are running..."
services=`sv status /etc/service/*`
sv status /etc/service/*
status=$?
if [[ "$status" != 0 || "$services" = "" || "$services" =~ down ]]; then
	fail
else
	ok
fi

echo "Checking Golang is installed and has the proper version..."
golang=$(go version  | awk '{ print $3 }' | cut -d 'p' -f 1)

if [[ $golang == $1 ]]; then
	ok
else
	echo "Wrong version of Golang installed! ${golang}"
	fail
fi

echo "Testing go run..."
cat > test.go <<EOF
package main
import "fmt"
func main() {
	fmt.Printf("Working")
}
EOF
chmod +x test.go
test=$(go run test.go)
if [[ $test == "Working" ]]; then 
	ok
else
  echo "Failed go run test"
	fail
fi
