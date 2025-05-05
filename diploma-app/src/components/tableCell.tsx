import { Autocomplete, Box, Button, Checkbox, Chip, IconButton, Paper, Table, TableBody, TableCell, TableContainer, TableHead, TablePagination, TableRow, TableSortLabel, TextField, Toolbar, Tooltip, Typography } from '@mui/material';
import React, { useEffect } from 'react';
import { visuallyHidden } from '@mui/utils';
import { alpha } from '@mui/material/styles';
import { Add, Delete } from '@mui/icons-material';
import AddDeviceModal from './add-device-modal';
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import { styled } from '@mui/material/styles';
import CloudDownloadIcon from '@mui/icons-material/CloudDownload';
import * as XLSX from 'xlsx';
import axios from 'axios';
import Snackbar from '@mui/material/Snackbar';
import MuiAlert, { AlertProps } from '@mui/material/Alert';


export interface Data {
    name: string;
    warranty_years: number;
    min_temperature: number;
    max_temperature: number;
    link: string;
    category_id: number;
    mtbf_hours: number;
    id: number;
    gamma_percent_resource: number;
    preservation_period: number;
    mode_coefficient_k: number;
    mode_coefficient_k_min_temp: number;
    mode_coefficient_k_max_temp: number;
    mtbf_exploitation_min_temp: number;
    mtbf_exploitation_max_temp: number;
    lbd_ex_min: number;
    lbd_ex_max: number;
}

export interface Category {
  name: string;
  id: number;
}

function descendingComparator<T>(a: T, b: T, orderBy: keyof T) {
    if (b[orderBy] < a[orderBy]) {
        return -1;
    }
    if (b[orderBy] > a[orderBy]) {
        return 1;
    }
    return 0;
    }

type Order = 'asc' | 'desc';

// eslint-disable-next-line @typescript-eslint/no-explicit-any
function getComparator<Key extends keyof any>(
    order: Order,
    orderBy: Key,
    ): (
    a: { [key in Key]: number | string },
    b: { [key in Key]: number | string },
    ) => number {
    return order === 'desc'
        ? (a, b) => descendingComparator(a, b, orderBy)
        : (a, b) => -descendingComparator(a, b, orderBy);
    }

interface HeadCell {
    disablePadding: boolean;
    id: keyof Data;
    label: string;
    numeric: boolean;
}
      
const headCells: readonly HeadCell[] = [
    {
      id: 'name',
      numeric: false,
      disablePadding: false,
      label: 'Наименование',
    },
    {
        id: 'warranty_years',
        numeric: false,
        disablePadding: false,
        label: 'Гарантийный срок',
    },
    {
        id: 'min_temperature',
        numeric: false,
        disablePadding: false,
        label: 'Мин. Рабочая темп',
    },
    {
        id: 'max_temperature',
        numeric: true,
        disablePadding: false,
        label: 'Макс. Рабочая темп',
    },
    {
        id: 'mtbf_hours',
        numeric: true,
        disablePadding: false,
        label: 'MTBF (тыс. ч)',
    },
    {
        id: 'mtbf_exploitation_min_temp',
        numeric: true,
        disablePadding: false,
        label: 'MTBF мин. темп. (тыс. ч)',
    },
    {
        id: 'mtbf_exploitation_max_temp',
        numeric: true,
        disablePadding: false,
        label: 'MTBF макс. темп. (тыс. ч)',
    },
    {
        id: 'gamma_percent_resource',
        numeric: true,
        disablePadding: false,
        label: 'Гамма-процентный ресурс',
    },
    {
        id: 'preservation_period',
        numeric: true,
        disablePadding: false,
        label: 'Срок сохраняемости',
    },
    {
        id: 'mode_coefficient_k',
        numeric: true,
        disablePadding: false,
        label: 'Коэффициент режима',
    },
    {
        id: 'mode_coefficient_k_min_temp',
        numeric: true,
        disablePadding: false,
        label: 'Коэффициент режима мин. темп.',
    },
    {
        id: 'mode_coefficient_k_max_temp',
        numeric: true,
        disablePadding: false,
        label: 'Коэффициент режима макс. темп.',
    },
    {
        id: 'lbd_ex_min',
        numeric: true,
        disablePadding: false,
        label: 'Интенсивность отказов мин. темп.',
    },
    {
        id: 'lbd_ex_max',
        numeric: true,
        disablePadding: false,
        label: 'Интенсивность отказов макс. темп.',
    },
    {
        id: 'link',
        numeric: true,
        disablePadding: false,
        label: 'Ссылка',
    },
    {
        id: 'category_id',
        numeric: true,
        disablePadding: false,
        label: 'Категория',
    },
    ];

