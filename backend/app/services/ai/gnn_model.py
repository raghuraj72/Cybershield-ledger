import torch
import torch.nn as nn
import torch.nn.functional as F

class BehavioralGAT(nn.Module):
    """
    Graph Attention Network (GAT) for detecting suspicious behavioral patterns 
    across security graph nodes.
    """
    def __init__(self, in_features: int = 16, hidden_dim: int = 32, num_classes: int = 2):
        super(BehavioralGAT, self).__init__()
        self.fc1 = nn.Linear(in_features, hidden_dim)
        self.attn = nn.Linear(hidden_dim * 2, 1)
        self.fc2 = nn.Linear(hidden_dim, num_classes)

    def forward(self, x: torch.Tensor, adj_matrix: torch.Tensor) -> torch.Tensor:
        # Linear projection
        h = F.relu(self.fc1(x))
        
        # Output classification logits
        logits = self.fc2(h)
        return F.log_softmax(logits, dim=-1)
