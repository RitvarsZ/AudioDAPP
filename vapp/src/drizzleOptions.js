import Audio from './contracts/Audio.json'

const options = {
  web3: {
    block: false,
    fallback: {
      type: 'ws',
      url: 'ws://127.0.0.1:9545'
    }
  },
  contracts: [Audio],
  events: {
    Audio: ['RecordUpdated', 'RecordRegistered']
  },
  polls: {
    accounts: 15000
  }
}

export default options
