import React from 'react';
import { Bar } from 'react-chartjs-2';
import {
  Chart as ChartJS,
  BarElement,
  CategoryScale,
  LinearScale,
  Tooltip,
  Legend
} from 'chart.js';

ChartJS.register(BarElement, CategoryScale, LinearScale, Tooltip, Legend);

const SurveyBarChart = ({ data, onSurveySelect }) => {
  if (!data || data.length === 0) return <p>No survey data to display.</p>;

  const chartData = {
    labels: data.map(s => s.SurveyName),
    datasets: [
      {
        label: 'Number of Responses',
        data: data.map(s => s.ResponseCount),
        backgroundColor: '#6c63ff',
        borderRadius: 6,
      }
    ]
  };

  const options = {
    responsive: true,
    plugins: {
      legend: { display: false },
      tooltip: { enabled: true }
    },
    onClick: (evt, elements) => {
      if (elements.length > 0) {
        const index = elements[0].index;
        const selected = data[index];
        if (selected && onSurveySelect) onSurveySelect(selected.SurveyID);
      }
    },
    scales: {
      y: {
        beginAtZero: true,
        ticks: { stepSize: 1 }
      }
    }
  };

  return (
    <div style={{ height: '300px' }}>
      <Bar data={chartData} options={options} />
    </div>
  );
};

export default SurveyBarChart;
