#!/bin/bash

echo "Starting project";
cd $ws/node/cronide-server-project;
npm start;

echo "Starting user";
cd $ws/node/cronide-server-user;
npm start;

echo "Starting tag";
cd $ws/node/cronide-server-tag;
npm start;

echo "Starting gateway";
cd $ws/graphql-server-gateway;
npm start;
