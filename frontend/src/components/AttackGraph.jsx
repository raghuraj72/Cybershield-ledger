import React, { useEffect, useRef } from 'react';
import cytoscape from 'cytoscape';

const AttackGraph = ({ graphData }) => {
  const containerRef = useRef(null);

  useEffect(() => {
    if (!containerRef.current || !graphData) return;

    const cy = cytoscape({
      container: containerRef.current,
      elements: graphData,
      style: [
        {
          selector: 'node',
          style: {
            'background-color': '#00f0ff',
            'label': 'data(label)',
            'color': '#ffffff',
            'font-size': '12px',
            'text-valign': 'center',
            'text-halign': 'center',
            'width': '40px',
            'height': '40px'
          }
        },
        {
          selector: 'edge',
          style: {
            'width': 2,
            'line-color': '#ff0055',
            'target-arrow-color': '#ff0055',
            'target-arrow-shape': 'triangle',
            'curve-style': 'bezier',
            'label': 'data(label)',
            'color': '#a0a0a0',
            'font-size': '10px'
          }
        }
      ],
      layout: {
        name: 'breadthfirst',
        directed: true,
        padding: 10
      }
    });

    return () => cy.destroy();
  }, [graphData]);

  return (
    <div style={{ background: '#0a0a10', padding: '16px', borderRadius: '8px', border: '1px solid #1f1f2e' }}>
      <h3 style={{ color: '#00f0ff', marginTop: 0 }}>Temporal Attack Graph</h3>
      <div ref={containerRef} style={{ width: '100%', height: '350px' }} />
    </div>
  );
};

export default AttackGraph;
