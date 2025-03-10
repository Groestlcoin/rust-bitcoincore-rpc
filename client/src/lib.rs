// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to
// the public domain worldwide. This software is distributed without
// any warranty.
//
// You should have received a copy of the CC0 Public Domain Dedication
// along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
//

//! # Rust Client for Groestlcoin Core API
//!
//! This is a client library for the Groestlcoin Core JSON-RPC API.
//!

#![crate_name = "groestlcoincore_rpc"]
#![crate_type = "rlib"]

#[macro_use]
extern crate log;
#[allow(unused)]
#[macro_use] // `macro_use` is needed for v1.24.0 compilation.
extern crate serde;

pub extern crate jsonrpc;

pub extern crate groestlcoincore_rpc_json;
pub use crate::json::groestlcoin;
pub use groestlcoincore_rpc_json as json;
use json::groestlcoin::consensus::{Decodable, ReadExt};
use json::groestlcoin::hex::HexToBytesIter;

mod client;
mod error;
mod queryable;

pub use crate::client::*;
pub use crate::error::Error;
pub use crate::queryable::*;

fn deserialize_hex<T: Decodable>(hex: &str) -> Result<T> {
    let mut reader = HexToBytesIter::new(&hex)?;
    let object = Decodable::consensus_decode(&mut reader)?;
    if reader.read_u8().is_ok() {
        Err(Error::BitcoinSerialization(groestlcoin::consensus::encode::Error::ParseFailed(
            "data not consumed entirely when explicitly deserializing",
        )))
    } else {
        Ok(object)
    }
}
