import React from 'react';

const STAGES = [
  "Initial Access", "Execution", "Persistence", 
  "Privilege Escalation", "Lateral Movement", 
  "Collection", "Exfiltration"
];

const KillChainDAG = ({ currentStage }) => {
  const currentIndex = STAGES.indexOf(currentStage);

  return (
    <div style={{ background: '#0a0a10', padding: '16px', borderRadius: '8px', border: '1px solid #1f1f2e', color: '#fff' }}>
      <h3 style={{ color: '#00f0ff', marginTop: 0 }}>Kill-Chain Attack Journey</h3>
      <div style={{ display: 'flex', gap: '8px', overflowX: 'auto', padding: '8px 0' }}>
        {STAGES.map((stage, idx) => {
          const isPassed = idx < currentIndex;
          const isCurrent = idx === currentIndex;

          let color = '#2a2a3c';
          if (isPassed) color = '#00ff88';
          if (isCurrent) color = '#ff0055';

          return (
            <div key={stage} style={{
              flex: '1',
              minWidth: '110px',
              padding: '10px',
              borderRadius: '6px',
              background: color,
              textAlign: 'center',
              fontSize: '11px',
              fontWeight: 'bold',
              color: isPassed || isCurrent ? '#000' : '#888'
            }}>
              {stage}
            </div>
          );
        })}
      </div>
    </div>
  );
};

export default KillChainDAG;
