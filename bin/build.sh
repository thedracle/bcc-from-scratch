#!/usr/bin/env bash
if docker build .; then
    id=$(docker images | awk '{print $3}' | awk 'NR==2')
    container_id=$(docker create "$id")

    deploy_dir="./deploy"
    mkdir -p "$deploy_dir/bin"
    mkdir -p "$deploy_dir/lib"

    docker cp "$container_id:/lib/ld-musl-x86_64.so.1" "$deploy_dir/lib"
    docker cp "$container_id:/opt/thedracle/ebpfdemo/bin/ebpfdemo" "$deploy_dir/bin"

    docker rm "$container_id"
    docker rmi "$id"
fi


