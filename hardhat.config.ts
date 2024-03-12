import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.24",
};

export default config;

// module.exports = {
//   defaultNetwork: "sepolia",
//   networks: {
//     hardhat: {
//     },
//     sepolia: {
//       url: "https://sepolia.infura.io/v3/<key>",
//       accounts: [privateKey1, privateKey2, ...]
//     }
//   },
//   solidity: {
//     version: "0.8.24",
//     settings: {
//       optimizer: {
//         enabled: true,
//         runs: 200
//       }
//     }
//   },
//   paths: {
//     sources: "./contracts",
//     tests: "./test",
//     cache: "./cache",
//     artifacts: "./artifacts"
//   },
//   mocha: {
//     timeout: 40000
//   }
// }