import React from 'react';
import '../styles/dashboard.css';
import { FaUsers, FaCheck, FaFileAlt, FaEnvelopeOpenText, FaQuestionCircle } from 'react-icons/fa';

const iconMap = {
  employees: <FaUsers />,
  attended: <FaCheck />,
  surveys: <FaFileAlt />,
  responses: <FaEnvelopeOpenText />,
  questions: <FaQuestionCircle />
};

const StatsCard = ({ title, value, type, gradient }) => {
  return (
    <div className="stat-card" style={{ background: gradient }}>
      <div className="stat-info">
        <div className="stat-title">{title}</div>
        <div className="stat-value">{value}</div>
      </div>
      <div className="stat-icon">{iconMap[type]}</div>
    </div>
  );
};

export default StatsCard;
