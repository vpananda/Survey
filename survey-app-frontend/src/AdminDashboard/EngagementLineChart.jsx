import React from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';

const EngagementLineChart = ({ data }) => {
  return (
    <>
      <h4>Employee Engagement</h4>
      <ResponsiveContainer width="100%" height={300}>
        <LineChart data={data}>
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="date" />
          <YAxis allowDecimals={false} />
          <Tooltip />
          <Line type="monotone" dataKey="count" stroke="#007bff" strokeWidth={2} />
        </LineChart>
      </ResponsiveContainer>
    </>
  );
};

export default EngagementLineChart;
