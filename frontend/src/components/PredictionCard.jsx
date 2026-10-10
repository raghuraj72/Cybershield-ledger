import React from 'react';

const PredictionCard = ({ predictionData }) => {
  if (!predictionData) return null;

  const { current_stage, next_stage_prediction, confidence } = predictionData;

  return (
    <div style={{ background: '#0a0a10', padding: '16px', borderRadius: '8px', border: '1px solid #1f1f2e', color: '#fff' }}>
      <h3 style={{ color: '#00f0ff', marginTop: 0 }}>AI Attack Stage Prediction</h3>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <div>
          <p style={{ margin: '4px 0', color: '#888' }}>Current Stage:</p>
          <p style={{ margin: 0, fontWeight: 'bold', color: '#ff0055' }}>{current_stage}</p>
        </div>
        <div>
          <p style={{ margin: '4px 0', color: '#888' }}>Predicted Next Stage:</p>
          <p style={{ margin: 0, fontWeight: 'bold', color: '#00ff88' }}>{next_stage_prediction}</p>
        </div>
        <div>
          <p style={{ margin: '4px 0', color: '#888' }}>Confidence:</p>
          <p style={{ margin: 0, fontWeight: 'bold', color: '#00f0ff' }}>{(confidence * 100).toFixed(0)}%</p>
        </div>
      </div>
    </div>
  );
};

export default PredictionCard;
