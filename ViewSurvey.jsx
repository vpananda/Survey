import React, { useEffect, useState } from 'react';
import '../styles/ViewSurvey.css';

const ViewSurveyModal = ({ surveyId, onClose }) => {
  const [survey, setSurvey] = useState(null);

  useEffect(() => {
    fetch(`http://localhost:5000/api/survey/${surveyId}`)
      .then(res => res.json())
      .then(data => {
        if (data.status === 'success') setSurvey(data.data);
      });
  }, [surveyId]);

  if (!survey) return null;

  return (
    <div className="view-modal-overlay">
      <div className="view-modal">
        <h3>{survey.SurveyName}</h3>
        <p className="description">{survey.Description}</p>
        <p><strong>Start:</strong> {survey.StartDate}</p>
        <p><strong>End:</strong> {survey.EndDate}</p>

        <div className="questions">
          {survey.Questions.map((q, idx) => {
            const type = q.QuestionType?.toLowerCase().replaceAll(' ', '_');
            const options = q.Options ? q.Options.split(',') : [];

            return (
              <div className="question-block" key={idx}>
                <label>{idx + 1}. {q.QuestionText}</label>

                {type === 'short_answer' && (
                  <input type="text" disabled placeholder="Short answer" />
                )}

                {type === 'paragraph' && (
                  <textarea disabled placeholder="Long answer" />
                )}

                {(type === 'mcq' || type === 'multiple_choice') && options.map((opt, i) => (
                  <div key={i}><input type="radio" disabled /> {opt.trim()}</div>
                ))}

                {type === 'checkboxes' && options.map((opt, i) => (
                  <div key={i}><input type="checkbox" disabled /> {opt.trim()}</div>
                ))}

                {type === 'dropdown' && (
                  <select disabled>
                    {options.map((opt, i) => (
                      <option key={i}>{opt.trim()}</option>
                    ))}
                  </select>
                )}

                {type === 'rating' && (
                  <div className="stars">
                    {[1, 2, 3, 4, 5].map(num => <span key={num}>⭐</span>)}
                  </div>
                )}

                {type === 'date' && (
                  <input type="date" disabled />
                )}

                {type === 'time' && (
                  <input type="time" disabled />
                )}

                {type === 'file' && (
                  <input type="file" disabled />
                )}
              </div>
            );
          })}
        </div>

        <div className="modal-actions">
          <button onClick={onClose} className="close-btn">Close</button>
        </div>
      </div>
    </div>
  );
};

export default ViewSurveyModal;
