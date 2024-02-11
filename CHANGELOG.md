# 0.18.0

- MSRV changed from 1.41.1 to 1.48.0
- Use `bitcoin::Network` in `GetBlockchainInfoResult `.
- Make checksum optional in `GetDescriptorInfoResult`.
- Make `getmempoolinfo` compatible with supported RPC versions.

# 0.17.0

- add `list_wallet_dir` rpc
- add `join_psbt` rpc
- add `get_raw_change_address` rpc
- add `create_psbt` rpc
- add `combine_raw_transaction` rpc
- add `decode_raw_transaction` rpc
- add `import_descriptors` rpc
- add `get_mempool_info` rpc
- add `get_index_info` rpc
- change return type of `unload_wallet`
- update `jsonrpc` dependency to 0.14.0
- update `bitcoin` dependency to 0.30.0

# 0.16.0

- MSRV changed from 1.29 to 1.41.1
- bump bitcoin crate version to 0.29.0
- moved to Rust edition 2018
- make get_tx_out_set_info compatible with v22+
- add `submit_block`, `submit_block_bytes`, `submit_block_hex`

# 0.15.0

- bump groestlcoin crate version to 0.28.0

# 0.14.0

- Initial release
