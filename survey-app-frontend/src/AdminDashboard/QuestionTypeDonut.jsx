import React from 'react';
import {
  PieChart,
  Pie,
  Cell,
  Tooltip,
  Legend,
  ResponsiveContainer,
} from 'recharts';


const COLORS = ['#fbc02d', '#9575cd', '#4db6ac', '#ff7043', '#90caf9'];

const QuestionTypeDonut = ({ data }) => {
  if (!data || data.length === 0) {
    return <p style={{ textAlign: 'center', padding: '20px' }}>No question type data available.</p>;
  }

  return (
    <ResponsiveContainer width="100%" height={300}>
      <PieChart>
        <Pie
          data={data}
          dataKey="count"
          nameKey="type"
          cx="50%"
          cy="50%"
          outerRadius={100}
          label
        >
          {data.map((entry, index) => (
            <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
          ))}
        </Pie>
        <Tooltip />
        <Legend />
      </PieChart>
    </ResponsiveContainer>
  );
};

export default QuestionTypeDonut;
