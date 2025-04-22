import { Provider } from 'react-redux'
import store from './store/store'
import { Container, Typography } from '@mui/material'
import useMiddleClickSearch from './components/middleMouseClick'
import NavTabs from './components/navbar'


function App() {
  useMiddleClickSearch();
  return (
    <Provider store={store}>
      <Container maxWidth="md">
        <Typography component="h1" variant="h2" align="center">Device DataBase</Typography>
        <NavTabs />
      </Container>
    </Provider>
  )
}

export default App
