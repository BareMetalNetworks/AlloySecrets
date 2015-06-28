#!/bin/sh
echo 'Installing apt packages required for AlloySecrets!'
apt-get update

echo 'Installing nodejs instead of using therubyracer gem in the Gemfile'
apt-get install nodejs ruby-mysql2 ruby-mongo && cp mongolian.rb /usr/bin/mongolian && chmod 755 /usr/bin/mongolian
&& echo 'Succesfully installed mongolian document parser to /usr/bin'