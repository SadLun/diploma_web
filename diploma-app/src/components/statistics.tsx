import React from 'react';
import { BarChart } from '@mui/x-charts/BarChart';

const Statistics: React.FC = () => {
    return (
        <BarChart
          xAxis={[{ scaleType: 'band', data: ['group A'] }]}
          series={[{ data: [4] }, { data: [1] }, { data: [2] }]}
          height={500}
        />
      );
}

export default Statistics