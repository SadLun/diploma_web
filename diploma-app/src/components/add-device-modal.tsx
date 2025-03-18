import React, { useEffect } from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Modal from '@mui/material/Modal';
import { TextField } from '@mui/material';


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
          {adding ? <Typography id="modal-modal-title" variant="h6" component="h2">
            Добавить устройство
          </Typography> : <Typography id="modal-modal-title" variant="h6" component="h2">
            Редактировать устройство
          </Typography>}
          <TextField id="outlined-basic" label="Outlined" variant="outlined" />
          <TextField id="outlined-basic" label="Outlined" variant="outlined" />
          <TextField id="outlined-basic" label="Outlined" variant="outlined" />
          <TextField id="outlined-basic" label="Outlined" variant="outlined" />
          <TextField id="outlined-basic" label="Outlined" variant="outlined" />
          <TextField id="outlined-basic" label="Outlined" variant="outlined" />
          <TextField id="outlined-basic" label="Outlined" variant="outlined" />
        </Box>
      </Modal>
    </div>
  );
}

export default AddDeviceModal