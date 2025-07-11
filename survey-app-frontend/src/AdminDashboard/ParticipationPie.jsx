import React from 'react';
import { Pie } from 'react-chartjs-2';
import {
  Chart as ChartJS,
  ArcElement,
  Tooltip,
  Legend
} from 'chart.js';
import ChartDataLabels from 'chartjs-plugin-datalabels';

ChartJS.register(ArcElement, Tooltip, Legend);

const ParticipationPie = ({ data }) => {
  const submitted = data?.submitted || 0;
  const notSubmitted = data?.notSubmitted || 0;
  const total = submitted + notSubmitted;

  const chartData = {
    labels: ['Submitted', 'Not Submitted'],
    datasets: [
      {
        data: [submitted, notSubmitted],
        backgroundColor: ['#36A2EB', '#FF6384'],
        hoverBackgroundColor: ['#2892d7', '#ff4c6d'],
        borderWidth: 1
      }
    ]
  };

  const options = {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        title: {
          display: true,
          // text: 'Survey Participation',
          font: {
            size: 18
        },
          padding: {
            top: 10,
            bottom: 20
        }
      },
      legend: {
        position: 'bottom',
        labels: {
          color: '#333',
          font: {
            size: 14
          }
        }
      },
      datalabels: {
        color: '#fff',
        formatter: (value) => {
          const percent = total > 0 ? Math.round((value / total) * 100) : 0;
          return `${percent}%`;
        },
        font: {
          weight: 'bold',
          size: 14
        }
      }
    },
    animation: {
      animateScale: true,
      animateRotate: true
    }
  };

  if (!submitted && !notSubmitted) {
    return <p style={{ textAlign: 'center', color: '#888' }}>No participation data available.</p>;
  }

  return (
      <div className="participation-chart-container">
      <Pie data={chartData} options={options} />
      </div>
  );
};

export default ParticipationPie;
