import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import Homepage from './components/Homepage/Homepage';
import Login from './login/login';
import AdminDashboard from './AdminDashboard/AdminDashboard';
import UserDashboard from './UserDashboard/UserDashboard';
import RolesDashboard from './RolesDashboard/RolesDashboard';
import CreateSurvey from './CreateSurvey/CreateSurvey';
import ManageSurveys from './ManageSurvey/ManageSurveys'; 
import ViewSurvey from './ViewSurvey/ViewSurvey';
import ManageResponses from './MangeResponse/ManageResponses';
import SurveyForm from './SurveyForm/SurveyForm';
import Layout from './components/layouts/Layout';

function App() {
  return (
    <Routes>
     
      <Route path="/" element={<Homepage />} />
      <Route path="/login" element={<Login />} />

      <Route path="/admin-dashboard" element={<Layout><AdminDashboard /></Layout>} />
      <Route path="/user-dashboard" element={<Layout><UserDashboard /></Layout>} />
      <Route path="/roles-dashboard" element={<Layout><RolesDashboard /></Layout>} />
      <Route path="/create-survey" element={<Layout><CreateSurvey /></Layout>} /> 
      <Route path="/manage-surveys" element={<Layout><ManageSurveys /></Layout>} />
      <Route path="/survey/:id" element={<Layout><ViewSurvey /></Layout>} />
      <Route path="/manage-responses" element={<Layout><ManageResponses /></Layout>} />
      <Route path="/user-dashboard" element={<UserDashboard />} />
      <Route path="/survey-form/:surveyId" element={<SurveyForm />} />

      <Route path="*" element={<Navigate to="/login" />} />
    </Routes>
  );
}

export default App;
