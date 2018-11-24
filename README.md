# ExLndclient

**This is work in progress. It is functional but I would be careful using it in production. If you want to help, please drop me a message. Any help is greatly appreciated!**

This is a gRPC client for [lnd](https://github.com/lightningnetwork/lnd) (0.5-beta). It is generated code from [rpc.proto](https://github.com/lightningnetwork/lnd/blob/v0.5-beta/lnrpc/rpc.proto)



## Usage

1. Install deps and compile
```shell
$ mix do deps.get, compile, escript.build
```
2. set the macaroon.txt and tls.cert and get the hostname
3. start the script
```
$ ./ex_lndclient --macaroonpath=macaroon.txt --tlscertpath=tls.cert --rpcserver=127.0.0.1:10009
```

## Installation

You need the elixir implementation of [gRPC](https://github.com/tony612/grpc-elixir)

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_lndclient` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_lndclient, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_lndclient](https://hexdocs.pm/ex_lndclient).

## Lightning network

1. Convert the macaroon to txt format
```shell
$ xxd -p -c2000 admin.macaroon > macaroon.txt
```
2. And get the tls.cert
3. Copy the files

## Generate Elixir code from proto
1. Install `priv/protos/lndrpc/rpc.proto` [here](https://github.com/lightningnetwork/lnd/blob/master/lnrpc/rpc.proto)
2. Get `priv/protos/google/api/http.proto`
and `priv/protos/google/api/annotations.proto` [here](https://github.com/googleapis/googleapis.git)
3. Install `protoc` [here](https://developers.google.com/protocol-buffers/docs/downloads)
4. Install `protoc-gen-elixir`
```
mix escript.install hex protobuf
```
4. Generate the code:
```shell
$ protoc -I priv/protos --elixir_out=plugins=grpc:./lib/ priv/protos/lnrpc/rpc.proto
```

Refer to [protobuf-elixir](https://github.com/tony612/protobuf-elixir#usage) for more information.
And https://github.com/lightningnetwork/lnd/tree/master/docs/grpc for lightningnetwork grpc lnd

## Roadmap
- [X] Connect to a lightning network server via gRPC
- [ ] Subscribe to transaction stream
- [ ] Command line version
- [ ] Elixir module for reuse
- [ ] Add support for macaroon to the grpc library
## License

1. ex_lndclient Copyright (c) 2018 David Rasch Licensed under the MIT License
2. Google Protos Licensed under the Apache 2.0 License
3. lnrpc Lightningnetwork Protos Licensed under the MIT License
