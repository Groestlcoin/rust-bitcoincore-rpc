
set -xe

# Just echo all the relevant env vars to help debug Github Actions.
echo "RUSTFMTCHECK: \"$RUSTFMTCHECK\""
echo "GROESTLCOINVERSION: \"$GROESTLCOINVERSION\""
echo "PATH: \"$PATH\""

if [ -n "$RUSTFMTCHECK" ]; then
  rustup component add rustfmt
  cargo fmt --all -- --check
fi

# Integration test.
if [ -n "$GROESTLCOINVERSION" ]; then
    wget https://github.com/Groestlcoin/groestlcoin/releases/download/v$GROESTLCOINVERSION/groestlcoin-$GROESTLCOINVERSION-x86_64-linux-gnu.tar.gz
    tar -xzvf groestlcoin-$GROESTLCOINVERSION-x86_64-linux-gnu.tar.gz
    export PATH=$PATH:$(pwd)/groestlcoin-$GROESTLCOINVERSION/bin
    cd integration_test
    ./run.sh
    exit 0
else
  # Regular build/unit test.
  cargo build --verbose
  cargo test --verbose
  cargo build --verbose --examples
fi
