function initTable() {
  const selector = "#assumptions-table";

  return fetch("assumptions.json")
    .then(response => {
      if (!response.ok) {
        throw new Error(`Failed to load assumptions JSON (${response.status})`);
      }

      return response.json();
    })
    .then(rows => {
      const data = rows.map(row => {
        const risk = calcRisk(row.quality, row.impact);
        return {
          id: row.id,
          description: `<a href="${row.link}">${row.description}</a>`,
          quality: `<div class="tag status-${row.quality}">${row.quality}</div>`,
          impact: `<div class="tag status-${row.impact}">${row.impact}</div>`,
          risk: `<div class="tag status-${risk}">${risk}</div>`
        };
      });
      const columns = [
        { data: "id", title: "ID" },
        { data: "description", title: "Description" },
        { data: "quality", title: "Quality" },
        { data: "impact", title: "Impact" },
        { data: "risk", title: "Risk" }
      ];

      new DataTable(selector, {
        data: data,
        columns: columns,
        pageLength: 25,
        order: [],
        scrollX: true,
        layout: {
          topStart: "",
          topEnd: "",
          bottomStart: "",
          bottomEnd: ""
        }
      });
    });
}


function calcRisk(quality, impact) {
  if (quality === "poor") {
    if (impact === "low") {
      return "medium";
    } else {
      return "high";
    }
  } else if (quality === "excellent" && impact === "high") {
    return "medium";
  }
  return impact;
}