import { useState } from "react"
import { useEth } from "../contexts/EthContext"

const VotingPage = () => {
  const {
    state: { accounts, contract },
  } = useEth()

  const [aValue, setAValue] = useState("")
  const [bValue, setBValue] = useState("")

  // Getter
  const readAValue = async () => {
    const value = await contract.methods.candidateA().call()
    setAValue(value)
  }
  const readBValue = async () => {
    const value = await contract.methods.candidateB().call()
    setBValue(value)
  }

  // Setter
  const voteA = async () => {
    await contract.methods.voteA().send({ from: accounts[0] })
    readAValue()
  }

  const voteB = async () => {
    await contract.methods.voteB().send({ from: accounts[0] })
    readBValue()
  }

  return (
    <div className="display">
      <h1>Vote for Your Ideal Candidate Now!</h1>
      <div>
        <span>Candidate A: {aValue}</span>
        <span>Candidate B: {bValue}</span>
      </div>
      <div>
        <button onClick={voteA}>Vote A</button>
        <button onClick={voteB}>Vote B</button>
      </div>
    </div>
  )
}

export default VotingPage
