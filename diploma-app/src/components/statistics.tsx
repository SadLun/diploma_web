import React, { useEffect } from 'react';
import { BarChart } from '@mui/x-charts/BarChart';
import axios from 'axios';
import { Card, CardContent, Stack, Typography } from '@mui/material';

interface CategoryStats {
  id: number,
  name: string,
  avg_mtbf_hours: number,
  avg_gamma_percent_resource: number,
  avg_preservation_period: number,
  avg_mode_coefficient_k: number,
  avg_mode_coefficient_k_min_temp: number,
  avg_mode_coefficient_k_max_temp: number,
  avg_mtbf_exploitation_min_temp: number,
  avg_mtbf_exploitation_max_temp: number,
  [key: string]: string | number;
}

const chartFields = [
  { key: 'avg_mtbf_hours', label: 'Средняя наработка на отказ (тыс. часов)' },
  { key: 'avg_preservation_period', label: 'Средний срок сохраняемости (лет)' },
  { key: 'avg_gamma_percent_resource', label: 'Средний гамма-процентный ресурс' },
  { key: 'avg_mode_coefficient_k', label: 'Средний коэффициент режима K' },
  { key: 'avg_mode_coefficient_k_min_temp', label: 'Средний коэф. режима при мин. темп.' },
  { key: 'avg_mode_coefficient_k_max_temp', label: 'Средний коэф. режима при макс. темп.' },
  { key: 'avg_mtbf_exploitation_min_temp', label: 'Средняя наработка на отказ при мин. темп. (тыс. часов)' },
  { key: 'avg_mtbf_exploitation_max_temp', label: 'Средняя наработка на отказ при макс. темп. (тыс. часов)' },
  { key: 'avg_lbd_ex_min', label: 'Средняя интенсивность отказов при мин. темп.' },
  { key: 'avg_lbd_ex_max', label: 'Средняя интенсивность отказов при макс. темп.' },
];

const Statistics: React.FC = () => {
  const [stats, setStats] = React.useState<CategoryStats[]>([]);
  const api = import.meta.env.VITE_API_URL;

    useEffect(() => {
      axios.get<CategoryStats[]>(`${api}/categories/categories/stats`)
        .then((response) => {
          setStats(response.data);
        })
        .catch((error) => {
          console.error('Ошибка при загрузке данных:', error);
        });
    }, []);

    return (
      <Stack spacing={4} sx={{ width: '100%', maxWidth: 1200, margin: '0 auto', pt: 2 }}>
      {chartFields.map(({ key, label }) => (
          <Card variant="outlined">
            <CardContent>
              <Typography variant="h6" gutterBottom>
                {label}
              </Typography>
              <BarChart
                dataset={stats}
                xAxis={[
                  {
                    scaleType: 'band',
                    dataKey: 'name',
                    tickPlacement: 'middle',
                    tickLabelPlacement: 'middle',
                    tickLabelInterval: 'auto',
                    tickLabelStyle: {
                      angle: 45
                    }
                  },
                ]}
                series={[
                  {
                    dataKey: key,
                    label,
                  },
                ]}
                height={400}
              />
            </CardContent>
          </Card>
      ))}
      </Stack>
      );
}

export default Statistics