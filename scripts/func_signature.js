const coder = require('web3-eth-abi');

function signature(name, inputs, prex="0000") {
    const sn = coder.encodeFunctionSignature({
        name,
        type: 'function',
        inputs
    })
    const ok = sn.startsWith(prex) || sn.endsWith(prex)
   
    if (ok) {
        console.log(name, sn)
    }
}


function loop(funcABI) {
    for (let i=0; i<100000; i++) {
        const name = `${funcABI.name}_${i}`
        signature(name, funcABI.inputs)
    }
}

const funcABI = {
    "inputs": [],
    "name": "c",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
}

loop(funcABI)
