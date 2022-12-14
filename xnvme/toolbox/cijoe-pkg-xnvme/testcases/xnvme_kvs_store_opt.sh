#!/bin/bash
#
# Verify that CLI `kvs store` runs without error,
# while used with additional STORE command options
#
# shellcheck disable=SC2119
#
CIJ_TEST_NAME=$(basename "${BASH_SOURCE[0]}")
export CIJ_TEST_NAME
# shellcheck source=modules/cijoe.sh
source "$CIJ_ROOT/modules/cijoe.sh"
test.enter

: "${XNVME_URI:?Must be set and non-empty}"

: "${XNVME_DEV_NSID:?Must be set and non-empty}"
: "${XNVME_BE:?Must be set and non-empty}"
: "${XNVME_ADMIN:?Must be set and non-empty}"
: "${XNVME_SYNC:?Must be set and non-empty}"

# Instrumentation of the xNVMe runtime
XNVME_RT_ARGS=""
XNVME_RT_ARGS="${XNVME_RT_ARGS} --nsid ${XNVME_DEV_NSID}"
XNVME_RT_ARGS="${XNVME_RT_ARGS} --dev-nsid ${XNVME_DEV_NSID}"
XNVME_RT_ARGS="${XNVME_RT_ARGS} --be ${XNVME_BE}"
XNVME_RT_ARGS="${XNVME_RT_ARGS} --admin ${XNVME_ADMIN}"

: "${KV_KEY:="hello"}"
: "${KV_VAL:="world"}"
: "${KV_VAL_NEXT:="xnvme"}"

if ! cij.cmd "kvs delete ${XNVME_URI} ${XNVME_RT_ARGS} --key ${KV_KEY}"; then
  cij.info "kvs delete failed; totally expected, just making sure key ${KV_KEY} didn't exist"
fi

if cij.cmd "kvs store ${XNVME_URI} ${XNVME_RT_ARGS} --key ${KV_KEY} --value ${KV_VAL} --only-update"; then
  test.fail
fi

cij.cmd "kvs store ${XNVME_URI} ${XNVME_RT_ARGS} --key ${KV_KEY} --value ${KV_VAL}";

if ! cij.cmd "kvs store ${XNVME_URI} ${XNVME_RT_ARGS} --key ${KV_KEY} --value ${KV_VAL_NEXT} --only-update"; then
  test.fail
fi

if cij.cmd "kvs store ${XNVME_URI} ${XNVME_RT_ARGS} --key ${KV_KEY} --value ${KV_VAL} --only-add"; then
  test.fail
fi

cij.cmd "kvs delete ${XNVME_URI} ${XNVME_RT_ARGS} --key ${KV_KEY}"

if ! cij.cmd "kvs store ${XNVME_URI} ${XNVME_RT_ARGS} --key ${KV_KEY} --value ${KV_VAL} --only-add"; then
  test.fail
fi

test.pass
