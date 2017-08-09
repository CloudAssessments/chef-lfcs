#!/bin/bash

cd
cp ~/chef-lfcs/aws.json ~/chef-lfcs/solo.rb /
cd /
chef-solo -c solo.rb -j aws.json
