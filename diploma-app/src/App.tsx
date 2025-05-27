import { Provider } from 'react-redux'
import store from './store/store'
import { Container, Typography } from '@mui/material'
import useMiddleClickSearch from './components/middleMouseClick'
import NavTabs from './components/navbar'


function App() {
  useMiddleClickSearch();
  return (
    <Provider store={store}>
      <Container maxWidth="lg">
        <Typography component="h1" variant="h3" align="center">База данных оборудования</Typography>
        <NavTabs />
      </Container>
    </Provider>
  )
}

export default App
