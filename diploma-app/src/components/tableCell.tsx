import { Autocomplete, Box, Button, Checkbox, IconButton, Paper, Table, TableBody, TableCell, TableContainer, TableHead, TablePagination, TableRow, TableSortLabel, TextField, Toolbar, Tooltip, Typography } from '@mui/material';
import React, { SyntheticEvent, useEffect } from 'react';
import { visuallyHidden } from '@mui/utils';
import { alpha } from '@mui/material/styles';
import DeleteIcon from '@mui/icons-material/Delete';
import AddIcon from '@mui/icons-material/Add';
import AddDeviceModal from './add-device-modal';
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import { styled } from '@mui/material/styles';


interface Data { //Данные должны будут прокидываться из слайса, который получает их из апи
    id: number;
    image: string;
    name: string;
    description: string;
    price: number;
    rating: number;
    }
      
function createData(
    id: number,
    image: string,
    name: string,
    description: string,
    price: number,
    rating: number,
    ): Data {
    return {
        id,
        image,
        name,
        description,
        price,
        rating,
    };
    }
      
export const rows = [
    createData(1, "путь к картинке1", 'Монитор', "Бла бла бла", 3000, 4.3),
    createData(2, "путь к картинке2", 'Корпус', "Системный блок большой", 300, 2.0),
    createData(3, "путь к картинке3", 'Блок питания', "Самый топовый блок питания", 311100, 5.0),
    createData(4, "путь к картинке4", 'Хороший ПК', "Сойдет", 202020, 3.7),
    createData(5, "путь к картинке5", 'Что-то', "Какое-то", 99, 1.0),
    createData(6, "путь к картинке6", 'Кто-то', "Неплохо", 999, 2.5),
    createData(7, "путь к картинке7", 'Камера', "Хорошая камера", 100000, 4.9),
    createData(8, "путь к картинке8", 'Клавиатура', "Клик-Клик", 1010, 4.6),
    createData(9, "путь к картинке9", 'Наушники', "Звучат хорошо", 9090, 4.7),
    createData(10, "путь к картинке10", 'Мышь', "12345667", 1111, 3.3),
    createData(11, "путь к картинке11", 'Динамики', "Очень громкие", 2990, 3.9),
    createData(12, "путь к картинке12", 'Монитор 4K', "Разрешение изображения отличное", 30000, 4.9),
    createData(13, "путь к картинке13", 'Стул игровой', "Качается катается крутится", 19990, 4.1),
    ];

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
      id: 'image',
      numeric: false,
      disablePadding: false,
      label: 'Image',
    },
    {
        id: 'name',
        numeric: false,
        disablePadding: false,
        label: 'Name',
    },
    {
        id: 'description',
        numeric: false,
        disablePadding: false,
        label: 'Description',
    },
    {
        id: 'price',
        numeric: true,
        disablePadding: false,
        label: 'Price',
    },
    {
        id: 'rating',
        numeric: true,
        disablePadding: false,
        label: 'Rating',
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
                {headCell.label}
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
}

function EnhancedTableToolbar(props: EnhancedTableToolbarProps) {
  const { numSelected } = props;
  const [adding, setAdding] = React.useState(false);
  const [open, setOpen] = React.useState(false);

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
        <Button
          component="label"
          role={undefined}
          variant="contained"
          tabIndex={-1}
          startIcon={<CloudUploadIcon />}
        >
          Upload files
        <VisuallyHiddenInput
          type="file"
          onChange={(event) => console.log(event.target.files)}
          multiple
        />
        </Button>
      )}
      {numSelected > 0 ? (
        <Tooltip title="Удалить">
          <IconButton>
            <DeleteIcon />
          </IconButton>
        </Tooltip>
      ) : (
        <Tooltip title="Добавить">
          <IconButton onClick={() => {setAdding(true); setOpen(true)}}>
            <AddIcon/>
          </IconButton>
        </Tooltip>
      )}
    <Box sx={{display: "none"}}>
      <AddDeviceModal state={open} adding={adding} onClose={() => setOpen(false)} id={1}/>
    </Box>
    </Toolbar>
  );
}

      export default function EnhancedTable() {
        const [order, setOrder] = React.useState<Order>('asc');
        const [orderBy, setOrderBy] = React.useState<keyof Data>('description');
        const [selected, setSelected] = React.useState<readonly number[]>([]);
        const [page, setPage] = React.useState(0);
        const [rowsPerPage, setRowsPerPage] = React.useState(5);
        const [filterRows, setRows] = React.useState<Data[]>(rows);
        const [show, setShow] = React.useState(false);
        const [adding, setAdding] = React.useState(false);
        const [id, setId] = React.useState(1);
        
      
        const handleRequestSort = (
          event: React.MouseEvent<unknown>,
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
      
        const handleClick = (event: React.MouseEvent<unknown>, id: number) => {
          const selectedIndex = selected.indexOf(id);
          let newSelected: readonly number[] = [];
      
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
      
        const handleChangePage = (event: unknown, newPage: number) => {
          setPage(newPage);
        };
      
        const handleChangeRowsPerPage = (event: React.ChangeEvent<HTMLInputElement>) => {
          setRowsPerPage(parseInt(event.target.value, 10));
          setPage(0);
        };

        useEffect(()=>{
          if (filterRows){
            setRows(filterRows);
          } else {
            setRows(rows)
          }
        }, [filterRows])

        const handleChange = (e: SyntheticEvent, v: Data | string | null) => {
          if (typeof v === 'string') {
            console.log(v);
            const filteredRows = rows.filter((row) => row.name.toLowerCase().includes(v.toLowerCase()));
            setRows(filteredRows);
          } else if (v) {
            setRows([v]);
          } else {
            setRows(rows);
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
          <Box sx={{ width: '100%' }}>
            <AddDeviceModal state={show} adding={adding} onClose={() => setShow(false)} id={id}/>
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
              <EnhancedTableToolbar numSelected={selected.length} />
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
                            {row.image}
                          </TableCell>
                          <TableCell align="right">{row.name}</TableCell>
                          <TableCell align="right">{row.description}</TableCell>
                          <TableCell align="right">{row.price}</TableCell>
                          <TableCell align="right">{row.rating}</TableCell>
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
                rowsPerPageOptions={[5, 10, 25]}
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