import React, { useState } from 'react';
import '../styles/CreateSurvey.css';

const CreateSurvey = () => {
  const [surveyTitle, setSurveyTitle] = useState('');
  const [surveyDesc, setSurveyDesc] = useState('');
  const [startDate, setStartDate] = useState('');
  const [endDate, setEndDate] = useState('');
  const [questions, setQuestions] = useState([
    {
      questionText: '',
      questionType: 'short_answer',
      options: [],
      optionInput: '',
      ratingValue: 0,
      rows: 3,
      columns: 3,
    },
  ]);

  const handleAddOption = (index, e) => {
    if (e.key === 'Enter' && e.target.value.trim() !== '') {
      const updated = [...questions];
      updated[index].options.push(e.target.value.trim());
      updated[index].optionInput = '';
      setQuestions(updated);
    }
  };

  const handleRemoveOption = (qIdx, oIdx) => {
    const updated = [...questions];
    updated[qIdx].options.splice(oIdx, 1);
    setQuestions(updated);
  };

  const handleRatingSelect = (qIdx, value) => {
    const updated = [...questions];
    updated[qIdx].ratingValue = value;
    setQuestions(updated);
  };

  const handleRemoveQuestion = (index) => {
    const updated = [...questions];
    updated.splice(index, 1);
    setQuestions(updated);
  };

  const handleAddQuestion = () => {
    setQuestions([
      ...questions,
      {
        questionText: '',
        questionType: 'short_answer',
        options: [],
        optionInput: '',
        ratingValue: 0,
        rows: 3,
        columns: 3,
      },
    ]);
  };

  const handleCreateSurvey = () => {
    if (!surveyTitle || !startDate || !endDate || questions.length === 0) {
      alert("Please fill all required fields and at least one question.");
      return;
    }

    const payload = {
      SurveyName: surveyTitle,
      Description: surveyDesc,
      StartDate: startDate,
      EndDate: endDate,
      CreatedBy: 1, 
      Questions: questions.map(q => ({
      QuestionText: q.questionText,
      QuestionType: q.questionType,
      Options: q.options.join(',') 
  }))
};

    fetch('http://127.0.0.1:5000/api/survey/create', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    })
      .then(res => res.json())
      .then(data => {
        alert(data.message || 'Survey created successfully!');
        // Reset form
        setSurveyTitle('');
        setSurveyDesc('');
        setStartDate('');
        setEndDate('');
        setQuestions([
          {
            questionText: '',
            questionType: 'short_answer',
            options: [],
            optionInput: '',
            ratingValue: 0,
            rows: 3,
            columns: 3,
          },
        ]);
      })
      .catch(err => {
        console.error("Survey creation failed:", err);
        alert("Survey creation failed.");
      });
  };

  const renderInputType = (q, idx) => {
    switch (q.questionType) {
      case 'short_answer':
        return <input className="input-field" type="text" placeholder="Short answer text" disabled />;
      case 'paragraph':
        return <textarea className="input-field" rows="3" placeholder="Long answer text" disabled />;
      case 'multiple_choice':
      case 'checkboxes':
        return (
          <>
            <div className="option-list">
              {q.options.map((opt, i) => (
                <div key={i} className="option-item">
                  <label>
                    <input type={q.questionType === 'multiple_choice' ? 'radio' : 'checkbox'} disabled />
                    {opt}
                  </label>
                  <button className="opt-remove" onClick={() => handleRemoveOption(idx, i)}>✕</button>
                </div>
              ))}
            </div>
            <input
              className="input-field"
              placeholder="Add option"
              value={q.optionInput}
              onChange={(e) => {
                const updated = [...questions];
                updated[idx].optionInput = e.target.value;
                setQuestions(updated);
              }}
              onKeyDown={(e) => handleAddOption(idx, e)}
            />
          </>
        );
      case 'dropdown':
        return (
          <select className="input-field">
            {q.options.map((opt, i) => <option key={i}>{opt}</option>)}
          </select>
        );
      case 'file':
        return <input className="input-field" type="file" />;
      case 'linear_scale':
        return (
          <div className="scale-row">
            {[1, 2, 3, 4, 5].map((n) => (
              <label key={n}><input type="radio" name={`scale-${idx}`} disabled /> {n}</label>
            ))}
          </div>
        );
      case 'rating':
        return (
          <div className="stars">
            {[1, 2, 3, 4, 5].map((star) => (
              <span
                key={star}
                onClick={() => handleRatingSelect(idx, star)}
                className={star <= q.ratingValue ? 'active-star' : ''}
              >
                ⭐
              </span>
            ))}
          </div>
        );
      case 'multiple_choice_grid':
      case 'checkbox_grid':
        return (
          <table className="grid-table">
            <thead>
              <tr>
                <th></th>
                {Array.from({ length: q.columns }).map((_, colIdx) => (
                  <th key={colIdx}>Col {colIdx + 1}</th>
                ))}
              </tr>
            </thead>
            <tbody>
              {Array.from({ length: q.rows }).map((_, rowIdx) => (
                <tr key={rowIdx}>
                  <td>Row {rowIdx + 1}</td>
                  {Array.from({ length: q.columns }).map((_, colIdx) => (
                    <td key={colIdx}>
                      <input
                        type={q.questionType === 'multiple_choice_grid' ? 'radio' : 'checkbox'}
                        name={`grid-${idx}-row-${rowIdx}`}
                        disabled
                      />
                    </td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
        );
      case 'date':
        return <input className="input-field" type="date" />;
      case 'time':
        return <input className="input-field" type="time" />;
      default:
        return null;
    }
  };

  return (
    <div className="create-survey-container">
      <h2>Create New Survey</h2>
      <input
        className="input-field"
        placeholder="Survey Title"
        value={surveyTitle}
        onChange={(e) => setSurveyTitle(e.target.value)}
      />
      <textarea
        className="input-field"
        placeholder="Survey description"
        value={surveyDesc}
        onChange={(e) => setSurveyDesc(e.target.value)}
      />
      <div className="date-row">
        <label>Start Date:<input type="date" value={startDate} onChange={(e) => setStartDate(e.target.value)} /></label>
        <label>End Date:<input type="date" value={endDate} onChange={(e) => setEndDate(e.target.value)} /></label>
      </div>
      {questions.map((q, idx) => (
        <div key={idx} className="question-card">
          <input
            className="input-field"
            placeholder="Question"
            value={q.questionText}
            onChange={(e) => {
              const updated = [...questions];
              updated[idx].questionText = e.target.value;
              setQuestions(updated);
            }}
          />
          <select
            className="question-select"
            value={q.questionType}
            onChange={(e) => {
              const updated = [...questions];
              updated[idx].questionType = e.target.value;
              updated[idx].options = [];
              updated[idx].ratingValue = 0;
              setQuestions(updated);
            }}
          >
            <option value="short_answer">Short answer</option>
            <option value="paragraph">Paragraph</option>
            <option value="multiple_choice">Multiple choice</option>
            <option value="checkboxes">Checkboxes</option>
            <option value="dropdown">Dropdown</option>
            <option value="file">File upload</option>
            <option value="linear_scale">Linear scale</option>
            <option value="rating">Rating</option>
            <option value="multiple_choice_grid">Multiple choice grid</option>
            <option value="checkbox_grid">Checkbox grid</option>
            <option value="date">Date</option>
            <option value="time">Time</option>
          </select>
          {renderInputType(q, idx)}
          <button className="remove-btn" onClick={() => handleRemoveQuestion(idx)}>Remove question</button>
        </div>
      ))}
      <div className="button-row">
        <button className="btn add-btn" onClick={handleAddQuestion}>+ Add Question</button>
        <button className="btn create-btn" onClick={handleCreateSurvey}>Create Survey</button>
      </div>
    </div>
  );
};

export default CreateSurvey;
