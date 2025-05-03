import { Autocomplete, Box, Button, Checkbox, IconButton, Paper, Table, TableBody, TableCell, TableContainer, TableHead, TablePagination, TableRow, TableSortLabel, TextField, Toolbar, Tooltip, Typography } from '@mui/material';
import React, { SyntheticEvent, useEffect } from 'react';
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
        <TableRow>
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
        >
          Импорт
        <VisuallyHiddenInput
          type="file"
          onChange={(event) => console.log(event.target.files)}
          multiple
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
        const [rows, setRows] = React.useState<Data[]>([{name: "aboba", warranty_years: 1, min_temperature: 10, max_temperature: 50, link: "aboba", category_id: 5, mtbf_hours: 10, id: 39, gamma_percent_resource: 10, preservation_period: 10, mode_coefficient_k: 10}]);
        const [filterRows, setFilterRows] = React.useState<Data[]>(rows);
        const [categories, setCategories] = React.useState<Category[]>([]);
        const [show, setShow] = React.useState(false);
        const [adding, setAdding] = React.useState(false);
        const [id, setId] = React.useState(1);

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

        // useEffect(() => {
        //   setFilterRows(rows);
        // }, [rows]);

        const handleChange = (_e: SyntheticEvent, v: Data | string | null) => {
          if (typeof v === 'string') {
            console.log(v);
            const filteredRows = rows.filter((row) => row.name.toLowerCase().includes(v.toLowerCase()));
            setFilterRows(filteredRows);
          } else if (v) {
            setFilterRows([v]);
          } else {
            setFilterRows(rows);
          }
        }
      
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
      
        return (
          <Box sx={{ width: '100%', margin: '0 auto', p: 2}}>
            <AddDeviceModal state={show} adding={adding} onClose={() => setShow(false)} id={id} rows={rows} categories={categories} onSave={handleSave}/>
            <Autocomplete
              id="free-solo"
              freeSolo
              onChange={handleChange}
              options={rows}
              noOptionsText="Ничего не найдено"
              clearOnEscape
              getOptionLabel={(rows) => (typeof rows === 'string' ? rows : rows.name || '')}
              renderInput={(params) => <TextField {...params} label="Поиск" />}
            />
            {filterRows.length > 0 ? 
            <Paper sx={{ width: '100%', mb: 2 }}>
              <EnhancedTableToolbar numSelected={selected.length} rows={rows} selected={selected} setRows={setRows} setFilterRows={setFilterRows} setSelected={setSelected} categories={categories} onSave={handleSave}/>
              <TableContainer>
                <Table
                  sx={{ minWidth: 750 }}
                  aria-labelledby="tableTitle"
                  size={'medium'}
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
                          sx={{ cursor: 'pointer' }}
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
                          >
                            {row.name}
                          </TableCell>
                          <TableCell align="right">{row.warranty_years}</TableCell>
                          <TableCell align="right">{row.min_temperature}</TableCell>
                          <TableCell align="right">{row.max_temperature}</TableCell>
                          <TableCell align="right">{row.mtbf_hours}</TableCell>
                          <TableCell align="right">{row.gamma_percent_resource}</TableCell>
                          <TableCell align="right">{row.preservation_period}</TableCell>
                          <TableCell align="right">{row.mode_coefficient_k}</TableCell>
                          <TableCell align="right">{row.link}</TableCell>
                          <TableCell align="right">{categoryMap[row.category_id] || '—'}</TableCell>
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