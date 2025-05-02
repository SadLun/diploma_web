import React, { useEffect } from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Modal from '@mui/material/Modal';
import { Button, Stack, TextField } from '@mui/material';
import { Data } from './tableCell';

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

type Props = {state: boolean, adding: boolean; onClose: () => void; id: number; rows: Data[]};

const AddDeviceModal: React.FC<Props> = (props) => {
  const [open, setOpen] = React.useState(props.state);
  const [adding, setAdding] = React.useState(props.adding);
  const {rows} = props;
  const localId = props.id;
  const device = rows.find((row) => row.id === localId);


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
          <TextField id="outlined-basic" fullWidth label="Наименование" defaultValue={adding ? "" : device?.name ?? ""} variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth required label="Гарантийный срок" defaultValue={adding ? "" : device?.warranty_years ?? ""} variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth label="Минимальная рабочая температура" defaultValue={adding ? "" : device?.min_temperature ?? ""} variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth label="Максимальная рабочая температура" defaultValue={adding ? "" : device?.max_temperature ?? ""} variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth label="MTBF" defaultValue={adding ? "" : device?.mtbf_hours ?? ""} variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth label="Гамма-процентный ресурс" defaultValue={adding ? "" : device?.gamma_percent_resource ?? ""} variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth label="Срок сохраняемости" defaultValue={adding ? "" : device?.preservation_period ?? ""} variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth label="Коэффициент режима" defaultValue={adding ? "" : device?.mode_coefficient_k ?? ""} variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth label="Ссылка" defaultValue={adding ? "" : device?.link ?? ""} variant="outlined" sx={{pb: 2}}/>
          <TextField id="outlined-basic" fullWidth label="Категория" defaultValue={adding ? "" : device?.category_id ?? ""} variant="outlined" sx={{pb: 4}}/>
          <Stack spacing={2} direction="row" sx={{justifyContent: "flex-end"}}>
            <Button variant="outlined" onClick={props.onClose}>Отмена</Button>
            {adding ? <Button variant="contained">Добавить</Button> : <Button variant="contained">Сохранить</Button>}
          </Stack>
        </Box>
      </Modal>
    </div>
  );
}

export default AddDeviceModal