import { EthProvider } from "./contexts/EthContext"
import VotingPage from "./components/Voting"

function App() {
  return (
    <EthProvider>
      <div id="App">
        <div className="container">
          <VotingPage />
        </div>
      </div>
    </EthProvider>
  )
}

export default App
