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
      const escapeHtml = value => String(value ?? "").replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#39;");
      const safeHref = href => (/^javascript:/i.test(String(href ?? "").trim()) ? "#" : String(href ?? "").trim());

      const data = rows.map(row => {
        const quality = String(row.quality ?? "").toLowerCase();
        const impact = String(row.impact ?? "").toLowerCase();
        const risk = calcRisk(quality, impact);
        return { id: row.id, description: String(row.description ?? ""), link: safeHref(row.link), quality, impact, risk };
      });
      const columns = [
        { data: "id", title: "ID" },
        { data: "description", title: "Description", render: (data, type, row) => type === "display" ? `<a href="${escapeHtml(row.link)}" target="_blank" rel="noopener noreferrer">${escapeHtml(data)}</a>` : data },
        { data: "quality", title: "Quality", render: (data, type) => type === "display" ? `<div class="tag status-${escapeHtml(data)}">${escapeHtml(data)}</div>` : data },
        { data: "impact", title: "Impact", render: (data, type) => type === "display" ? `<div class="tag status-${escapeHtml(data)}">${escapeHtml(data)}</div>` : data },
        { data: "risk", title: "Risk", render: (data, type) => type === "display" ? `<div class="tag status-${escapeHtml(data)}">${escapeHtml(data)}</div>` : data }
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