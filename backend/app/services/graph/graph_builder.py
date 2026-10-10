import networkx as nx
from typing import Dict, List, Any

class TemporalAttackGraph:
    def __init__(self):
        self.graph = nx.DiGraph()

    def add_telemetry_event(self, event: Dict[str, Any]):
        """
        Ingests a normalized security event and builds weighted temporal edges.
        """
        entities = event.get("entities", {})
        user = entities.get("user")
        host_src = entities.get("host_src")
        host_dst = entities.get("host_dst")
        process = entities.get("process_name")
        timestamp = event.get("timestamp")
        event_type = event.get("event_type")

        # Create nodes
        if host_src:
            self.graph.add_node(host_src, type="Host")
        if host_dst:
            self.graph.add_node(host_dst, type="Host")
        if user:
            self.graph.add_node(user, type="User")
        if process:
            self.graph.add_node(process, type="Process")

        # Create temporal relationships (edges)
        if host_src and process:
            self.graph.add_edge(host_src, process, relation="EXECUTES", timestamp=timestamp, type=event_type)
        if user and host_src:
            self.graph.add_edge(user, host_src, relation="AUTHENTICATES", timestamp=timestamp, type=event_type)
        if host_src and host_dst:
            self.graph.add_edge(host_src, host_dst, relation="LATERAL_CONNECT", timestamp=timestamp, type=event_type)

    def export_cytoscape_format(self) -> List[Dict[str, Any]]:
        """
        Formats graph nodes and edges for Cytoscape.js frontend visualization.
        """
        elements = []
        for node, data in self.graph.nodes(data=True):
            elements.append({"data": {"id": node, "label": node, "type": data.get("type", "Entity")}})
        
        for u, v, data in self.graph.edges(data=True):
            elements.append({
                "data": {
                    "source": u,
                    "target": v,
                    "label": data.get("relation", "CONNECTED"),
                    "timestamp": data.get("timestamp")
                }
            })
        return elements
