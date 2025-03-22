#!/bin/bash
    echo hello
    sh 'chmod +x build.sh'
    sh './build.sh'
    docker login -u sumithaapvr -p dckr_pat_5mSrlWhvl5iRd7YeNheximdIMDA
    docker tag test1 sumithaapvr/newrepo1
    docker push sumithaapvr/newrepo1
    docker-compose up -d
    
