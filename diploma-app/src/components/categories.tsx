import React, { useEffect, useState } from 'react';
import axios from 'axios';
import {
  Table, TableHead, TableRow, TableCell, TableBody,
  Button, Modal, TextField, Box, Stack, Typography, IconButton, Paper
} from '@mui/material';
import { Add, Edit, Delete } from '@mui/icons-material';
import { Category } from './tableCell';

const style = {
  position: 'absolute' as const,
  top: '50%',
  left: '50%',
  transform: 'translate(-50%, -50%)',
  width: 400,
  bgcolor: 'background.paper',
  boxShadow: 24,
  p: 4,
};

const CategoriesTable: React.FC = () => {
  const [categories, setCategories] = useState<Category[]>([]);
  const [search, setSearch] = useState('');
  const [open, setOpen] = useState(false);
  const [editingCategory, setEditingCategory] = useState<Category | null>(null);
  const [name, setName] = useState('');
  const api = import.meta.env.VITE_API_URL;

  const fetchCategories = () => {
    axios.get<Category[]>(`${api}/categories/?skip=0&limit=100`)
      .then(res => setCategories(res.data))
      .catch(err => console.error('Ошибка при загрузке категорий:', err));
  };

  useEffect(() => {
    fetchCategories();
  }, []);

  const handleOpen = (category?: Category) => {
    if (category) {
      setEditingCategory(category);
      setName(category.name);
    } else {
      setEditingCategory(null);
      setName('');
    }
    setOpen(true);
  };

  const handleClose = () => {
    setOpen(false);
    setName('');
    setEditingCategory(null);
  };

  const handleSave = () => {
    const payload = { name };
    if (editingCategory) {
      axios.put(`${api}/categories/${editingCategory.id}`, payload)
        .then(() => {
          fetchCategories();
          handleClose();
        });
    } else {
      axios.post(`${api}/categories/`, payload)
        .then(() => {
          fetchCategories();
          handleClose();
        });
    }
  };

  const handleDelete = (id: number) => {
    axios.delete(`${api}/categories/${id}`)
      .then(() => fetchCategories());
  };

  const filteredCategories = categories.filter(cat =>
    cat.name.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div>
      <Stack direction="row" justifyContent="space-between" alignItems="center" sx={{ mb: 2, pt: 2 }}>
        <TextField
          label="Поиск"
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          variant="outlined"
          size="small"
          sx={{ width: '400px' }}
        />
        <IconButton color="primary" onClick={() => handleOpen()}>
          <Add />
        </IconButton>
      </Stack>

      <Paper variant="outlined">
        <Table sx={{ borderCollapse: 'separate', borderSpacing: 0 }}>
          <TableHead>
            <TableRow>
              <TableCell sx={{ width: '80%' }}><b>Наименование</b></TableCell>
              <TableCell sx={{ width: '20%', textAlign: 'center' }}><b>Действия</b></TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {filteredCategories.map(cat => (
              <TableRow key={cat.id}>
                <TableCell>{cat.name}</TableCell>
                <TableCell align="center">
                  <IconButton color="primary" onClick={() => handleOpen(cat)}>
                    <Edit fontSize="small" />
                  </IconButton>
                  <IconButton color="error" onClick={() => handleDelete(cat.id)}>
                    <Delete fontSize="small" />
                  </IconButton>
                </TableCell>
              </TableRow>
            ))}
            {filteredCategories.length === 0 && (
              <TableRow>
                <TableCell colSpan={2}>
                  <Typography align="center" variant="body2" color="text.secondary">
                    Категории не найдены
                  </Typography>
                </TableCell>
              </TableRow>
            )}
          </TableBody>
        </Table>
      </Paper>

      <Modal open={open} onClose={handleClose}>
        <Box sx={style}>
          <TextField
            label="Наименование"
            fullWidth
            required
            value={name}
            onChange={(e) => setName(e.target.value)}
            sx={{ mb: 3 }}
          />
          <Stack direction="row" spacing={2} justifyContent="flex-end">
            <Button onClick={handleClose}>Отмена</Button>
            <Button
              variant="contained"
              disabled={!name.trim()}
              onClick={handleSave}
            >
              {editingCategory ? 'Сохранить' : 'Добавить'}
            </Button>
          </Stack>
        </Box>
      </Modal>
    </div>
  );
};

export default CategoriesTable;