import React from 'react';
import './userdashboard.css';

const StatusCard2 = ({ title, value, gradient }) => {
  return (
    <div className="stats-card" style={{ background: gradient }}>
      <div className="stats-title">{title}</div>
      <div className="stats-value">{value}</div>
    </div>
  );
};

export default StatusCard2;