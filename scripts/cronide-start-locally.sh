#!/bin/bash

echo -e "Starting project";
cd $ws/node/cronide-server-project;
npm start;

echo -e "Starting user";
cd $ws/node/cronide-server-user;
npm start;

echo -e "Starting tag";
cd $ws/node/cronide-server-tag;
npm start;

echo -e "Starting gateway";
cd $ws/graphql-server-gateway;
npm start;
