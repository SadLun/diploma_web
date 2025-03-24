import React, { useEffect } from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Modal from '@mui/material/Modal';
import { Button, Stack, TextField } from '@mui/material';


const style = {
    position: 'absolute',
    top: '50%',
    left: '50%',
    transform: 'translate(-50%, -50%)',
    width: 600,
    bgcolor: 'background.paper',
    border: '2px solid #000',
    boxShadow: 24,
    p: 4,
  };

type Props = {state: boolean, adding: boolean; onClose: () => void};

const AddDeviceModal: React.FC<Props> = (props) => {
  const [open, setOpen] = React.useState(props.state);
  const [adding, setAdding] = React.useState(props.adding);

  useEffect(() => {
    setOpen(props.state);
    setAdding(props.adding);
  }, [props.state, props.adding]);

  return (
    <div>
      <Modal
        open={open}
        onClose={props.onClose}
        aria-labelledby="modal-modal-title"
        aria-describedby="modal-modal-description"
      >
        <Box sx={style}>
          {adding ? <Typography id="modal-modal-title" variant="h6" component="h2" sx={{pb: 5}}>
            Добавить устройство
          </Typography> : <Typography id="modal-modal-title" variant="h6" component="h2" sx={{pb: 5}}>
            Редактировать устройство
          </Typography>}
          <TextField id="outlined-basic" fullWidth label="Изображение" variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth required label="Название" variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth label="Вероятность безотказной работы на отрезке времени" variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth label="Средняя наработка до отказа" variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth label="Средняя наработка на отказ" variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth label="Интесивность отказов" variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth label="Среднее время восстановления" variant="outlined" sx={{pb: 4}}/>
          <Stack spacing={2} direction="row" sx={{justifyContent: "flex-end"}}>
            <Button variant="outlined" onClick={props.onClose}>Отмена</Button>
            <Button variant="contained">Добавить</Button>
          </Stack>
        </Box>
      </Modal>
    </div>
  );
}

export default AddDeviceModal