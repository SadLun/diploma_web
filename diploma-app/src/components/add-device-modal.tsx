import React, { useEffect } from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Modal from '@mui/material/Modal';


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

  useEffect(() => {
    setOpen(props.state);
  }, [props.state]);

  return (
    <div>
      <Modal
        open={open}
        onClose={props.onClose}
        aria-labelledby="modal-modal-title"
        aria-describedby="modal-modal-description"
      >
        <Box sx={style}>
          {props.adding ? <Typography id="modal-modal-title" variant="h6" component="h2">
            Добавить устройство
          </Typography> : <Typography id="modal-modal-title" variant="h6" component="h2">
            Редактировать устройство
          </Typography>}
          <Typography id="modal-modal-description" sx={{ mt: 2 }}>
            Duis mollis, est non commodo luctus, nisi erat porttitor ligula.
          </Typography>
        </Box>
      </Modal>
    </div>
  );
}

export default AddDeviceModal