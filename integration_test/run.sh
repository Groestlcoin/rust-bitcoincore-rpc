#!/bin/sh

TESTDIR=/tmp/rust_groestlcoincore_rpc_test

rm -rf ${TESTDIR}
mkdir -p ${TESTDIR}/1 ${TESTDIR}/2

# To kill any remaining open groestlcoind.
killall -9 groestlcoind

groestlcoind -regtest \
    -datadir=${TESTDIR}/1 \
    -port=12348 \
    -server=0 \
    -printtoconsole=0 &
PID1=$!

# Make sure it's listening on its p2p port.
sleep 3

BLOCKFILTERARG=""
if groestlcoind -version | grep -q "v2\.\(19\|2\)"; then
    BLOCKFILTERARG="-blockfilterindex=1"
fi

FALLBACKFEEARG=""
if groestlcoind -version | grep -q "v2\.2"; then
    FALLBACKFEEARG="-fallbackfee=0.00001000"
fi

groestlcoind -regtest $BLOCKFILTERARG $FALLBACKFEEARG \
    -datadir=${TESTDIR}/2 \
    -connect=127.0.0.1:12348 \
    -rpcport=12349 \
    -server=1 \
    -txindex=1 \
    -printtoconsole=0 &
PID2=$!

# Let it connect to the other node.
sleep 5

RPC_URL=http://localhost:12349 \
    RPC_COOKIE=${TESTDIR}/2/regtest/.cookie \
    TESTDIR=${TESTDIR} \
    cargo run

RESULT=$?

kill -9 $PID1 $PID2

exit $RESULT
