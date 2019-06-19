#!/usr/bin/env bash
echo "Creating mongo user for Nuclias Connect database..."
mongo << EOF
use admin;
db.createUser({user:'admin', pwd:'admin', roles:[{role:'root',db:'admin'}]});
db.auth('admin','admin');
db.createRole({role:'sysadmin',privileges:[{resource:{anyResource:true},actions:['anyAction']}],roles:[]});
use CWM2;
db.createUser({user:'286ae6704603a072c8337b10a709a21b', pwd:'d488e2fb7cfee78ff04c36ea1334c7b6', roles:[{role:'dbOwner',db:'CWM2'},{role:'sysadmin',db:'admin'}]});
EOF
echo "Nuclias Connect database user created."


