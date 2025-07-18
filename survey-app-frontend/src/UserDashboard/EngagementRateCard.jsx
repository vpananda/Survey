import React, { useEffect, useState } from 'react';
import { CircularProgressbar, buildStyles } from 'react-circular-progressbar';
import 'react-circular-progressbar/dist/styles.css';
import './UserDashboard.css';

const EngagementRateCard = ({ employeeId }) => {
  const [rate, setRate] = useState(0);
  const [completed, setCompleted] = useState(0);
  const [assigned, setAssigned] = useState(0);

  useEffect(() => {
    fetch(`http://localhost:5000/api/user/engagement-rate/${employeeId}`)
      .then(res => res.json())
      .then(data => {
        setRate(data.engagement_rate);
        setCompleted(data.completed);
        setAssigned(data.assigned);
      });
  }, [employeeId]);

  return (
    <div className="engagement-card">
      <h3>Engagement Rate</h3>
      <div className="engagement-ring">
        <CircularProgressbar
          value={rate}
          text={`${rate}%`}
          styles={buildStyles({
            pathColor: '#007bff',
            textColor: '#333',
            trailColor: '#eee',
            textSize: '18px',
          })}
        />
      </div>
      <p>{completed} of {assigned} surveys completed</p>
    </div>
  );
};

export default EngagementRateCard;
