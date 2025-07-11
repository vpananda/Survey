import React from 'react';
import './dashboard.css';

const ScoreCard = ({ percentage, assigned, responded }) => {
  const radius = 80;
  const stroke = 12;
  const normalizedRadius = radius - stroke / 2;
  const circumference = normalizedRadius * 2 * Math.PI;
  const strokeDashoffset = circumference - (percentage / 100) * circumference;

  return (
    <div className="scorecard-container">
      {/* <h3 className="scorecard-title">Employee Engagement</h3> */}

      <div className="scorecard-circle">
        <svg
          height={radius * 2}
          width={radius * 2}
          className="progress-ring"
        >
          <circle
            className="bg"
            r={normalizedRadius}
            cx={radius}
            cy={radius}
          />
          <circle
            className="progress"
            r={normalizedRadius}
            cx={radius}
            cy={radius}
            strokeDasharray={`${circumference} ${circumference}`}
            strokeDashoffset={strokeDashoffset}
          />
        </svg>
        <div className="scorecard-percent">{percentage}%</div>
      </div>

      <div className="scorecard-subtext">
        {responded} out of {assigned} surveys responded
      </div>
    </div>
  );
};

export default ScoreCard;
