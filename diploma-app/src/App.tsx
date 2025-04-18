import { Provider } from 'react-redux'
import store from './store/store'
import { Container, Typography } from '@mui/material'
import Table from './components/tableCell'
import useMiddleClickSearch from './components/middleMouseClick'


function App() {
  useMiddleClickSearch();
  return (
    <Provider store={store}>
      <Container maxWidth="md">
        <Typography component="h1" variant="h2" align="center">Device DataBase</Typography>
        <Table />
      </Container>
    </Provider>
  )
}

export default App
