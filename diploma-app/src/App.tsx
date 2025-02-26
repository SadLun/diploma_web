import { Provider } from 'react-redux'
import store from './store/store'
import { Container, Typography } from '@mui/material'
import TableCell from './components/tableCell'


function App() {

  return (
    <Provider store={store}>
      <Container maxWidth="md">
        <Typography component="h1" variant="h2" align="center">Device DataBase</Typography>
        <TableCell />
      </Container>
    </Provider>
  )
}

export default App
