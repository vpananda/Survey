import React from 'react';
import { Bar } from 'react-chartjs-2';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  BarElement,
  Title,
  Tooltip,
} from 'chart.js';

ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip);

const TopSurveyProgress= ({ data }) => {
  if (!data || data.length === 0) {
    return <p style={{ padding: '16px', color: '#888' }}>No top surveys found.</p>;
  }

  const labels = data.map(item => item.survey);
  const counts = data.map(item => item.responses);

  const chartData = {
    labels,
    datasets: [
      {
        label: 'Responses',
        data: counts,
        backgroundColor: 'rgba(123, 97, 255, 0.7)', 
        borderRadius: 8,
        barThickness: 22,
      },
    ],
  };

  const options = {
    indexAxis: 'y',
    responsive: true,
    maintainAspectRatio: false,
    layout: {
      padding: {
        left: 20,
        right: 20,
        top: 10,
        bottom: 10,
      },
    },
    plugins: {
      legend: { display: false },
      tooltip: {
        callbacks: {
          label: ctx => `${ctx.parsed.x} responses`,
        },
      },
    },
    scales: {
      x: {
        beginAtZero: true,
        ticks: {
          font: { size: 12 },
          color: '#444',
          stepSize: 1,
        },
        grid: {
          color: '#f0f0f0',
        },
      },
      y: {
        ticks: {
          font: { size: 14 },
          color: '#333',
          padding: 8,
        },
        grid: {
          display: false,
        },
      },
    },
  };

  return (
    <div style={{ height: `${labels.length * 50}px`, padding: '10px 20px' }}>
      <Bar data={chartData} options={options} />
    </div>
  );
};

export default TopSurveyProgress;
