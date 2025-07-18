import React, { useEffect, useState } from 'react';
import axios from 'axios';
import StatsCard from './StatsCard';
import SurveyBarChart from './SurveyBarChart';
import ParticipationPie from './ParticipationPie';
import QuestionTypeDonut from './QuestionTypeDonut';
import ScoreCard from './ScoreCard';
import TopSurveyProgress from './TopSurveyProgress'; 

import './dashboard.css';

const AdminDashboard = () => {
  const [stats, setStats] = useState({});
  const [responseData, setResponseData] = useState([]);
  const [participationData, setParticipationData] = useState([]);
  const [questionTypes, setQuestionTypes] = useState([]);
  const [engagementScore, setEngagementScore] = useState({
    percentage: 0,
    assigned: 0,
    responded: 0,
  });
  const [topSurveys, setTopSurveys] = useState([]);

  const [dateFilter, setDateFilter] = useState('7d');
  const [customRange, setCustomRange] = useState({ from: '', to: '' });

 
  const getDateParams = () => {
    if (dateFilter === 'custom' && customRange.from && customRange.to) {
      return {
        start_date: customRange.from,
        end_date: customRange.to,
      };
    } else if (dateFilter === '7d' || dateFilter === '30d') {
      const end = new Date().toISOString().split('T')[0];
      const start = new Date();
      start.setDate(dateFilter === '7d' ? start.getDate() - 6 : start.getDate() - 29);
      return {
        start_date: start.toISOString().split('T')[0],
        end_date: end,
      };
    }
    return {};
  };

  useEffect(() => {
    const fetchStats = async () => {
      try {
        const [empStatsRes, surveyRes, responseRes, questionRes] = await Promise.all([
          axios.get('http://localhost:5000/api/employees/assigned-vs-attended'),
          axios.get('http://localhost:5000/api/surveys'),
          axios.get('http://localhost:5000/api/responses/count'),
          axios.get('http://localhost:5000/api/questions/count'),
        ]);

        setStats({
          assignedEmployees: empStatsRes.data?.data?.assigned || 0,
          attendedEmployees: empStatsRes.data?.data?.attended || 0,
          totalSurveys: surveyRes.data?.data?.length || 0,
          totalResponses: responseRes.data?.data?.total || 0,
          totalQuestions: questionRes.data?.count || 0,
        });
      } catch (err) {
        console.error('Error fetching stat cards:', err);
      }
    };

    fetchStats();
  }, []);


  useEffect(() => {
    const fetchChartData = async () => {
      try {
        const params = getDateParams();

        const [barRes, pieRes, donutRes] = await Promise.all([
          axios.get('http://localhost:5000/api/survey/response-counts', { params }),
          axios.get('http://localhost:5000/api/participation/combined', { params }),
          axios.get('http://localhost:5000/api/questions/type-distribution', { params }),
        ]);

        if (barRes.data.status === 'success') setResponseData(barRes.data.data);

        if (pieRes.data.status === 'success') {
          setParticipationData({
            submitted: pieRes.data.data.submitted,
            notSubmitted: pieRes.data.data.notSubmitted,
          });
        }

        if (donutRes.data.status === 'success') {
          setQuestionTypes(donutRes.data.data);
        }

      
        try {
          const topRes = await axios.get('http://localhost:5000/api/surveys/top-performing', { params });
          if (topRes.data.status === 'success') {
            setTopSurveys(topRes.data.data);
          } else {
            setTopSurveys([]);
            console.warn('Top survey response not success');
          }
        } catch (err) {
          setTopSurveys([]);
          console.error('Top survey fetch failed:', err.message);
        }
      } catch (err) {
        console.error('Error fetching chart data:', err);
      }
    };

    fetchChartData();
  }, [dateFilter, customRange]);

  useEffect(() => {
    const fetchEngagementScore = async () => {
      try {
        const res = await axios.get('http://localhost:5000/api/employee/engagement-score');
        if (res.data.status === 'success') {
          setEngagementScore({
            percentage: res.data.data.engagementPercentage,
            assigned: res.data.data.assigned,
            responded: res.data.data.responded,
          });
        }
      } catch (err) {
        console.error('Error fetching engagement score:', err);
      }
    };

    fetchEngagementScore();
  }, []);

  return (
    <div className="admin-dashboard">
      <h2>📊 Admin Dashboard</h2>

      <div className="filter-card">
        <div className="filter-row">
          <label>📅 Filter by Survey Created Date:</label>
          <select value={dateFilter} onChange={(e) => setDateFilter(e.target.value)}>
            <option value="all">All Time</option>
            <option value="7d">Last 7 Days</option>
            <option value="30d">Last 30 Days</option>
            <option value="custom">Custom Range</option>
          </select>
        </div>

        {dateFilter === 'custom' && (
          <div className="custom-date-range">
            <label>From:</label>
            <input
              type="date"
              value={customRange.from}
              onChange={(e) => setCustomRange({ ...customRange, from: e.target.value })}
            />
            <label>To:</label>
            <input
              type="date"
              value={customRange.to}
              onChange={(e) => setCustomRange({ ...customRange, to: e.target.value })}
            />
          </div>
        )}
      </div>

    
      <div className="card-grid">
        <StatsCard title="Assigned Employees" value={stats.assignedEmployees} gradient="linear-gradient(135deg, #7b61ff, #b892ff)" />
        <StatsCard title="Attended Employees" value={stats.attendedEmployees} gradient="linear-gradient(135deg, #4caf50, #81c784)" />
        <StatsCard title="Total Surveys" value={stats.totalSurveys} gradient="linear-gradient(135deg, #ffa726, #ffcc80)" />
        <StatsCard title="Total Responses" value={stats.totalResponses} gradient="linear-gradient(135deg, #26c6da, #80deea)" />
        <StatsCard title="Total Questions" value={stats.totalQuestions} gradient="linear-gradient(135deg, #f06292, #f8bbd0)" />
      </div>

      <div className="dashboard-charts">
        <div className="chart-box">
          <h4>Overall Participation</h4>
          <div className="chart-card-scroll">
            <ParticipationPie data={participationData} />
          </div>
        </div>

        <div className="chart-box">
          <h4>Question Types</h4>
          <div className="chart-card-scroll">
            <QuestionTypeDonut data={questionTypes} />
          </div>
        </div>

        <div className="chart-box">
          <h4>Employee Engagement</h4>
          <div className="chart-card-scroll">
            <ScoreCard
              percentage={engagementScore.percentage}
              assigned={engagementScore.assigned}
              responded={engagementScore.responded}
            />
          </div>
        </div>
      </div>

      <div className="dashboard-charts">
        <div className="chart-box full-width-chart">
          <h4>Responses Per Survey</h4>
          <div className="chart-card-scroll">
            <SurveyBarChart data={responseData} />
          </div>
        </div>

        {topSurveys.length > 0 && (
          <div className="chart-box full-width-chart">
            <h4>Top Performing Surveys</h4>
            <div className="chart-card-scroll">
              <TopSurveyProgress data={topSurveys} />
            </div>
          </div>
        )}
      </div>
    </div>
  );
};

export default AdminDashboard;
