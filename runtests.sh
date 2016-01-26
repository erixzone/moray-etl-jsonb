#!/bin/bash

# Script to run tests on library components


DIR=`pwd`
set -e


echo 'Building Manifests'

./lib/lastfm_flat_tojson.js	
cat lastfm_flat.json | json -H > lastfm_flat_.json
mv lastfm_flat_.json lib/lastfm_flat.json
rm -f lastfm_flat.json


echo 'Testing wrap_values.js'
if cat ${DIR}/test/lastfm_subset.json | ./lib/wrap_values.js > lastfm_wrap.json; then
    echo '          [PASS] wrap_values.js'
else
    echo '          [FAIL] wrap_values.js'
fi


echo 'Testing moraydump_reorg.js'
if cat lastfm_wrap.json | ./lib/moraydump_reorg.js -t ${DIR}/lib/lastfm_flat.json -o lastfm; then
    echo '          [PASS] moraydump_reorg.js Test 1 - lastfm'
else
    echo '          [FAIL] moraydump_reorg.js Test 1 - lastfm'
fi
   
echo 'Testing json2pgtypes.js'
if cat lastfm_flat_m.json | ./lib/json2pgtypes.js -o lastfm_flat_m_types; then
    echo '          [PASS] json2pgtypes.js Test 1'
else
    echo '          [FAIL] json2pgtypes.js Test 1'
fi

if diff -q lastfm_flat_m_types.sql test/lastfm_types.sql > /dev/null; then
    echo '          [PASS] json2pgtypes.js Test 2'
else
    echo '          [FAIL] json2pgtypes.js Test 2'
fi

cat test/test_json2pgtypes_array.json | ./lib/json2pgtypes.js -o test_4 &>/dev/null
if diff -q test_4.sql test/json2pgtypes_test2.sql > /dev/null; then
    echo '          [PASS] json2pgtypes.js Test 3'
else
    echo '          [FAIL] json2pgtypes.js Test 3'
fi


echo 'Testing json_tsv.js'
if cat lastfm_flat_m.json | ./lib/json_tsv.js -i ${DIR}/lastfm_flat_m_types.json > lastfm_flat_m.tsv; then
    echo '          [PASS] json_tsv.js Test 1 lastfm'
else
    echo '          [FAIL] json_tsv.js Test 1 lastfm'
fi


echo 'Testing pgtypes_reduce.js'
if cat ${DIR}/test/test_pgtypes_reduce.json | ./lib/pgtypes_reduce.js -o test_1; then
    echo '          [PASS] pgtypes_reduce.js Test 1'
else
    echo '          [FAIL] pgtypes_reduce.js Test 1'
fi


if diff -q test_1.json test/pgtypes_reduce_out.json > /dev/null; then
    echo '          [PASS] pgtypes_reduce.js Test 2'
else
    echo '          [FAIL] pgtypes_reduce.js Test 2'
fi


# echo 'Copying examples to jsonbQdemo'
rm -f test_*
# mv *.tsv jsonbQdemo/
# mv *.sql jsonbQdemo/
rm -f lastfm_*
