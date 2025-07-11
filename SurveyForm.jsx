import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import '../styles/SurveyForm.css';
const SurveyForm = () => {
  const { surveyId } = useParams();
  const employeeId = localStorage.getItem('employeeId');
  const navigate = useNavigate();
  const [questions, setQuestions] = useState([]);
  const [answers, setAnswers] = useState({});
  const [status, setStatus] = useState('');
  const [surveyTitle, setSurveyTitle] = useState('');

  useEffect(() => {
    if (!employeeId || !surveyId) return;

    fetch(`http://127.0.0.1:5000/api/user/survey/${surveyId}/responses/${employeeId}`)
      .then(res => res.json())
      .then(data => {
        if (!data || !data.questions || !Array.isArray(data.questions)) return;
        setQuestions(data.questions);
        setStatus(data.status || '');
        setSurveyTitle(data.survey_name || 'Survey');
        const prefilled = {};
        data.questions.forEach(q => {
          if (q.submitted_answer) {
            try {
              prefilled[q.question_id] = JSON.parse(q.submitted_answer);
            } catch {
              prefilled[q.question_id] = q.submitted_answer;
            }
          }
        });
        setAnswers(prefilled);
      })
      .catch(err => console.error('Error loading survey:', err));
  }, [surveyId, employeeId]);

  const handleChange = (questionId, value) => {
    setAnswers(prev => ({ ...prev, [questionId]: value }));
  };

  const handleSave = (type) => {
    const endpoint = type === 'draft' ? '/api/user/save-draft' : '/api/user/submit-survey';
    const payload = {
      employee_id: employeeId,
      survey_id: surveyId,
      answers: {}
    };

    for (const [qid, val] of Object.entries(answers)) {
      payload.answers[qid] = Array.isArray(val) ? JSON.stringify(val) : val;
    }

    fetch(`http://127.0.0.1:5000${endpoint}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    })
      .then(res => res.json())
      .then(data => {
        alert(data.message || 'Saved successfully');
        if (type === 'submit') navigate('/user-dashboard');
      })
      .catch(err => alert('Error saving responses'));
  };

  if (!employeeId || !surveyId) return <p>Missing user or survey information.</p>;
  if (!questions.length) return <p>Loading questions...</p>;

  return (
    <div className="survey-form-container">
      <div className="survey-form-header">
        <h2>{surveyTitle}</h2>
        <button onClick={() => navigate('/user-dashboard')} className="back-button">
          ← Back
        </button>
      </div>

      {questions.map(q => (
        <div key={q.question_id} className="question-block">
          <p>{q.question_text}</p>
          {Array.isArray(q.options) && q.options.length > 0 ? (
            q.options.map(opt => (
              <label key={opt}>
                <input
                  type="radio"
                  name={q.question_id}
                  value={opt}
                  disabled={status === 'submitted'}
                  checked={answers[q.question_id] === opt}
                  onChange={() => handleChange(q.question_id, opt)}
                />{' '}{opt}
              </label>
            ))
          ) : (
            <textarea
              className="question-textarea"
              rows="4"
              value={answers[q.question_id] || ''}
              onChange={(e) => handleChange(q.question_id, e.target.value)}
              disabled={status === 'submitted'}
              placeholder="Your answer..."
            />
          )}
        </div>
      ))}

      {status !== 'submitted' && (
        <div className="submit-controls">
          <button onClick={() => handleSave('draft')}>Save Draft</button>
          <button onClick={() => handleSave('submit')}>Submit</button>
        </div>
      )}

      {status === 'submitted' && (
        <p className="status-note">
          This survey has already been submitted. You can only view your answers.
        </p>
      )}
    </div>
  );
};

export default SurveyForm;
