#!/bin/bash

# Copyright 2017 Google Inc. All rights reserved.

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


#Structure test tests. The tests to test the structure tests.

#End to end tests to make sure the structure tests do what we expect them
#to do on a known quantity, the latest debian docker image.

failures=0
# build newest structure test binary
go test -c .. -o structure-test

# Run the debian tests, they should always pass on latest
res=$(./structure-test -image gcr.io/google-appengine/debian8 debian_test.yaml)
code=$?

if [[ ("$res" != "PASS" || "$code" != "0") ]];
then
  echo "Success case test failed"
  echo "$res"
  failures=$((failures +1))
fi

# Run some bogus tests, they should fail as expected
res=$(./structure-test -image gcr.io/google-appengine/debian8 debian_failure_test.yaml)
code=$?

if ! [[ ("$res" =~ FAIL$ && "$code" == "1") ]];
then
  echo "Failure case test failed"
  echo "$res"
  failures=$((failures +1))
fi

echo "Failure Count: $failures"
if [ "$failures" -gt "0" ]
then
  exit 1
fi