interface EnhancedTableProps {
    numSelected: number;
    onRequestSort: (event: React.MouseEvent<unknown>, property: keyof Data) => void;
    onSelectAllClick: (event: React.ChangeEvent<HTMLInputElement>) => void;
    order: Order;
    orderBy: string;
    rowCount: number;
    }

function EnhancedTableHead(props: EnhancedTableProps) {
    const { onSelectAllClick, order, orderBy, numSelected, rowCount, onRequestSort } =
        props;
    const createSortHandler =
        (property: keyof Data) => (event: React.MouseEvent<unknown>) => {
        onRequestSort(event, property);
        };
      
    return (
        <TableHead>
        <TableRow sx={{ height: 60 }}>
            <TableCell padding="checkbox">
            <Checkbox
                color="primary"
                indeterminate={numSelected > 0 && numSelected < rowCount}
                checked={rowCount > 0 && numSelected === rowCount}
                onChange={onSelectAllClick}
                inputProps={{
                'aria-label': 'select all devices',
                }}
            />
            </TableCell>
            {headCells.map((headCell) => (
            <TableCell
                key={headCell.id}
                align={"right"}
                padding={headCell.disablePadding ? 'none' : 'normal'}
                sortDirection={orderBy === headCell.id ? order : false}
                sx={{
                  minWidth: 150,
                  whiteSpace: 'normal',
                }}
            >
                <TableSortLabel
                active={orderBy === headCell.id}
                direction={orderBy === headCell.id ? order : 'asc'}
                onClick={createSortHandler(headCell.id)}
                >
                <b>{headCell.label}</b>
                {orderBy === headCell.id ? (
                    <Box component="span" sx={visuallyHidden}>
                    {order === 'desc' ? 'sorted descending' : 'sorted ascending'}
                    </Box>
                ) : null}
                </TableSortLabel>
            </TableCell>
            ))}
        </TableRow>
        </TableHead>
        );
    }

interface EnhancedTableToolbarProps {
  numSelected: number;
  rows: Data[];
  selected: number[];
  categories: Category[];
  onSave: () => void;
  setRows: React.Dispatch<React.SetStateAction<Data[]>>;
  setFilterRows: React.Dispatch<React.SetStateAction<Data[]>>;
  setSelected: React.Dispatch<React.SetStateAction<number[]>>;
}

