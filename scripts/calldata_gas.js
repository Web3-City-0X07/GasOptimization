
function run(inputdata) {
    try {
        let zeroCount = 0
        let noZeroCount = 0
        let gasCost = 0
        for (let i=2; i < inputdata.length; i += 2) {
            const byte = inputdata.substring(i, i+2)
            // console.log(bit)
            if (byte === '00') {
                zeroCount += 1
                gasCost += 4
            } else {
                gasCost += 16
                noZeroCount += 1
            }
        }
        console.log(`input_data_gas_cost ${gasCost} = 4 * ${zeroCount}(zero byte) + 16 * ${noZeroCount}`)
        console.log(`init_gas_cost ${21000 + gasCost} = 21000 + ${gasCost}`)
    } catch (e) {
        console.error(e)
    }

}


const calldata = `608060405260043610601b575f3560e01c8063371303c014601f575b5f80fd5b60256027565b005b5f8081546032906071565b91905081905550565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f819050919050565b5f6079826068565b91507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff820360a85760a7603b565b5b60018201905091905056fea26469706673582212202382425d7d625c78e313018661a2b7a139861b6ce25c8bad2daf596e2abd0bd964736f6c63430008180033`

run(calldata)