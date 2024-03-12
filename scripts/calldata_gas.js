
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


const inputPv = `0xa9059cbb0000000000000000000000000000000000b3f879cb30fe243b4dfee438691c040000000000000000000000000000000000000000000000056bc75e2d63100000`

run(inputPv)