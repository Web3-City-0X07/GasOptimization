const fs = require('fs')

// 把合约中的方法选择的相关字节码提取出来
function run() {
    try {
        // 080604052 3560e01c 575b5f
        let raw = fs.readFileSync('./scripts/code_bytes.txt')
        let start = raw.indexOf('3560e01c')
        if (start) {
            raw = String(raw).substring(start + 8)
        }
        let end = raw.indexOf('575b5f')
        if (end) {
            raw = String(raw).substring(0, end + 6)
        }
        
        if (process.env.MODE='lines') {
            console.log('3560e01c')
            let i = 10
            while (i > 0) {
                i = raw.indexOf('57')
                if (i <= 0) { break }
                const line = raw.substring(0, i+2)
                console.log(line)
                raw = raw.substring(i+2)
            }
            console.log(raw)
        } else {
            console.log(raw)
        }
        return raw
    } catch (e) {
        console.error(e)
    }

}


run()