import { Provider } from 'react-redux'
import store from './store/store'


function App() {

  return (
    <Provider store={store}>
      <div>aha</div>
    </Provider>
  )
}

export default App