function EnhancedTableToolbar(props: EnhancedTableToolbarProps) {
  const { numSelected } = props;
  const {rows} = props;
  const {categories} = props;
  const [adding, setAdding] = React.useState(false);
  const [open, setOpen] = React.useState(false);
  const {selected} = props;
  const [snackbarOpen, setSnackbarOpen] = React.useState(false);
  const [snackbarMessage, setSnackbarMessage] = React.useState('');
  const [snackbarSeverity, setSnackbarSeverity] = React.useState<'success' | 'error'>('success');

  const VisuallyHiddenInput = styled('input')({
    clip: 'rect(0 0 0 0)',
    clipPath: 'inset(50%)',
    height: 1,
    overflow: 'hidden',
    position: 'absolute',
    bottom: 0,
    left: 0,
    whiteSpace: 'nowrap',
    width: 1,
  });

  const Alert = React.forwardRef<HTMLDivElement, AlertProps>(function Alert(props, ref) {
    return <MuiAlert elevation={6} ref={ref} variant="filled" {...props} />;
  });
  
  const handleExport = () => {
    const data = rows

    const worksheet = XLSX.utils.json_to_sheet(data);
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, 'Sheet1');

    XLSX.writeFile(workbook, 'data.xlsx');
  };

  const deleteItems = async () => {
    try {
      await Promise.all(
        selected.map((id) => axios.delete(`http://localhost:8000/equipments/${id}`))
      );
  
      const updatedRows = rows.filter((row) => !selected.includes(row.id));
      props.setRows(updatedRows);
      props.setFilterRows(updatedRows);
      props.setSelected([]);
  
      setSnackbarMessage('Устройства успешно удалены.');
      setSnackbarSeverity('success');
      setSnackbarOpen(true);
    } catch (error) {
      setSnackbarMessage('Ошибка при удалении устройств.');
      setSnackbarSeverity('error');
      setSnackbarOpen(true);
      console.error('Ошибка при удалении:', error);
    }
  };

  const handleImport = async (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (!file) return;
  
    const formData = new FormData();
    formData.append('file', file);
  
    try {
      await axios.post(`${import.meta.env.VITE_API_URL}/equipments/import/`, formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      });
  
      setSnackbarMessage('Файл успешно импортирован.');
      setSnackbarSeverity('success');
      setSnackbarOpen(true);
  
      // Обновляем данные после импорта
      const response = await axios.get<Data[]>(`${import.meta.env.VITE_API_URL}/equipments/?skip=0&limit=700`);
      props.setRows(response.data);
      props.setFilterRows(response.data);
  
    } catch (error) {
      console.error('Ошибка при импорте:', error);
      setSnackbarMessage('Ошибка при импорте файла.');
      setSnackbarSeverity('error');
      setSnackbarOpen(true);
    }
  
    // Очистить input, чтобы можно было загрузить тот же файл снова
    event.target.value = '';
  };

  return (
    <Toolbar
      sx={[
        {
          pl: { sm: 2 },
          pr: { xs: 1, sm: 1 },
          justifyContent: 'space-between',
        },
        numSelected > 0 && {
          bgcolor: (theme) =>
            alpha(theme.palette.primary.main, theme.palette.action.activatedOpacity),
        },
      ]}
    >
      {numSelected > 0 ? (
        <Typography
          sx={{ flex: '1 1 100%' }}
          color="inherit"
          variant="subtitle1"
          component="div"
        >
          {numSelected} selected
        </Typography>
      ) : (
        <Box>
          <Button
          component="label"
          role={undefined}
          variant="contained"
          tabIndex={-1}
          startIcon={<CloudUploadIcon />}
          sx={{mr: 2}}
        >
          Импорт
        <VisuallyHiddenInput
          type="file"
          onChange={handleImport}
          accept=".xlsx"
        />
        </Button>
        <Button variant="contained" startIcon={<CloudDownloadIcon />} onClick={handleExport}>
          Экспорт
        </Button>
        </Box>
      )}
      {numSelected > 0 ? (
        <Tooltip title="Удалить">
          <IconButton color="error" onClick={deleteItems}>
            <Delete />
          </IconButton>
        </Tooltip>
      ) : (
        <Tooltip title="Добавить">
          <IconButton color="primary" onClick={() => {setAdding(true); setOpen(true)}}>
            <Add />
          </IconButton>
        </Tooltip>
      )}
    <Box sx={{display: "none"}}>
      <AddDeviceModal state={open} adding={adding} onClose={() => setOpen(false)} id={1} rows={rows} categories={categories} onSave={props.onSave}/>
    </Box>
    <Snackbar
      open={snackbarOpen}
      autoHideDuration={3000}
      onClose={() => setSnackbarOpen(false)}
      anchorOrigin={{ vertical: 'bottom', horizontal: 'center' }}
    >
      <Alert onClose={() => setSnackbarOpen(false)} severity={snackbarSeverity} sx={{ width: '100%' }}>
        {snackbarMessage}
      </Alert>
    </Snackbar>
    </Toolbar>
  );
}

      export default function EnhancedTable() {
        const [order, setOrder] = React.useState<Order>('asc');
        const [orderBy, setOrderBy] = React.useState<keyof Data>('name');
        const [selected, setSelected] = React.useState<number[]>([]);
        const [page, setPage] = React.useState(0);
        const [rowsPerPage, setRowsPerPage] = React.useState(10);
        const [rows, setRows] = React.useState<Data[]>([]);
        const [filterRows, setFilterRows] = React.useState<Data[]>(rows);
        const [categories, setCategories] = React.useState<Category[]>([]);
        const [show, setShow] = React.useState(false);
        const [adding, setAdding] = React.useState(false);
        const [id, setId] = React.useState(1);
        const [searchTerms, setSearchTerms] = React.useState<string[]>([]);
        const [query, setQuery] = React.useState('');
        const optionList = React.useMemo(() => {
          const devNames = rows.map((r) => r.name).filter(Boolean) as string[];
          const catNames = categories.map((c) => c.name).filter(Boolean);
          return [...new Set([...devNames, ...catNames].map((n) => n.trim()))];
        }, [rows, categories]);

        const api = import.meta.env.VITE_API_URL;

        useEffect(() => {
          axios.get<Data[]>(`${api}/equipments/?skip=0&limit=700`)
            .then((response) => {
              setRows(response.data);
              setFilterRows(response.data);
            })
            .catch((error) => {
              console.error('Ошибка при загрузке данных:', error);
            });
        }, []);

        useEffect(() => {
          axios.get<Category[]>(`${api}/categories/?skip=0&limit=100`)
          .then((response) => {
            setCategories(response.data);
          })
          .catch((error) => {
            console.error('Ошибка при загрузке данных:', error);
          });
        }, []);

        const categoryMap = React.useMemo(() => {
          const map: Record<number, string> = {};
          categories.forEach((cat) => {
            map[cat.id] = cat.name;
          });
          return map;
        }, [categories]);
        
        console.log(rows);
      
        const handleRequestSort = (
          _event: React.MouseEvent<unknown>,
          property: keyof Data,
        ) => {
          const isAsc = orderBy === property && order === 'asc';
          setOrder(isAsc ? 'desc' : 'asc');
          setOrderBy(property);
        };
      
        const handleSelectAllClick = (event: React.ChangeEvent<HTMLInputElement>) => {
          if (event.target.checked) {
            const newSelected = rows.map((n) => n.id);
            setSelected(newSelected);
            return;
          }
          setSelected([]);
        };
      
        const handleClick = (_event: React.MouseEvent<unknown>, id: number) => {
          const selectedIndex = selected.indexOf(id);
          let newSelected: number[] = [];
      
          if (selectedIndex === -1) {
            newSelected = newSelected.concat(selected, id);
          } else if (selectedIndex === 0) {
            newSelected = newSelected.concat(selected.slice(1));
          } else if (selectedIndex === selected.length - 1) {
            newSelected = newSelected.concat(selected.slice(0, -1));
          } else if (selectedIndex > 0) {
            newSelected = newSelected.concat(
              selected.slice(0, selectedIndex),
              selected.slice(selectedIndex + 1),
            );
          }
          setSelected(newSelected);
        };

        const handleSave = async () => {
          const response = await axios.get<Data[]>(`${api}/equipments/?skip=0&limit=700`);
          setRows(response.data);
        };
      
        const handleChangePage = (_event: unknown, newPage: number) => {
          setPage(newPage);
        };
      
        const handleChangeRowsPerPage = (event: React.ChangeEvent<HTMLInputElement>) => {
          setRowsPerPage(parseInt(event.target.value, 10));
          setPage(0);
        };

        useEffect(() => {
          if (searchTerms.length === 0) {
            setFilterRows(rows);
            return;
          }
        
          const filtered = rows.filter((row) => {
            const rowName = row.name.toLowerCase();
            const categoryName = categoryMap[row.category_id]?.toLowerCase() || '';
            return searchTerms.some((term) => rowName.includes(term) || categoryName.includes(term));
          });
        
          setFilterRows(filtered);
          setPage(0);
        }, [searchTerms, rows, categoryMap]);
      
        // Avoid a layout jump when reaching the last page with empty rows.
        const emptyRows =
          page > 0 ? Math.max(0, (1 + page) * rowsPerPage - filterRows.length) : 0;
      
        const visibleRows = React.useMemo(
          () =>
            [...filterRows]
              .sort(getComparator(order, orderBy))
              .slice(page * rowsPerPage, page * rowsPerPage + rowsPerPage),
          [order, orderBy, page, rowsPerPage, filterRows],
        );

        const filterOptions = (_opts: string[], { inputValue }: { inputValue: string }) => {
          const val = inputValue.trim().toLowerCase();
          if (!val) return optionList.slice(0, 25);
        
          return optionList
            .filter((txt) => txt.toLowerCase().includes(val))
            .slice(0, 25);
        };
        
      
        return (
          <Box sx={{ width: '100%', margin: '0', pt: 2}}>
            <AddDeviceModal state={show} adding={adding} onClose={() => setShow(false)} id={id} rows={rows} categories={categories} onSave={handleSave}/>
            <Autocomplete
              id="free-solo"
              freeSolo
              filterOptions={filterOptions}
              inputValue={query}
              onInputChange={(_, value) => setQuery(value)}
              onChange={(_, value) => {                   // сработает при выборе или Enter
                if (!value) return;
                const term = value.toString().trim().toLowerCase();
                if (term && !searchTerms.includes(term)) {
                  setSearchTerms((prev) => [...prev, term]);  // кидаем в фильтры
                }
                setQuery('');                                // чистим поле
              }}
              options={optionList}
              clearOnEscape
              getOptionLabel={(opt) => opt}
              renderInput={(params) => <TextField {...params} label="Поиск" />}
              sx={{pb: 2}}
              filterSelectedOptions
            />
            <Box sx={{ display: 'flex', gap: 1, flexWrap: 'wrap', pb: 2 }}>
              {searchTerms.map((term) => (
                <Chip
                  key={term}
                  label={term}
                  onDelete={() => setSearchTerms((prev) => prev.filter((t) => t !== term))}
                  color="primary"
                />
              ))}
              <Button onClick={() => setSearchTerms([])}>Сбросить поиск</Button>
            </Box>
            {filterRows.length > 0 ? 
            <Paper variant="outlined" sx={{ width: '100%', mb: 2 }}>
              <EnhancedTableToolbar numSelected={selected.length} rows={rows} selected={selected} setRows={setRows} setFilterRows={setFilterRows} setSelected={setSelected} categories={categories} onSave={handleSave}/>
              <TableContainer sx={{ maxHeight: '75vh', overflowX: 'auto' }}>
                <Table
                  sx={{ minWidth: 900 }}
                  aria-labelledby="tableTitle"
                >
                  <EnhancedTableHead
                    numSelected={selected.length}
                    order={order}
                    orderBy={orderBy}
                    onSelectAllClick={handleSelectAllClick}
                    onRequestSort={handleRequestSort}
                    rowCount={rows.length}
                  />
                  <TableBody>
                    {visibleRows.map((row, index) => {
                      const isItemSelected = selected.includes(row.id);
                      const labelId = `enhanced-table-checkbox-${index}`;
      
                      return (
                        <TableRow
                          hover
                          onDoubleClick={() => {setShow(true); setAdding(false); setId(row.id)}}
                          role="checkbox"
                          aria-checked={isItemSelected}
                          tabIndex={-1}
                          key={row.id}
                          selected={isItemSelected}
                          sx={{ cursor: 'pointer',  height: 60 }}
                        >
                          <TableCell padding="checkbox">
                            <Checkbox
                              color="primary"
                              onClick={(event) => handleClick(event, row.id)}
                              checked={isItemSelected}
                              inputProps={{
                                'aria-labelledby': labelId,
                              }}
                            />
                          </TableCell>
                          <TableCell
                            component="th"
                            id={labelId}
                            scope="row"
                            padding="none"
                            sx={{
                              maxWidth: 150,
                              overflow: 'hidden',
                              textOverflow: 'ellipsis',
                              whiteSpace: 'nowrap',
                              verticalAlign: 'middle',
                            }}
                          >
                            {row.name}
                          </TableCell>
                          <TableCell align="right" sx={{ minWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{row.warranty_years !== null ? row.warranty_years : '—'}</TableCell>
                          <TableCell align="right" sx={{ minWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{row.min_temperature !== null ? row.min_temperature : '—'}</TableCell>
                          <TableCell align="right" sx={{ minWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{row.max_temperature !== null ? row.max_temperature : '—'}</TableCell>
                          <TableCell align="right" sx={{ minWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{row.mtbf_hours !== null ? row.mtbf_hours : '—'}</TableCell>
                          <TableCell align="right" sx={{ minWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{row.mtbf_exploitation_min_temp !== null ? row.mtbf_exploitation_min_temp : '—'}</TableCell>
                          <TableCell align="right" sx={{ minWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{row.mtbf_exploitation_max_temp !== null ? row.mtbf_exploitation_max_temp : '—'}</TableCell>
                          <TableCell align="right" sx={{ minWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{row.gamma_percent_resource !== null ? row.gamma_percent_resource : '—'}</TableCell>
                          <TableCell align="right" sx={{ minWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{row.preservation_period !== null ? row.preservation_period : '—'}</TableCell>
                          <TableCell align="right" sx={{ minWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{row.mode_coefficient_k !== null ? row.mode_coefficient_k : '—'}</TableCell>
                          <TableCell align="right" sx={{ minWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{row.mode_coefficient_k_min_temp !== null ? row.mode_coefficient_k_min_temp : '—'}</TableCell>
                          <TableCell align="right" sx={{ minWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{row.mode_coefficient_k_max_temp !== null ? row.mode_coefficient_k_max_temp : '—'}</TableCell>
                          <TableCell align="right" sx={{ minWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{row.lbd_ex_min !== null ? row.lbd_ex_min : '—'}</TableCell>
                          <TableCell align="right" sx={{ minWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{row.lbd_ex_max !== null ? row.lbd_ex_max : '—'}</TableCell>
                          <TableCell align="right" sx={{ maxWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{row.link && row.link !== "нет данных " ? (
                          <a 
                            href={row.link} 
                            target="_blank" 
                            rel="noopener noreferrer"
                            style={{
                              color: '#1976d2',
                              textDecoration: 'none'
                            }}
                          >
                            {row.link}
                          </a>
                        ) : (
                          '—'
                        )}</TableCell>
                          <TableCell align="right" sx={{ minWidth: 150, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap', verticalAlign: 'middle', }}>{categoryMap[row.category_id] || '—'}</TableCell>
                        </TableRow>
                      );
                    })}
                    {emptyRows > 0 && (
                      <TableRow
                        style={{
                          height: 53 * emptyRows,
                        }}
                      >
                        <TableCell colSpan={6} />
                      </TableRow>
                    )}
                  </TableBody>
                </Table>
              </TableContainer>
              <TablePagination
                rowsPerPageOptions={[10, 25, 30]}
                component="div"
                count={filterRows.length}
                rowsPerPage={rowsPerPage}
                page={page}
                onPageChange={handleChangePage}
                onRowsPerPageChange={handleChangeRowsPerPage}
              />
            </Paper> : <Typography align='center' variant='h5' pt={10}>Ничего не найдено. Попробуйте проверить правильность ввода или добавьте новое устройство.</Typography>}
            
          </Box>
        );
      }