import React, { useEffect } from 'react';
import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';
import Modal from '@mui/material/Modal';
import { Button, MenuItem, Stack, TextField } from '@mui/material';
import { Data } from './tableCell';
import { Category } from './tableCell';
import axios from 'axios';

interface DeviceFormData {
  name: string;
  warranty_years: number;
  min_temperature: number;
  max_temperature: number;
  link: string;
  category_id: number;
  mtbf_hours: number;
}

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

type Props = {state: boolean, adding: boolean; onClose: () => void; id: number; rows: Data[]; categories: Category[]; onSave: () => void;};

const AddDeviceModal: React.FC<Props> = (props) => {
  const { state, adding, onClose, id, rows, categories, onSave } = props;
  const device = rows.find((row) => row.id === id);
  const [open, setOpen] = React.useState(state);
  const [form, setForm] = React.useState<DeviceFormData>({
    name: "",
    warranty_years: 0,
    min_temperature: 0,
    max_temperature: 0,
    mtbf_hours: 0,
    link: "",
    category_id: 0,
  });
  const api = import.meta.env.VITE_API_URL;
  const isFormValid = form.name.trim() !== "" && form.category_id > 0;

  useEffect(() => {
    setOpen(state);
  }, [state]);

  useEffect(() => {
    if (!adding && device) {
      const {
        name,
        warranty_years,
        min_temperature,
        max_temperature,
        link,
        category_id,
        mtbf_hours,
      } = device;

      setForm({
        name,
        warranty_years,
        min_temperature,
        max_temperature,
        link,
        category_id,
        mtbf_hours,
      });
    } else {
      // Очистка формы при добавлении
      setForm({
        name: "",
        warranty_years: 0,
        min_temperature: 0,
        max_temperature: 0,
        mtbf_hours: 0,
        link: "",
        category_id: 0,
      });
    }
  }, [adding, device]);

  const handleChange = (field: keyof DeviceFormData) => (
    event: React.ChangeEvent<HTMLInputElement>
  ) => {
    const value = field === "name" || field === "link"
      ? event.target.value
      : Number(event.target.value);
    setForm((prev) => ({ ...prev, [field]: value }));
  };

  const handleSubmit = () => {
    const payload = {
      name: form.name,
      warranty_years: Number(form.warranty_years),
      min_temperature: Number(form.min_temperature),
      max_temperature: Number(form.max_temperature),
      link: form.link,
      category_id: form.category_id,
      mtbf_hours: Number(form.mtbf_hours),
    };
  
    const method = adding ? axios.post : axios.put;
    const url = adding ? `${api}/equipments/` : `${api}/equipments/${id}`;
  
    method(url, payload)
      .then(() => {
        onClose();
        onSave();
      })
      .catch((error) => {
        console.error("Ошибка при сохранении устройства:", error);
      });
  };

  return (
    <div>
      <Modal
        open={open}
        onClose={onClose}
        aria-labelledby="modal-modal-title"
        aria-describedby="modal-modal-description"
      >
        <Box sx={style}>
          <Typography id="modal-modal-title" variant="h6" component="h2" sx={{ pb: 5 }}>
            {adding ? "Добавить устройство" : "Редактировать устройство"}
          </Typography>
          <TextField fullWidth required label="Наименование" value={form.name} onChange={handleChange("name")} sx={{ pb: 2 }} error={form.name.trim() === ""} helperText={form.name.trim() === "" ? "Обязательное поле" : ""}/>
          <TextField fullWidth label="Гарантийный срок" value={form.warranty_years} onChange={handleChange("warranty_years")} sx={{ pb: 2 }} />
          <TextField fullWidth label="Минимальная рабочая температура" value={form.min_temperature} onChange={handleChange("min_temperature")} sx={{ pb: 2 }} />
          <TextField fullWidth label="Максимальная рабочая температура" value={form.max_temperature} onChange={handleChange("max_temperature")} sx={{ pb: 2 }} />
          <TextField fullWidth label="MTBF" value={form.mtbf_hours} onChange={handleChange("mtbf_hours")} sx={{ pb: 2 }} />
          <TextField fullWidth label="Ссылка" value={form.link} onChange={handleChange("link")} sx={{ pb: 2 }} />
          <TextField
          fullWidth
          select
          required
          label="Категория"
          value={form.category_id}
          onChange={handleChange("category_id")}
          sx={{ pb: 4 }}
          error={form.category_id <= 0}
          helperText={form.category_id <= 0 ? "Обязательное поле" : ""}
          >
            {categories.map((cat) => (
              <MenuItem key={cat.id} value={cat.id}>
                {cat.name}
              </MenuItem>
            ))}
          </TextField>
          <Stack spacing={2} direction="row" sx={{ justifyContent: "flex-end" }}>
            <Button variant="outlined" onClick={onClose}>
              Отмена
            </Button>
            <Button variant="contained" onClick={handleSubmit} disabled={!isFormValid}>{adding ? "Добавить" : "Сохранить"}</Button>
          </Stack>
        </Box>
      </Modal>
    </div>
  );
}

export default AddDeviceModal