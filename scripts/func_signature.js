const coder = require('web3-eth-abi');

function signature(prex, i) {
    const name = `${prex}_${i}`
    const sn = coder.encodeFunctionSignature({
        name,
        type: 'function',
        inputs: [
            { type: 'address' },
            // { type: 'bytes32' },
            { type: 'uint256' },
        ]
    })
    const ii = sn.indexOf('0000') 
    if (ii > 0 && ii % 2 === 0) {
        console.log(i, name, sn)
    }
}

function loop() {
    for (let i=0; i<100000; i++) {
        signature('transfer', i)
    }
}


loop()
