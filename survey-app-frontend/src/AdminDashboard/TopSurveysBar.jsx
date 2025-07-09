import React from 'react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer, Cell } from 'recharts';

const colors = ['#4e79a7', '#f28e2b', '#e15759', '#76b7b2', '#59a14f'];

const TopSurveysBar = ({ data }) => {
  return (
    <>
      <h4>Top Performing Surveys</h4>
      <ResponsiveContainer width="100%" height={250}>
        <BarChart data={data} layout="vertical">
          <XAxis type="number" />
          <YAxis dataKey="survey" type="category" />
          <Tooltip />
          <Bar dataKey="count" fill="#8884d8">
            {data.map((entry, index) => (
              <Cell key={index} fill={colors[index % colors.length]} />
            ))}
          </Bar>
        </BarChart>
      </ResponsiveContainer>
    </>
  );
};

export default TopSurveysBar;
