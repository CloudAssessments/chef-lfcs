#!/bin/bash

cd
cp /home/joshlw/LinuxAcademySource/chef-lfcs/openshift.json /home/joshlw/LinuxAcademySource/chef-lfcs/solo.rb /home/joshlw/LinuxAcademySource/testing
cd /home/joshlw/LinuxAcademySource/testing
chef-solo -c solo.rb -j openshift.json
