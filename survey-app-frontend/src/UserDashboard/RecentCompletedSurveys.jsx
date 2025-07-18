import React from 'react';
import {
  BarChart,
  Bar,
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
  LabelList
} from 'recharts';
import './userdashboard.css';

const RecentCompletedSurveys = ({ surveys }) => {
  const formattedData = surveys
    .map(s => ({
      survey_name: s.surveyName,
      completion_date: new Date(s.submittedDate).toLocaleDateString('en-IN', {
        day: '2-digit',
        month: 'short',
        year: 'numeric'
      }),
      value: 1
    }))
    .sort((a, b) => new Date(b.submittedDate) - new Date(a.submittedDate));

  return (
    <div className="recent-completed">
      {surveys.length === 0 ? (
        <p className="no-data">No surveys completed yet.</p>
      ) : (
        <ResponsiveContainer width="100%" height={300}>
          <BarChart
            layout="vertical"
            data={formattedData}
            margin={{ top: 20, right: 100, left: 100, bottom: 20 }}
          >
            <XAxis type="number" hide />
            <YAxis
              type="category"
              dataKey="survey_name"
              tick={{ fontSize: 14 }}
              width={150}
            />
            <Tooltip
              formatter={(value, name, props) =>
                [`Completed on ${props.payload.completion_date}`, '']
              }
            />
            <Bar dataKey="value" fill="#4F6BED" barSize={25}>
              <LabelList dataKey="completion_date" position="right" style={{ fontSize: 12 }} />
            </Bar>
          </BarChart>
        </ResponsiveContainer>
      )}
    </div>
  );
};

export default RecentCompletedSurveys;
