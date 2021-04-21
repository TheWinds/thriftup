version=$1

versions=("0.9","0.9.3","0.10","0.10.0","0.11","0.11.0","0.12","0.12.0","latest")

if [ -z "$version" ]; then 
    version="latest"
fi

if [[ "${versions[@]}"  =~ "$version" ]]; then
    echo "Install thrift version: $version"
else
    echo "Thrift version not available: version=$version: available version $versions"
    exit 1
fi

echo "Pull docker image: thrift:$version"
docker pull "thrift:$version"

echo "Write proxy command file to /usr/local/bin/thrift"

proxy_file="docker run --rm -v \"\$PWD:\$PWD\" -w \$PWD -u \`id -u\` thrift:$version thrift \"\$@\""

sudo echo "$proxy_file" > "/usr/local/bin/thrift"

sudo chmod +x "/usr/local/bin/thrift"

echo "Done"

thrift --version