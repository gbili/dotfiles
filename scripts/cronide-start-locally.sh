#!/bin/sh

killall -9 node;

sleep 2s;

cd $ws/node/cronide-server-project;
gnome-terminal -- npm start;

cd $ws/node/cronide-server-user;
gnome-terminal -- npm start;

cd $ws/node/cronide-server-tag;
gnome-terminal -- npm start;

cd $ws/node/graphql-server-gateway;
sleep 5s && npm start;
