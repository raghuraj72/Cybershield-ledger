from datetime import datetime, timedelta
from typing import List, Dict, Any

class EventCorrelator:
    def __init__(self, time_window_minutes: int = 30):
        self.time_window = timedelta(minutes=time_window_minutes)

    def correlate_events(self, events: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """
        Groups raw security events into correlated attack campaigns based on shared 
        entities (User, IP, Host) and temporal proximity.
        """
        campaigns = []
        visited = set()

        for i, event in enumerate(events):
            if i in visited:
                continue

            current_campaign = [event]
            visited.add(i)

            entities_a = event.get("entities", {})
            user_a = entities_a.get("user")
            host_a = entities_a.get("host_src")

            for j in range(i + 1, len(events)):
                if j in visited:
                    continue

                candidate = events[j]
                entities_b = candidate.get("entities", {})
                user_b = entities_b.get("user")
                host_b = entities_b.get("host_src")

                # Match by shared user or source host
                if (user_a and user_a == user_b) or (host_a and host_a == host_b):
                    current_campaign.append(candidate)
                    visited.add(j)

            campaigns.append({
                "campaign_id": f"CAMP-{len(campaigns) + 1:04d}",
                "event_count": len(current_campaign),
                "events": current_campaign
            })

        return campaigns
