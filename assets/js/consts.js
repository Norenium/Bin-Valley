// DevOps:	https://www.techtarget.com/searchitoperations/tip/How-to-start-DevOps-A-step-by-step-guide
// const contractAddress = "0x954D9595fC559550A3d86451d8e23b109b44798A";
/*
FYI
My account address:  	0x87B64804e36f20acA9052D3b4Cd7188D41b59f97
Lands:
		STORAGE:	0x99dB35A2786040D80B9cf5EFF76594F13d65B3F2	
		AGENT:	0x01F77C8d321f445d652F0077E19dA7148a29C72a
Token:
		STORAGE:	0x6EaeB295547907308151ECffBBc3F45d8a0B0D60 => 0x5264f074830A1F74F896ec9Fa5069556bd2d4266
		AGENT:	0x86190E6Fa2055FB053AB73a740E02f45EdC71692
main:
		Logic:	0x72ed709B92dB0039f987fb5f6b4d384055F81167
		Proxy:	0x2C2a7Af491Ca58cEFD9069B4aD6270fe1B30682F


Logic.(constructor)


*/
const contractAddress = "0x2C2a7Af491Ca58cEFD9069B4aD6270fe1B30682F"; 


var ABI = [
	{
		"inputs": [],
		"stateMutability": "nonpayable",
		"type": "constructor"
	},
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": true,
				"internalType": "address",
				"name": "from",
				"type": "address"
			},
			{
				"indexed": true,
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "Transfer",
		"type": "event"
	},
	{
		"inputs": [],
		"name": "_paused",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "command",
				"type": "uint256"
			},
			{
				"internalType": "address[]",
				"name": "_addressData",
				"type": "address[]"
			},
			{
				"internalType": "string[]",
				"name": "_stringData",
				"type": "string[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_uint256Data",
				"type": "uint256[]"
			}
		],
		"name": "alphaCall",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "account",
				"type": "address"
			}
		],
		"name": "balanceOf",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address[]",
				"name": "to",
				"type": "address[]"
			},
			{
				"internalType": "uint256[]",
				"name": "value",
				"type": "uint256[]"
			}
		],
		"name": "batchTransfer",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "command",
				"type": "uint256"
			},
			{
				"internalType": "address[]",
				"name": "_addressData",
				"type": "address[]"
			},
			{
				"internalType": "string[]",
				"name": "_stringData",
				"type": "string[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_uint256Data",
				"type": "uint256[]"
			}
		],
		"name": "bravoCall",
		"outputs": [
			{
				"internalType": "string[]",
				"name": "",
				"type": "string[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "command",
				"type": "uint256"
			},
			{
				"internalType": "address[]",
				"name": "_addressData",
				"type": "address[]"
			},
			{
				"internalType": "string[]",
				"name": "_stringData",
				"type": "string[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_uint256Data",
				"type": "uint256[]"
			}
		],
		"name": "charlieCall",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "decimals",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "command",
				"type": "uint256"
			},
			{
				"internalType": "address[]",
				"name": "_addressData",
				"type": "address[]"
			},
			{
				"internalType": "string[]",
				"name": "_stringData",
				"type": "string[]"
			},
			{
				"internalType": "uint256[]",
				"name": "_uint256Data",
				"type": "uint256[]"
			}
		],
		"name": "deltaCall",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "faucet",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getLatestAddressValue",
		"outputs": [
			{
				"internalType": "address[]",
				"name": "",
				"type": "address[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getLatestStringValue",
		"outputs": [
			{
				"internalType": "string[]",
				"name": "",
				"type": "string[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getLatestUint256Value",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "",
				"type": "uint256[]"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getLogicAddress",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getMyBalance",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getSecretary",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "getSelfAddress",
		"outputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "name",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "string[]",
				"name": "strings",
				"type": "string[]"
			}
		],
		"name": "setLatestStringValue",
		"outputs": [
			{
				"internalType": "string[]",
				"name": "",
				"type": "string[]"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256[]",
				"name": "uints",
				"type": "uint256[]"
			}
		],
		"name": "setLatestUint256Value",
		"outputs": [
			{
				"internalType": "uint256[]",
				"name": "",
				"type": "uint256[]"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "adr",
				"type": "address"
			}
		],
		"name": "setLogicAddress",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "setLogicsProxyAddress",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "adr",
				"type": "address"
			}
		],
		"name": "setSecretary",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "symbol",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "totalSupply",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "transfer",
		"outputs": [
			{
				"internalType": "bool",
				"name": "",
				"type": "bool"
			}
		],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "to",
				"type": "address"
			},
			{
				"internalType": "uint256",
				"name": "value",
				"type": "uint256"
			}
		],
		"name": "transferFast",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	}
]