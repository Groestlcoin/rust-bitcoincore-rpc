# Rust RPC client for Groestlcoin Core JSON-RPC

This is a Rust RPC client library for calling the Groestlcoin Core JSON-RPC API. It provides a layer of abstraction over
[rust-jsonrpc](https://github.com/apoelstra/rust-jsonrpc) and makes it easier to talk to the Groestlcoin JSON-RPC interface

This git package compiles into two crates.
1. [groestlcoincore-rpc](https://crates.io/crates/groestlcoincore-rpc) - contains an implementation of an rpc client that exposes
the Groestlcoin Core JSON-RPC APIs as rust functions.

2. [groestlcoincore-rpc-json](https://crates.io/crates/groestlcoincore-rpc-json) -  contains rust data structures that represent
the json responses from the Groestlcoin Core JSON-RPC APIs. groestlcoincore-rpc depends on this.

# Usage
Given below is an example of how to connect to the Groestlcoin Core JSON-RPC for a Groestlcoin Core node running on `localhost`
and print out the hash of the latest block.

It assumes that the node has password authentication setup, the RPC interface is enabled at port `1441` and the node
is set up to accept RPC connections.

```rust
extern crate groestlcoincore_rpc;

use groestlcoincore_rpc::{Auth, Client, RpcApi};

fn main() {

    let rpc = Client::new("http://localhost:1441".to_string(),
                          Auth::UserPass("<FILL RPC USERNAME>".to_string(),
                                         "<FILL RPC PASSWORD>".to_string())).unwrap();
    let best_block_hash = rpc.get_best_block_hash().unwrap();
    println!("best block hash: {}", best_block_hash);
}
```

See `client/examples/` for more usage examples.

# Supported Groestlcoin Core Versions
The following versions are officially supported and automatically tested:
* 2.18.2
* 2.19.1
* 2.20.1
* 2.21.0

# Minimum Supported Rust Version (MSRV)
This library should always compile with any combination of features on **Rust 1.41**.

Because some dependencies have broken the build in minor/patch releases, to
compile with 1.41.0 you will need to run the following version-pinning command:
```
cargo update --package "cc" --precise "1.0.41"
cargo update --package "log:0.4.x" --precise "0.4.13" # x being the highest patch version, currently 14
cargo update --package "cfg-if" --precise "0.1.9"
cargo update --package "serde_json" --precise "1.0.39"
cargo update --package "serde" --precise "1.0.98"
cargo update --package "serde_derive" --precise "1.0.98"
cargo update --package "byteorder" --precise "1.3.4"
```
