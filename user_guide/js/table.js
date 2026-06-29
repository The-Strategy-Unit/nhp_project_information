function initDataTable(selector, data, columns) {
  new DataTable(selector, {
    data: data,
    columns: columns,
    pageLength: 25,
    order: [[0, "asc"]],
    scrollX: true,
    layout: {
      topStart: [
        {
          buttons: [
            {
              extend: 'csvHtml5',
              text: 'Download CSV'
            }
          ]
        },

      ],
      topEnd: "search",
      bottomStart: "info",
      bottomEnd: "paging"
    }
  });
}

function parseCsvFromUrl(csvUrl) {
  return new Promise((resolve, reject) => {
    Papa.parse(csvUrl, {
      download: true,
      header: true,
      dynamicTyping: false,
      skipEmptyLines: true,
      complete: function (results) {
        if (results.errors.length) {
          reject(results.errors);
          return;
        }

        resolve(results.data);
      },
      error: function (err) {
        reject(err);
      }
    });
  });
}

function flattenMechanisms(value, out = {}) {
  if (value === null || value === undefined) {
    return out;
  }

  if (Array.isArray(value)) {
    for (const item of value) {
      flattenMechanisms(item, out);
    }
    return out;
  }

  if (typeof value === "object") {
    for (const [key, nested] of Object.entries(value)) {
      if (nested !== null && typeof nested === "object") {
        flattenMechanisms(nested, out);
      } else {
        out[key] = nested;
      }
    }
  }

  return out;
}

function toTitleWithSingleUnderscoreReplacement(text) {
  const title = String(text || "")
    .toLowerCase()
    .replace(/\b\w/g, char => char.toUpperCase());

  return title.replace("_", " ");
}

function transformTpmasRows(lookupRows, mechanismsRaw) {
  const mechanisms = flattenMechanisms(mechanismsRaw);

  return lookupRows.map(row => {
    const activity = String(row.activity_type || "");
    const type = String(row.mitigator_type || "");
    const toValue = row.active_to;

    return {
      Code: row.mitigator_code,
      Activity: activity === "aae" ? "A&E" : activity.toUpperCase(),
      Type: toTitleWithSingleUnderscoreReplacement(type),
      Name: row.mitigator_name,
      Variable: row.mitigator_variable,
      Mechanism: mechanisms[row.mitigator_code],
      From: row.active_from,
      To: toValue === null || toValue === undefined || toValue === "" ? "-" : toValue
    };
  });
}

async function loadTpmasTable(
  selector,
  {
    lookupCsvUrl = "https://raw.githubusercontent.com/The-Strategy-Unit/TPMAs/refs/heads/main/reference/mitigator-lookup.csv",
    mechanismsJsonUrl = "https://raw.githubusercontent.com/The-Strategy-Unit/TPMAs/refs/heads/main/reference/mechanism-lookup.json"
  } = {}
) {
  try {
    const [lookupRows, mechanismsRaw] = await Promise.all([
      parseCsvFromUrl(lookupCsvUrl),
      fetch(mechanismsJsonUrl).then(response => {
        if (!response.ok) {
          throw new Error(`Failed to load mechanisms JSON (${response.status})`);
        }

        return response.json();
      })
    ]);

    const data = transformTpmasRows(lookupRows, mechanismsRaw);
    const columns = [
      { title: "Code", data: "Code" },
      { title: "Activity", data: "Activity" },
      { title: "Type", data: "Type" },
      { title: "Name", data: "Name" },
      { title: "Variable", data: "Variable" },
      { title: "Mechanism", data: "Mechanism" },
      { title: "From", data: "From" },
      { title: "To", data: "To" }
    ];

    initDataTable(selector, data, columns);
  } catch (err) {
    console.error("Failed to load TPMA table", err);
  }
}