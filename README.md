# xSystems - Blockbook

> Blockbook image build from the [Blockbook source code][blockbook]


## Run

All available environment variables are:

| Environment Variable | Example Value | Required | Description                                        |
| :------------------- | :------------ | :------: | :------------------------------------------------- |
| BITCOIN_HOST         | bitcoin       |     ✔    | Hostname of a `bitcoind` service                   |
| BITCOIN_PORT_RPC     | 8030          |     ✔    | [RPC][bitcoind-rpc] port of the `bitcoind` service |
| BITCOIN_PORT_ZMQ     | 38330         |     ✔    | [ZMQ][bitcoind-zmq] port of the `bitcoind` service |

Expose port `9130` to make the Bitcoin Explorer and REST API available outside the Docker network


### Docker CLI example

```sh
docker run --rm --interactive --tty --publish 9130:9130 --env BITCOIN_HOST=bitcoin --env BITCOIN_PORT_RPC=8030 --env BITCOIN_PORT_ZMQ=38330 xsystems/blockbook:v0.3.4
```


## Build the Image

Optionally change the variable `DOCKER_TAG` in [build.sh](build.sh) and run that script to build an image of the [Blockbook codebase state with tag][blockbook-tags] indicated by `DOCKER_TAG`.


## Release the Image

1. Set the `VERSION` environment variable to the version that needs to be released.
2. Optionally, set the `COMMIT` environment variable to the hash of the Git commit that needs to be released. It defaults to the latest commit.
3. Run [release.sh](release.sh).

Example release statement:

```sh
VERSION=v0.3.4 ./release.sh
```

[blockbook]: https://github.com/trezor/blockbook "Blockbook"
[blockbook-tags]: https://github.com/trezor/blockbook/tags "Blockbook Tags"
[bitcoind-rpc]: https://github.com/bitcoin/bitcoin/blob/master/doc/JSON-RPC-interface.md "bitcoind RPC"
[bitcoind-zmq]: https://github.com/bitcoin/bitcoin/blob/master/doc/zmq.md "bitcoind ZMQ"